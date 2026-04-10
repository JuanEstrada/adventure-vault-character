from __future__ import annotations

import argparse
import re
from dataclasses import dataclass
from pathlib import Path

from pypdf import PdfReader


PDF_HEADER = "System Reference Document 5.2.1"
METADATA_LABELS = {
    "Casting Time",
    "Range",
    "Components",
    "Duration",
    "Creature Type",
    "Size",
    "Speed",
    "Ability Scores",
    "Skill Proficiencies",
    "Tool Proficiency",
    "Equipment",
    "Feat",
    "AC",
    "HP",
    "Senses",
    "Languages",
    "CR",
    "Actions",
    "Bonus Actions",
    "Reactions",
}

KNOWN_TEXT_FIXES = {
    "Acid SplASh": "Acid Splash",
    "iMprovis Ed w Eapons": "Improvised Weapons",
}


@dataclass(frozen=True)
class SectionFile:
    path: Path
    title: str
    search_titles: tuple[str, ...]


class PdfSectionExtractor:
    def __init__(self, pdf_path: Path) -> None:
        self._text = self._load_pdf_text(pdf_path)

    @property
    def text(self) -> str:
        return self._text

    def find_line(self, title: str, start_at: int) -> int:
        match = re.search(rf"(?m)^{re.escape(title)}$", self._text[start_at:])
        if match:
            return start_at + match.start()
        normalized_title = normalize_lookup_key(title)
        offset = start_at
        for line in self._text[start_at:].splitlines():
            if normalize_lookup_key(line) == normalized_title:
                return offset
            offset += len(line) + 1
        raise ValueError(f"Could not find section title in PDF: {title!r}")

    def slice_section(self, title: str, next_title: str | None, start_at: int) -> tuple[str, int]:
        start = self.find_line(title, start_at)
        if next_title is None:
          end = len(self._text)
        else:
          end = self.find_line(next_title, start + len(title))
        return self._text[start:end].strip(), end

    def _load_pdf_text(self, pdf_path: Path) -> str:
        reader = PdfReader(str(pdf_path))
        pages: list[str] = []
        for page in reader.pages:
            raw = page.extract_text() or ""
            lines: list[str] = []
            for line in raw.splitlines():
                stripped = line.strip()
                if stripped == PDF_HEADER:
                    continue
                if re.fullmatch(r"\d+", stripped):
                    continue
                lines.append(line.rstrip())
            pages.append("\n".join(lines))

        text = "\n".join(pages)
        text = text.replace("\r\n", "\n").replace("\r", "\n")
        text = re.sub(r"([A-Za-z])\s*-\n([a-z])", r"\1\2", text)
        text = re.sub(r"\n{3,}", "\n\n", text)
        return text


def build_section_files(root: Path) -> list[SectionFile]:
    files = list(iter_markdown_files(root))
    sections: list[SectionFile] = []
    for path in files:
        title = read_title(path)
        filename_title = title_from_filename(path)
        titles = expand_search_titles(title, filename_title)
        sections.append(SectionFile(path=path, title=title, search_titles=titles))
    return sections


def iter_markdown_files(root: Path) -> list[Path]:
    files: list[Path] = []
    entries = sorted(
        (
            path
            for path in root.iterdir()
            if path.is_dir() or (path.is_file() and path.suffix == ".md" and path.name != "README.md")
        ),
        key=entry_sort_key,
    )
    for entry in entries:
        if entry.is_file():
            files.append(entry)
        else:
            files.extend(iter_markdown_files(entry))
    return files


def entry_sort_key(path: Path) -> tuple[int, str, int]:
    match = re.match(r"^(\d+)-(.+)$", path.stem if path.is_file() else path.name)
    if match:
        prefix = int(match.group(1))
        label = match.group(2)
    else:
        prefix = 999
        label = path.stem if path.is_file() else path.name
    type_priority = 0 if path.is_file() else 1
    return prefix, label, type_priority


