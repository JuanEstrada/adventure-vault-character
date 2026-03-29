#!/usr/bin/env python3
"""Route AI tasks to stage-appropriate models from the project playbook.

This script automates model selection based on the workflow in:
docs/project/playbooks/AI_MODEL_PLAYBOOK.md

It can also execute a user-provided runner command template so stage-to-model
routing is automatic in daily usage.
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, Optional


DEFAULT_MODELS: Dict[str, str] = {
    "discovery": "o3",
    "implementation": "gpt-5.3-codex",
    "validation": "gpt-5.3-codex",
    "quick": "gpt-5.3-mini",
}


AUTO_KEYWORDS = {
    "discovery": {
        "design",
        "architecture",
        "plan",
        "risk",
        "migration",
        "boundary",
        "approach",
    },
    "validation": {
        "test",
        "validate",
        "verification",
        "regression",
        "analyze",
        "lint",
        "check",
        "qa",
    },
    "quick": {
        "rename",
        "small",
        "trivial",
        "quick",
        "minor",
        "docs only",
    },
}


@dataclass(frozen=True)
class RouterConfig:
    models: Dict[str, str]
    default_runner_template: Optional[str]
    stage_runner_templates: Dict[str, str]


def _parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Route a task to the correct AI model by stage."
    )
    parser.add_argument(
        "--stage",
        choices=["auto", "discovery", "implementation", "validation", "quick"],
        default="auto",
        help="Workflow stage. Use auto to infer from task text.",
    )
    parser.add_argument(
        "--task",
        help="Task text to route.",
    )
    parser.add_argument(
        "--task-file",
        help="Read task text from file path.",
    )
    parser.add_argument(
        "--config",
        help="Optional JSON config file for models/templates.",
    )
    parser.add_argument(
        "--runner-template",
        help=(
            "Command template used to execute the selected model. "
            "Placeholders: {model}, {stage}, {task_file}, {task}."
        ),
    )
    parser.add_argument(
        "--execute",
        action="store_true",
        help="Execute the command instead of only printing routing output.",
    )
    return parser.parse_args()


def _read_task(task: Optional[str], task_file: Optional[str]) -> str:
    if task and task_file:
        raise ValueError("Use either --task or --task-file, not both.")
    if task:
        value = task.strip()
        if value:
            return value
        raise ValueError("--task is empty.")
    if task_file:
        path = Path(task_file)
        if not path.exists():
            raise ValueError(f"Task file not found: {path}")
        value = path.read_text(encoding="utf-8").strip()
        if value:
            return value
        raise ValueError(f"Task file is empty: {path}")
    raise ValueError("Provide --task or --task-file.")


def _load_config(config_path: Optional[str]) -> RouterConfig:
    models = dict(DEFAULT_MODELS)
    default_runner_template = os.getenv("AVC_AI_RUNNER_TEMPLATE")
    stage_runner_templates: Dict[str, str] = {}

    for stage in DEFAULT_MODELS:
        key = f"AVC_AI_RUNNER_{stage.upper()}"
        value = os.getenv(key)
        if value:
            stage_runner_templates[stage] = value

    if not config_path:
        return RouterConfig(
            models=models,
            default_runner_template=default_runner_template,
            stage_runner_templates=stage_runner_templates,
        )

    path = Path(config_path)
    if not path.exists():
        raise ValueError(f"Config file not found: {path}")

    try:
        config = json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        raise ValueError(f"Invalid JSON in config file: {path}\n{exc}") from exc

    file_models = config.get("models", {})
    if isinstance(file_models, dict):
        for stage, model in file_models.items():
            if stage in models and isinstance(model, str) and model.strip():
                models[stage] = model.strip()

    if isinstance(config.get("runner_template"), str):
        default_runner_template = config["runner_template"].strip()

    file_stage_templates = config.get("stage_runner_templates", {})
    if isinstance(file_stage_templates, dict):
        for stage, template in file_stage_templates.items():
            if stage in models and isinstance(template, str) and template.strip():
                stage_runner_templates[stage] = template.strip()

    return RouterConfig(
        models=models,
        default_runner_template=default_runner_template,
        stage_runner_templates=stage_runner_templates,
    )


def _infer_stage(task: str) -> str:
    lowered = task.lower()
    for stage in ("discovery", "validation", "quick"):
        for keyword in AUTO_KEYWORDS[stage]:
            if keyword in lowered:
                return stage
    return "implementation"


def _resolve_stage(input_stage: str, task: str) -> str:
    if input_stage != "auto":
        return input_stage
    return _infer_stage(task)


def _resolve_runner_template(
    stage: str,
    explicit_template: Optional[str],
    config: RouterConfig,
) -> Optional[str]:
    if explicit_template:
        return explicit_template
    if stage in config.stage_runner_templates:
        return config.stage_runner_templates[stage]
    return config.default_runner_template


def _build_command(
    template: str,
    *,
    model: str,
    stage: str,
    task: str,
    task_file: str,
) -> str:
    return template.format(
        model=model,
        stage=stage,
        task=task,
        task_file=task_file,
    )


def _write_temp_task_file(task: str) -> str:
    temp_dir = Path(tempfile.gettempdir())
    file_path = temp_dir / "avc_ai_router_task.txt"
    file_path.write_text(task, encoding="utf-8")
    return str(file_path)


def main() -> int:
    try:
        args = _parse_args()
        task = _read_task(args.task, args.task_file)
        config = _load_config(args.config)
        stage = _resolve_stage(args.stage, task)
        model = config.models[stage]

        print(f"Stage: {stage}")
        print(f"Model: {model}")

        template = _resolve_runner_template(stage, args.runner_template, config)
        if not template:
            print(
                "No runner template configured.\n"
                "Set AVC_AI_RUNNER_TEMPLATE or pass --runner-template.\n"
                "Example template:\n"
                '  opencode run --model "{model}" --prompt-file "{task_file}"'
            )
            return 0

        task_path = _write_temp_task_file(task)
        command = _build_command(
            template,
            model=model,
            stage=stage,
            task=task,
            task_file=task_path,
        )

        print("Command:")
        print(command)

        if not args.execute:
            print("Dry run only. Re-run with --execute to run the command.")
            return 0

        completed = subprocess.run(command, shell=True, check=False)
        return completed.returncode
    except ValueError as exc:
        print(f"Error: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
