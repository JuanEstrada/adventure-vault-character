# AI Model Playbook

This playbook standardizes model selection for everyday work in
Adventure Vault Character.

## Goal

Pick the right model per stage so architecture quality, implementation speed,
and regression safety stay balanced.

## Default Workflow (Recommended)

1. Diagnose and plan with a deep-reasoning model (`o3` family).
2. Implement and refactor with a coding-focused model (`gpt-5.3-codex`).
3. Validate and fix regressions with the same coding-focused model.
4. Use a faster lightweight model (`mini` family) for small repetitive tasks.

## Stage-by-Stage Routing

### Stage 1: Discovery and architecture planning

- **Model**: Deep reasoning (`o3` family).
- **Use for**:
  - boundary design across `domain`, `application`, `data`, and `presentation`
  - migration strategies (Drift schema evolution, compatibility concerns)
  - risk analysis before touching large or cross-feature flows
- **Deliverable**:
  - short implementation plan
  - explicit risk list
  - test impact list

### Stage 2: Main implementation

- **Model**: `gpt-5.3-codex`.
- **Use for**:
  - Dart and Flutter code edits
  - feature implementation and targeted refactors
  - repository/service wiring and test updates
- **Deliverable**:
  - code changes aligned with layer boundaries
  - tests added or updated near changed behavior

### Stage 3: Technical QA and stabilization

- **Model**: `gpt-5.3-codex`.
- **Use for**:
  - running and fixing `flutter analyze`
  - running and fixing `flutter test`
  - final cleanup before commit/PR
- **Deliverable**:
  - green analysis and tests
  - concise summary of what changed and why

### Stage 4: Fast low-risk tasks

- **Model**: lightweight (`mini` family).
- **Use for**:
  - simple documentation edits
  - rename-only or formatting-only changes
  - quick command checks and status reporting
- **Do not use as primary model for**:
  - architecture-level decisions
  - non-trivial rules logic
  - multi-file refactors with coupling risk

## Quick Selector

- If the task changes system structure, choose `o3` first.
- If the task changes production code behavior, use `gpt-5.3-codex`.
- If the task is mostly text or repetitive cleanup, use `mini`.
- If uncertain, start with `gpt-5.3-codex` and escalate to `o3` when trade-offs
  become unclear.

## Automatic Routing Script

Use `tool/ai_model_router.py` to automate stage-based model selection.

### What it does

- infers stage (`discovery`, `implementation`, `validation`, `quick`) or uses
  explicit `--stage`
- picks the model using this playbook defaults
- can run a configured command template that starts the target model

### Basic usage

```bash
python tool/ai_model_router.py --task "Plan warlock spellbook edge cases"
python tool/ai_model_router.py --stage implementation --task-file task.txt
python tool/ai_model_router.py --stage validation --task "Run analyze/test and fix" --execute
```

### Configure command execution

Set a runner template so `--execute` can launch your CLI automatically:

```powershell
setx AVC_AI_RUNNER_TEMPLATE "opencode run --model \"{model}\" --prompt-file \"{task_file}\""
```

You can also provide stage-specific templates:

- `AVC_AI_RUNNER_DISCOVERY`
- `AVC_AI_RUNNER_IMPLEMENTATION`
- `AVC_AI_RUNNER_VALIDATION`
- `AVC_AI_RUNNER_QUICK`

Or use a config file (`--config`) based on
`tool/ai_model_router.example.json`.

### Note

Model switching happens across separate runs started by the runner command.
It does not hot-swap the model inside an already-running single session.

## Session Template

Use this sequence for a normal work session:

1. `o3` for a 10-15 minute plan (scope, risks, tests).
2. `gpt-5.3-codex` for implementation.
3. `gpt-5.3-codex` for `flutter analyze` and `flutter test` fixes.
4. `mini` for final docs or commit message polish.

## Prompt Starters

### 1) Discovery / planning prompt

```text
Analyze this Flutter + Drift task before coding.
Return: (1) boundary-safe plan, (2) risks, (3) tests to add/update,
(4) minimal viable implementation order.
Respect feature-first and clean layer boundaries.
```

### 2) Implementation prompt

```text
Implement the approved plan in small safe steps.
Keep business rules out of widgets and persistence details out of domain.
Update tests near changed behavior and summarize decisions.
```

### 3) QA prompt

```text
Run flutter analyze and flutter test.
Fix regressions without weakening architecture boundaries.
Return a concise change summary and remaining risks (if any).
```

### 4) Docs/polish prompt

```text
Polish docs and commit message text from the completed implementation.
Keep wording concise, precise, and aligned with repository terminology.
```

## Guardrails

- Never trade architecture boundaries for short-term speed.
- For rules changes, prioritize deterministic tests over UI checks.
- For schema changes, verify migration behavior explicitly.
- Keep docs synchronized when scope or behavior changes.