def read_title(path: Path) -> str:
    for line in path.read_text(encoding="utf-8").splitlines():
        stripped = line.strip()
        if stripped.startswith("# "):
            return stripped[2:].strip()
    return title_from_filename(path)


def title_from_filename(path: Path) -> str:
    raw = path.stem
    raw = re.sub(r"^\d+-", "", raw)
    words = raw.split("-")
    return " ".join(word.capitalize() for word in words if word)


def looks_searchable(title: str) -> bool:
    return not any(char.islower() and char.isupper() for char in title)


def expand_search_titles(*titles: str) -> tuple[str, ...]:
    candidates: list[str] = []
    for title in titles:
        if not title:
            continue
        normalized = KNOWN_TEXT_FIXES.get(title, title)
        natural_title = normalize_title_case(normalized)
        variants = {
            normalized,
            natural_title,
            normalized.replace('"', ""),
            normalized.replace('"', "“").replace('"', "”"),
            normalized.replace("A-Z", "A–Z").replace("A-z", "A–Z"),
            natural_title.replace("A-Z", "A–Z").replace("A-z", "A–Z"),
        }
        if normalized.startswith('"') and normalized.endswith('"'):
            bare = normalized[1:-1]
            variants.add(bare)
            variants.add(f"“{bare}”")
        else:
            variants.add(f"“{normalized}”")
        for variant in variants:
            if variant and variant not in candidates:
                candidates.append(variant)
    return tuple(candidates)


def normalize_title_case(title: str) -> str:
    small_words = {"a", "an", "and", "as", "at", "by", "for", "in", "of", "on", "or", "the", "to"}
    words = title.split(" ")
    normalized_words: list[str] = []
    for index, word in enumerate(words):
        lower = word.lower()
        if index != 0 and lower in small_words:
            normalized_words.append(lower)
        else:
            normalized_words.append(word[:1].upper() + word[1:])
    return " ".join(normalized_words)


def normalize_lookup_key(text: str) -> str:
    return re.sub(r"[^a-z0-9]+", "", text.lower())


def normalize_section_markdown(title: str, section_text: str, matched_title: str) -> str:
    lines = [KNOWN_TEXT_FIXES.get(line.strip(), line.strip()) for line in section_text.splitlines()]
    if not lines or normalize_lookup_key(lines[0]) != normalize_lookup_key(matched_title):
        raise ValueError(f"Section text does not start with title {title!r}")
    lines[0] = title

    body = [line for line in lines[1:] if line.strip()]
    body = merge_wrapped_lines(body)

    blocks: list[str] = [f"# {title}"]
    index = 0
    while index < len(body):
        line = body[index]

        if line in {
            "Ability Descriptions",
            "Ability Scores",
            "Ability Modifiers",
            "Character Advancement",
            "Fixed Hit Points by Class",
            "Armor",
            "Object Armor Class",
            "Object Hit Points",
            "Carrying Capacity",
            "Damage Types",
            "Search",
            "Areas of Knowledge",
            "Omens",
            "Abbreviations",
        }:
            table, next_index = parse_known_table(line, body, index + 1)
            if table is not None:
                blocks.append(f"## {line}")
                blocks.append(table)
                index = next_index
                continue

        if is_table_like_line(line):
            table_lines = [line]
            index += 1
            while index < len(body) and is_table_like_line(body[index]):
                table_lines.append(body[index])
                index += 1
            blocks.append("\n".join(table_lines))
            continue

        if is_heading_line(line):
            blocks.append(f"## {line}")
            index += 1
            continue

        if re.match(r"^\d+:\s", line):
            items: list[str] = []
            while index < len(body) and re.match(r"^\d+:\s", body[index]):
                items.append(re.sub(r"^\d+:\s*", "", body[index]))
                index += 1
            blocks.extend(f"{i + 1}. {item}" for i, item in enumerate(items))
            continue

        paragraph_lines = [line]
        index += 1
        while index < len(body) and not is_structural_line(body[index]):
            paragraph_lines.append(body[index])
            index += 1
        blocks.append(" ".join(paragraph_lines).strip())

    return "\n\n".join(blocks).strip() + "\n"


