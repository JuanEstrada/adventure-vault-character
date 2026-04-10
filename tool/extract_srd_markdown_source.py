from __future__ import annotations

import re
import shutil
import unicodedata
from dataclasses import dataclass
from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent
SOURCE_DIR = ROOT / "local-assets" / "dnd-5e-srd-markdown-master"
OUTPUT_DIR = ROOT / "local-assets" / "por ordenar" / "srd_55e_source_from_markdown"

CONTAINERS = [
    ("001_playing-the-game", "playing-the-game.md"),
    ("002_character-creation", "character-creation.md"),
    ("003_classes", "classes.md"),
    ("004_character-origins", "character-origins.md"),
    ("005_feats", "feats.md"),
    ("006_equipment", "equipment.md"),
    ("007_spells", "spells.md"),
    ("008_rules-glossary", "rules-glossary.md"),
    ("009_gameplay-toolbox", "gameplay-toolbox.md"),
    ("010_magic-items", "magic-items.md"),
]

HEADING_RE = re.compile(r"^(#{1,6})\s+(.*)$")


@dataclass(frozen=True)
class Heading:
    level: int
    title: str
    line_index: int


def slugify(text: str) -> str:
    normalized = unicodedata.normalize("NFKD", text)
    ascii_text = normalized.encode("ascii", "ignore").decode("ascii")
    ascii_text = ascii_text.lower()
    ascii_text = re.sub(r"[^a-z0-9]+", "-", ascii_text)
    return ascii_text.strip("-") or "section"


def parse_headings(lines: list[str]) -> list[Heading]:
    headings: list[Heading] = []
    for index, line in enumerate(lines):
        match = HEADING_RE.match(line)
        if match is None:
            continue
        headings.append(
            Heading(
                level=len(match.group(1)),
                title=match.group(2).strip(),
                line_index=index,
            )
        )
    return headings


def normalize_heading_levels(block_lines: list[str], base_level: int) -> str:
    normalized: list[str] = []
    for line in block_lines:
        match = HEADING_RE.match(line)
        if match is None:
            normalized.append(line)
            continue
        current_level = len(match.group(1))
        new_level = max(1, current_level - (base_level - 1))
        normalized.append(f'{"#" * new_level} {match.group(2).strip()}')
    text = "\n".join(normalized).strip()
    return text + "\n"


def find_section_end(headings: list[Heading], current_index: int, max_level: int, total_lines: int) -> int:
    start = headings[current_index]
    for next_heading in headings[current_index + 1 :]:
        if next_heading.level <= max_level:
            return next_heading.line_index
    return total_lines


def extract_sections(lines: list[str], split_level: int) -> list[tuple[str, str]]:
    headings = parse_headings(lines)
    sections: list[tuple[str, str]] = []
    for index, heading in enumerate(headings):
        if heading.level != split_level:
            continue
        end_line = find_section_end(headings, index, split_level, len(lines))
        block_lines = lines[heading.line_index : end_line]
        sections.append((heading.title, normalize_heading_levels(block_lines, split_level)))
    return sections


def extract_glossary_sections(lines: list[str]) -> list[tuple[str, str]]:
    headings = parse_headings(lines)
    sections: list[tuple[str, str]] = []

    for index, heading in enumerate(headings):
        if heading.level == 2 and heading.title == "Glossary Conventions":
            end_line = find_section_end(headings, index, 2, len(lines))
            block_lines = lines[heading.line_index : end_line]
            sections.append((heading.title, normalize_heading_levels(block_lines, 2)))
            break

    rules_start = next(
        (heading.line_index for heading in headings if heading.level == 2 and heading.title == "Rules Definitions"),
        None,
    )
    if rules_start is None:
        return sections

    rules_headings = [heading for heading in headings if heading.line_index >= rules_start]
    term_headings = [heading for heading in rules_headings if heading.level == 4]

    if not term_headings:
        rules_index = next(
            index for index, heading in enumerate(headings) if heading.level == 2 and heading.title == "Rules Definitions"
        )
        end_line = find_section_end(headings, rules_index, 2, len(lines))
        block_lines = lines[headings[rules_index].line_index : end_line]
        sections.append(("Rules Definitions", normalize_heading_levels(block_lines, 2)))
        return sections

    intro_end = term_headings[0].line_index
    intro_lines = lines[rules_start:intro_end]
    intro_text = "\n".join(intro_lines).strip()
    if intro_text:
        sections.append(("Rules Definitions", intro_text + "\n"))

    for index, heading in enumerate(term_headings):
        next_line = term_headings[index + 1].line_index if index + 1 < len(term_headings) else len(lines)
        block_lines = lines[heading.line_index : next_line]
        sections.append((heading.title, normalize_heading_levels(block_lines, 4)))

    return sections


def write_container(container_name: str, source_file: Path) -> list[Path]:
    container_dir = OUTPUT_DIR / container_name
    container_dir.mkdir(parents=True, exist_ok=True)

    lines = source_file.read_text(encoding="utf-8").splitlines()
    if source_file.name == "rules-glossary.md":
        sections = extract_glossary_sections(lines)
    else:
        sections = extract_sections(lines, split_level=2)

    written_files: list[Path] = []
    index_lines = [f"# {container_name.replace('-', ' ').replace('_', ' ')}", ""]

    for number, (title, content) in enumerate(sections, start=1):
        file_name = f"{number:03d}_{slugify(title)}.md"
        file_path = container_dir / file_name
        file_path.write_text(content, encoding="utf-8")
        written_files.append(file_path)
        index_lines.append(f"- [{title}]({file_name})")

    (container_dir / "index.md").write_text("\n".join(index_lines).strip() + "\n", encoding="utf-8")
    return written_files


def build_root_index(generated: list[tuple[str, list[Path]]]) -> None:
    lines = ["# SRD 5.5e Markdown Source Extracted from Markdown Corpus", ""]
    lines.append("Generated from `local-assets/dnd-5e-srd-markdown-master`.")
    lines.append("")
    for container_name, files in generated:
        lines.append(f"## {container_name}")
        lines.append(f"- Sections: {len(files)}")
        lines.append(f"- [Index]({container_name}/index.md)")
        lines.append("")
    (OUTPUT_DIR / "index.md").write_text("\n".join(lines).strip() + "\n", encoding="utf-8")


def main() -> None:
    if OUTPUT_DIR.exists():
        shutil.rmtree(OUTPUT_DIR)
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    generated: list[tuple[str, list[Path]]] = []
    for container_name, source_name in CONTAINERS:
        source_file = SOURCE_DIR / source_name
        generated.append((container_name, write_container(container_name, source_file)))

    build_root_index(generated)


if __name__ == "__main__":
    main()