def merge_wrapped_lines(lines: list[str]) -> list[str]:
    merged: list[str] = []
    for line in lines:
        if not merged:
            merged.append(line)
            continue

        previous = merged[-1]
        if should_merge(previous, line):
            merged[-1] = f"{previous.rstrip()} {line.lstrip()}"
        else:
            merged.append(line)
    return merged


def should_merge(previous: str, current: str) -> bool:
    if not previous or not current:
        return False
    if is_heading_line(previous) or is_heading_line(current):
        return False
    if is_table_like_line(previous) or is_table_like_line(current):
        return False
    if re.match(r"^\d+:\s", current):
        return False
    if previous.endswith((".", "!", "?", ":")):
        return False
    if previous.endswith("|") or current.startswith("|"):
        return False
    if previous.endswith(",") or previous.endswith("("):
        return True
    if current[:1].islower() or current[:1].isdigit():
        return True
    if current.split(" ", 1)[0].lower() in {"and", "or", "but", "if", "then"}:
        return True
    if re.match(r"^(Weal|Woe|Indifference)\b", current):
        return True
    return False


def is_structural_line(line: str) -> bool:
    return (
        is_heading_line(line)
        or is_table_like_line(line)
        or re.match(r"^\d+:\s", line) is not None
    )


def is_heading_line(line: str) -> bool:
    if not line:
        return False
    if line in METADATA_LABELS:
        return True
    if any(line.startswith(f"{label}:") for label in METADATA_LABELS):
        return True
    if re.match(r"^(Level \d+|[A-Za-z]+ Cantrip)\b", line):
        return True
    if re.match(r"^Tier \d+ \(", line):
        return True
    if re.search(r"\[(Action|Condition|Hazard|Area of Effect)\]$", line):
        return True
    words = line.split()
    if words and words[0] in {"A", "An", "The", "If", "When", "While", "To", "For", "At", "On", "In", "As", "You", "It", "This", "These", "Those", "Each", "Every"}:
        return False
    if (
        re.match(r"^[A-Z][A-Za-z0-9’'()/,\- ]{1,60}$", line)
        and not line.endswith(".")
        and len(words) <= 6
        and words[-1].lower() not in {"a", "an", "and", "are", "is", "of", "or", "the", "to", "with"}
    ):
        return True
    return False


def is_table_like_line(line: str) -> bool:
    return any(
        (
            re.match(r"^\d+\s+[0-9,]+\s+[+−-]?\d+", line),
            re.match(r"^(Barbarian|Fighter,|Bard,|Sorcerer)", line),
            re.match(r"^(Tiny|Small|Medium|Large|Huge|Gargantuan)\b", line),
            re.match(r"^(AC|CR|Level|Class|Armor|Monster Size|Creature Size|Skill|Type|Omen|Abbreviation)\b", line),
            re.match(r"^(Weal|Woe|Weal and woe|Indifference)\b", line),
            re.match(r"^(CE|CG|CN|CP|CR|DC|EP|GM|GP|HP|LE|LG|LN|NE|NG|NPC|PB|PP|SP|XP)\b", line),
            re.match(r"^(Cha\.|Con\.|Dex\.|Int\.|Str\.|Wis\.)\b", line),
        )
    )


def parse_known_table(title: str, lines: list[str], start: int) -> tuple[str | None, int]:
    if title == "Character Advancement":
        rows: list[str] = []
        if start >= len(lines) or lines[start] != "Level Experience Points Proficiency Bonus":
            return None, start
        cursor = start + 1
        while cursor < len(lines) and re.match(r"^\d+\s", lines[cursor]):
            rows.append(lines[cursor])
            cursor += 1
        table = [
            "| Level | Experience Points | Proficiency Bonus |",
            "| --- | ---: | :---: |",
        ]
        for row in rows:
            match = re.match(r"^(\d+)\s+([0-9,]+)\s+([+]\d+)$", row)
            if not match:
                continue
            table.append(f"| {match.group(1)} | {match.group(2)} | {match.group(3)} |")
        return "\n".join(table), cursor

    if title == "Ability Descriptions":
        if start >= len(lines) or lines[start] != "Ability Score Measures …":
            return None, start
        cursor = start + 1
        rows: list[str] = []
        while cursor < len(lines) and re.match(
            r"^(Strength|Dexterity|Constitution|Intelligence|Wisdom|Charisma)\s+",
            lines[cursor],
        ):
            rows.append(lines[cursor])
            cursor += 1
        table = [
            "| Ability Score | Measures |",
            "| --- | --- |",
        ]
        for row in rows:
            match = re.match(
                r"^(Strength|Dexterity|Constitution|Intelligence|Wisdom|Charisma)\s+(.+)$",
                row,
            )
            if match:
                table.append(f"| {match.group(1)} | {match.group(2)} |")
        return "\n".join(table), cursor

    if title == "Ability Scores":
        if start >= len(lines) or lines[start] != "Score Meaning":
            return None, start
        cursor = start + 1
        rows: list[str] = []
        while cursor < len(lines) and re.match(r"^(\d+(?:\s*[–-]\s*\d+)?)\s+", lines[cursor]):
            row = lines[cursor]
            cursor += 1
            while cursor < len(lines) and not is_structural_line(lines[cursor]) and not re.match(r"^(\d+(?:\s*[–-]\s*\d+)?)\s+", lines[cursor]):
                row = f"{row} {lines[cursor]}"
                cursor += 1
            rows.append(row)
        table = [
            "| Score | Meaning |",
            "| --- | --- |",
        ]
        for row in rows:
            match = re.match(r"^(\d+(?:\s*[–-]\s*\d+)?)\s+(.+)$", row)
            if match:
                score = re.sub(r"\s+", "", match.group(1))
                table.append(f"| {score} | {match.group(2)} |")
        return "\n".join(table), cursor

    if title == "Ability Modifiers":
        if start >= len(lines) or lines[start] != "Score Modifier":
            return None, start
        cursor = start + 1
        tokens: list[str] = []
        while cursor < len(lines):
            if lines[cursor] == "Score Modifier":
                cursor += 1
                continue
            if is_structural_line(lines[cursor]) and not re.match(r"^(\d+(?:\s*[–-]\s*\d+)?)\s+[+−-]\d+", lines[cursor]):
                break
            tokens.extend(lines[cursor].split())
            cursor += 1
        rows: list[tuple[str, str]] = []
        index = 0
        while index < len(tokens):
            score = tokens[index]
            if index + 1 >= len(tokens):
                break
            modifier = tokens[index + 1]
            if re.match(r"^[–-]\d+$", modifier) and index + 2 < len(tokens):
                score = f"{score}{modifier}"
                modifier = tokens[index + 2]
                index += 3
            else:
                index += 2
            score = re.sub(r"\s+", "", score)
            if re.match(r"^\d+(?:[–-]\d+)?$", score) and re.match(r"^[+−-]\d+$", modifier):
                rows.append((score, modifier))
        table = [
            "| Score | Modifier |",
            "| --- | ---: |",
        ]
        for score, modifier in rows:
            table.append(f"| {score} | {modifier} |")
        return "\n".join(table), cursor

    if title == "Abbreviations":
        rows: list[str] = []
        cursor = start
        while cursor < len(lines) and lines[cursor] != "Rules Definitions":
            rows.append(lines[cursor])
            cursor += 1
        compact_rows: list[str] = []
        for row in rows:
            if compact_rows and row[:1].islower():
                compact_rows[-1] = f"{compact_rows[-1]} {row}"
            else:
                compact_rows.append(row)
        table = [
            "| Abbreviation | Meaning |",
            "| --- | --- |",
        ]
        for row in compact_rows:
            parts = row.split(maxsplit=1)
            if len(parts) == 2:
                table.append(f"| {parts[0]} | {parts[1]} |")
        return "\n".join(table), cursor

    if title == "Fixed Hit Points by Class":
        rows: list[str] = []
        cursor = start
        while cursor < len(lines) and re.match(r"^(Barbarian|Fighter,|Bard,|Sorcerer)", lines[cursor]):
            rows.append(lines[cursor])
            cursor += 1
        table = [
            "| Class | Hit Points per Level |",
            "| --- | --- |",
        ]
        for row in rows:
            match = re.match(r"^(.+?)\s+(\d+ \+ Con\. modifier)$", row)
            if match:
                table.append(f"| {match.group(1)} | {match.group(2)} |")
        return "\n".join(table), cursor

    if title == "Armor":
        if start >= len(lines) or lines[start] != "Armor Class Strength Stealth Weight Cost":
            return None, start
        cursor = start + 1
        table = [
            "| Armor | Armor Class | Strength | Stealth | Weight | Cost |",
            "| --- | --- | --- | --- | ---: | ---: |",
        ]
        while cursor < len(lines):
            row = lines[cursor]
            if is_heading_line(row) and row not in {"Light Armor (1 Minute to Don or Doff)", "Medium Armor (5 Minutes to Don and 1 Minute to Doff)", "Heavy Armor (10 Minutes to Don and 5 Minutes to Doff)", "Shield (Utilize Action to Don or Doff)"}:
                break
            if row in {"Light Armor (1 Minute to Don or Doff)", "Medium Armor (5 Minutes to Don and 1 Minute to Doff)", "Heavy Armor (10 Minutes to Don and 5 Minutes to Doff)", "Shield (Utilize Action to Don or Doff)"}:
                table.append(f"| **{row}** |  |  |  |  |  |")
                cursor += 1
                continue
            match = re.match(r"^(.+?)\s+(.+?)\s+(—|Str \d+)\s+(—|Disadvantage)\s+(\d+ lb\.)\s+(.+ GP)$", row)
            if match:
                table.append(
                    f"| {match.group(1)} | {match.group(2)} | {match.group(3)} | {match.group(4)} | {match.group(5)} | {match.group(6)} |"
                )
                cursor += 1
                continue
            shield = re.match(r"^(Shield)\s+([+]\d+)\s+—\s+—\s+(\d+ lb\.)\s+(.+ GP)$", row)
            if shield:
                table.append(
                    f"| {shield.group(1)} | {shield.group(2)} | — | — | {shield.group(3)} | {shield.group(4)} |"
                )
                cursor += 1
                continue
            break
        return "\n".join(table), cursor

    if title == "Object Armor Class":
        if start >= len(lines) or lines[start] != "AC Substance AC Substance":
            return None, start
        cursor = start + 1
        rows: list[str] = []
        while cursor < len(lines) and re.match(r"^\d+\s", lines[cursor]):
            rows.append(lines[cursor])
            cursor += 1
        table = [
            "| AC | Substance | AC | Substance |",
            "| --- | --- | --- | --- |",
        ]
        for row in rows:
            match = re.match(r"^(\d+)\s+(.+?)\s+(\d+)\s+(.+)$", row)
            if match:
                table.append(f"| {match.group(1)} | {match.group(2)} | {match.group(3)} | {match.group(4)} |")
        return "\n".join(table), cursor

    if title == "Object Hit Points":
        if start >= len(lines) or lines[start] != "Size Fragile Resilient":
            return None, start
        cursor = start + 1
        rows: list[str] = []
        while cursor < len(lines) and re.match(r"^(Tiny|Small|Medium|Large)\b", lines[cursor]):
            rows.append(lines[cursor])
            cursor += 1
        table = [
            "| Size | Fragile | Resilient |",
            "| --- | --- | --- |",
        ]
        for row in rows:
            match = re.match(r"^(Tiny|Small|Medium|Large)\s+(\([^)]+\))\s+(.+?)\s+(\d+ \([^)]+\))$", row)
            if match:
                table.append(f"| {match.group(1)} {match.group(2)} | {match.group(3)} | {match.group(4)} |")
        return "\n".join(table), cursor

    if title == "Carrying Capacity":
        if start >= len(lines) or lines[start] != "Creature Size Carry Drag/Lift/Push":
            return None, start
        row = lines[start + 1] if start + 1 < len(lines) else ""
        matches = list(re.finditer(r"(Tiny|Small/Medium|Large|Huge|Gargantuan)\s+(Str\. × [0-9.]+ lb\.)\s+(Str\. × [0-9.]+ lb\.)", row))
        if not matches:
            return None, start
        table = [
            "| Creature Size | Carry | Drag/Lift/Push |",
            "| --- | --- | --- |",
        ]
        for match in matches:
            table.append(f"| {match.group(1)} | {match.group(2)} | {match.group(3)} |")
        return "\n".join(table), start + 2

    if title == "Damage Types":
        if start >= len(lines) or lines[start] != "Type Examples":
            return None, start
        cursor = start + 1
        rows: list[str] = []
        while cursor < len(lines) and re.match(r"^(Acid|Bludgeoning|Cold|Fire|Force|Lightning|Necrotic|Piercing|Poison|Psychic|Radiant|Slashing|Thunder)\b", lines[cursor]):
            rows.append(lines[cursor])
            cursor += 1
        table = [
            "| Type | Examples |",
            "| --- | --- |",
        ]
        for row in rows:
            match = re.match(r"^(Acid|Bludgeoning|Cold|Fire|Force|Lightning|Necrotic|Piercing|Poison|Psychic|Radiant|Slashing|Thunder)\s+(.+)$", row)
            if match:
                table.append(f"| {match.group(1)} | {match.group(2)} |")
        return "\n".join(table), cursor

    if title == "Search":
        if start >= len(lines) or lines[start] != "Skill Thing to Detect":
            return None, start
        cursor = start + 1
        rows: list[str] = []
        while cursor < len(lines) and re.match(r"^(Insight|Medicine|Perception|Survival)\b", lines[cursor]):
            rows.append(lines[cursor])
            cursor += 1
        table = [
            "| Skill | Thing to Detect |",
            "| --- | --- |",
        ]
        for row in rows:
            match = re.match(r"^(Insight|Medicine|Perception|Survival)\s+(.+)$", row)
            if match:
                table.append(f"| {match.group(1)} | {match.group(2)} |")
        return "\n".join(table), cursor

    if title == "Areas of Knowledge":
        if start >= len(lines) or lines[start] != "Skill Areas":
            return None, start
        cursor = start + 1
        rows: list[str] = []
        while cursor < len(lines) and re.match(r"^(Arcana|History|Investigation|Nature|Religion)\b", lines[cursor]):
            rows.append(lines[cursor])
            cursor += 1
        table = [
            "| Skill | Areas |",
            "| --- | --- |",
        ]
        for row in rows:
            match = re.match(r"^(Arcana|History|Investigation|Nature|Religion)\s+(.+)$", row)
            if match:
                table.append(f"| {match.group(1)} | {match.group(2)} |")
        return "\n".join(table), cursor

    if title == "Omens":
        if start >= len(lines) or lines[start] != "Omen For Results That Will Be...":
            return None, start
        combined = " ".join(lines[start + 1 : start + 4])
        matches = list(
            re.finditer(
                r"(Weal|Woe|Weal and woe|Indifference)\s+(.+?)(?=(?:Weal and woe|Indifference|$))",
                combined,
            )
        )
        if not matches:
            return None, start
        table = [
            "| Omen | For Results That Will Be... |",
            "| --- | --- |",
        ]
        for match in matches:
            table.append(f"| {match.group(1)} | {match.group(2).strip()} |")
        return "\n".join(table), start + 4

    return None, start


def rewrite_readme(root: Path) -> None:
    parts = [
        "# SRD Rules Extract",
        "",
        "Indice organizado conforme a la jerarquia del PDF `SRD_CC_v5.2.1.pdf`, listando los archivos disponibles en `srd_rules`.",
        "",
    ]
    for directory in sorted(path for path in root.iterdir() if path.is_dir()):
        parts.append(f"## {directory_title(directory.name)}")
        parts.append("")
        parts.extend(build_readme_entries(directory, root))
        parts.append("")
    glossary = root / "08-rules-glossary.md"
    if glossary.exists():
        parts.append("## Rules Glossary")
        parts.append("")
        parts.append("- [Rules Glossary](08-rules-glossary.md)")
        parts.append("")
    (root / "README.md").write_text("\n".join(parts).rstrip() + "\n", encoding="utf-8")


def build_readme_entries(directory: Path, root: Path) -> list[str]:
    entries: list[str] = []
    for file in sorted(path for path in directory.iterdir() if path.is_file() and path.suffix == ".md"):
        entries.append(f"- [{read_title(file)}]({file.relative_to(root).as_posix()})")
    for subdirectory in sorted(path for path in directory.iterdir() if path.is_dir()):
        entries.append("")
        entries.append(f"### {directory_title(subdirectory.name)}")
        entries.append("")
        entries.extend(build_readme_entries(subdirectory, root))
    return entries


def directory_title(name: str) -> str:
    plain = re.sub(r"^\d+-", "", name)
    return " ".join(part.capitalize() for part in plain.split("-") if part)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--root",
        default="local-assets/por ordenar/srd_rules",
        help="SRD markdown root directory",
    )
    parser.add_argument(
        "--pdf",
        default="local-assets/por ordenar/SRD_CC_v5.2.1.pdf",
        help="SRD PDF source of truth",
    )
    parser.add_argument(
        "--write",
        action="store_true",
        help="Write normalized files in place",
    )
    args = parser.parse_args()

    root = Path(args.root)
    pdf = Path(args.pdf)
    extractor = PdfSectionExtractor(pdf)
    sections = build_section_files(root)

    cursor = 0
    outputs: dict[Path, str] = {}
    for index, section in enumerate(sections):
        next_titles = sections[index + 1].search_titles if index + 1 < len(sections) else None
        raw, matched_title, cursor = slice_with_candidates(extractor, section.search_titles, next_titles, cursor)
        markdown = normalize_section_markdown(section.title, raw, matched_title)
        outputs[section.path] = markdown

    if args.write:
        for path, markdown in outputs.items():
            path.write_text(markdown, encoding="utf-8")
        rewrite_readme(root)
        print(f"Normalized {len(outputs)} markdown files from PDF source.")
    else:
        print(f"Prepared {len(outputs)} normalized markdown files from PDF source.")


def slice_with_candidates(
    extractor: PdfSectionExtractor,
    current_titles: tuple[str, ...],
    next_titles: tuple[str, ...] | None,
    cursor: int,
) -> tuple[str, str, int]:
    last_error: Exception | None = None
    for current_title in current_titles:
        try:
            start = extractor.find_line(current_title, cursor)
        except Exception as exc:  # noqa: BLE001
            last_error = exc
            continue

        if next_titles is None:
            return extractor.text[start:].strip(), current_title, len(extractor.text)

        for next_title in next_titles:
            try:
                end = extractor.find_line(next_title, start + len(current_title))
                return extractor.text[start:end].strip(), current_title, end
            except Exception as exc:  # noqa: BLE001
                last_error = exc
                continue

    if last_error is not None:
        raise last_error
    raise ValueError(f"Could not slice section for titles {current_titles!r}")


if __name__ == "__main__":
    main()
