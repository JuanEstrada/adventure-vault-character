from __future__ import annotations

import re
import os
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable

from pypdf import PdfReader


PDF_PATH = Path(
    r"C:/Users/Mocy/Documents/Playground/Adventure Vault Character/local-assets/por ordenar/SRD_CC_v5.2.1.pdf"
)
OUTPUT_DIR = Path(
    r"C:/Users/Mocy/Documents/Playground/Adventure Vault Character/local-assets/por ordenar/srd_rules"
)


@dataclass
class OutlineEntry:
    title: str
    page: int
    chain: tuple[str, ...]


def slugify(value: str) -> str:
    value = value.replace("“", "").replace("”", "").replace('"', "")
    value = value.replace("’", "").replace("'", "")
    value = value.lower()
    value = re.sub(r"[^a-z0-9]+", "-", value)
    return value.strip("-")


def flatten_outline(
    reader: PdfReader, node: Iterable, parents: tuple[str, ...] = ()
) -> list[OutlineEntry]:
    result: list[OutlineEntry] = []
    last_title: str | None = None

    for item in node:
        if isinstance(item, list):
            child_parents = parents + (last_title,) if last_title else parents
            result.extend(flatten_outline(reader, item, child_parents))
            continue

        try:
            page_number = reader.get_destination_page_number(item)
        except Exception:
            continue
        if page_number is None:
            last_title = str(item.get("/Title", "")).strip() or last_title
            continue
        page = page_number + 1

        title = str(item.get("/Title", "")).strip()
        if not title:
            continue

        result.append(OutlineEntry(title=title, page=page, chain=parents + (title,)))
        last_title = title

    return result


def clean_page_text(text: str, page_number: int) -> str:
    lines = text.replace("\r\n", "\n").replace("\r", "\n").split("\n")
    cleaned: list[str] = []
    for line in lines:
        stripped = line.strip()
        if not stripped:
            cleaned.append("")
            continue
        if stripped == "System Reference Document 5.2.1":
            continue
        if stripped == str(page_number):
            continue
        cleaned.append(line.rstrip())
    return "\n".join(cleaned).strip()


def heading_regex(title: str) -> re.Pattern[str]:
    words = [re.escape(word) for word in title.split()]
    pattern = r"\b" + r"\s+".join(words) + r"\b"
    return re.compile(pattern, re.IGNORECASE)


def normalize_heading(value: str) -> str:
    value = value.lower()
    value = re.sub(r"[^a-z0-9]+", "", value)
    return value


def find_heading_index(text: str, title: str) -> int | None:
    wanted = normalize_heading(title)
    offset = 0
    for line in text.splitlines(keepends=True):
        if normalize_heading(line) == wanted:
            return offset
        offset += len(line)
    return None


def trim_to_heading(text: str, title: str) -> str:
    index = find_heading_index(text, title)
    if index is not None:
        return text[index:]
    match = heading_regex(title).search(text)
    return text[match.start() :] if match else text


def trim_before_heading(text: str, title: str) -> str:
    index = find_heading_index(text, title)
    if index is not None:
        return text[:index]
    match = heading_regex(title).search(text)
    return text[: match.start()] if match else text


def normalize_markdown_text(text: str) -> str:
    text = text.replace("\u00ad", "")
    text = re.sub(r"[ \t]+\n", "\n", text)
    text = re.sub(r"\n{3,}", "\n\n", text)
    return text.strip()


def locate_page_for_title(
    pages: dict[int, str], start_page: int, title: str, max_forward: int = 3
) -> int:
    last_page = max(pages)
    for page_number in range(start_page, min(start_page + max_forward, last_page) + 1):
        if find_heading_index(pages.get(page_number, ""), title) is not None:
            return page_number
    return start_page


def should_export(entry: OutlineEntry) -> bool:
    title = entry.title
    parent = entry.chain[-2] if len(entry.chain) > 1 else None

    included = {
        "Playing the Game",
        "Rhythm of Play",
        "The Six Abilities",
        "D20 Tests",
        "Ability Checks",
        "Saving Throws",
        "Attack Rolls",
        "Advantage/Disadvantage",
        "Proficiency",
        "Actions",
        "Bonus Actions",
        "Reactions",
        "Social Interaction",
        "Exploration",
        "Vision and Light",
        "Hiding",
        "Interacting with Objects",
        "Hazards",
        "Travel",
        "Combat",
        "The Order of Combat",
        "Movement and Position",
        "Making an Attack",
        "Ranged Attacks",
        "Melee Attacks",
        "Mounted Combat",
        "Underwater Combat",
        "Damage and Healing",
        "Hit Points",
        "Damage Rolls",
        "Critical Hits",
        "Saving Throws and Damage",
        "Damage Types",
        "Resistance and Vulnerability",
        "Immunity",
        "Healing",
        "Dropping to 0 Hit Points",
        "Temporary Hit Points",
        "Character Creation",
        "Choose a Character Sheet",
        "Create Your Character",
        "Level Advancement",
        "Starting at Higher Levels",
        "Trinkets",
        "Character Origins",
        "Character Backgrounds",
        "Acolyte",
        "Criminal",
        "Sage",
        "Soldier",
        "Character Species",
        "Dragonborn",
        "Dwarf",
        "Elf",
        "Gnome",
        "Goliath",
        "Halfling",
        "Human",
        "Orc",
        "Tiefling",
        "Feats",
        "Feat Descriptions",
        "Equipment",
        "Coins",
        "Weapons",
        "Properties",
        "Mastery Properties",
        "Armor",
        "Tools",
        "Mounts and Vehicles",
        "Lifestyle Expenses",
        "Food, Drink, and Lodging",
        "Hirelings",
        "Spellcasting",
        "Magic Items",
        "Crafting Nonmagical Items",
        "Brewing Potions of Healing",
        "Scribing Spell Scrolls",
        "Spells",
        "Gaining Spells",
        "Casting Spells",
        "Spell Descriptions",
        "Rules Glossary",
        "Gameplay Toolbox",
        "Travel Pace",
        "Creating a Background",
        "Curses and Magical Contagions",
        "Environmental Effects",
        "Fear and Mental Stress",
        "Poison",
        "Traps",
        "Combat Encounters",
        "Magic Item Categories",
        "Magic Item Rarity",
        "Activating a Magic Item",
        "The Next Dawn",
        "Cursed Items",
        "Magic Item Resilience",
        "Crafting Magic Items",
        "Sentient Magic Items",
        "Monsters",
        "Stat Block Overview",
        "Parts of a Stat Block",
        "Running a Monster",
    }

    if title not in included:
        return False

    if title == "Magic Items" and parent not in {"Equipment", "Gameplay Toolbox"}:
        return False

    if title in {"Classes", "Monsters A–Z", "Animals"}:
        return False

    return True


def extra_trim_titles(entry: OutlineEntry) -> list[str]:
    title = entry.title
    parent = entry.chain[-2] if len(entry.chain) > 1 else None

    trims = {
        "Feat Descriptions": ["Origin Feats"],
        "Tools": ["Artisans Tools", "Alchemists Supplies", "Alchemist’s Supplies"],
        "Mounts and Vehicles": ["Mounts and Other Animals"],
        "Spells": ["Gaining Spells"],
        "Casting Spells": ["Spell Descriptions"],
        "Spell Descriptions": ["Acid Arrow"],
        "Magic Items": ["Crafting Nonmagical Items"] if parent == "Equipment" else [],
        "Magic Item Categories": ["Magic Item Rarity"],
        "Sentient Magic Items": ["Magic Items A–Z", "Magic Items A-Z"],
        "Running a Monster": ["Monsters A–Z", "Monsters A-Z"],
        "Monsters": ["Stat Block Overview"],
    }
    return trims.get(title, [])


def export_path(entry: OutlineEntry) -> Path:
    chain = entry.chain[1:] if entry.chain and entry.chain[0] == "System Reference Document 5.2.1" else entry.chain
    parent_dirs = [slugify(part) for part in chain[:-1]]
    filename = f"{slugify(entry.title)}.md"
    return OUTPUT_DIR.joinpath(*parent_dirs, filename)


def relative_link(from_file: Path, to_file: Path) -> str:
    return Path(os.path.relpath(to_file, start=from_file.parent)).as_posix()


def find_related_titles(
    content: str, current_title: str, title_to_path: dict[str, list[tuple[str, Path]]]
) -> list[tuple[str, Path]]:
    related: list[tuple[str, Path]] = []
    seen: set[tuple[str, str]] = set()

    for title, entries in title_to_path.items():
        if title == current_title:
            continue
        if not re.search(rf"\b{re.escape(title)}\b", content, re.IGNORECASE):
            continue
        for _, path in entries:
            key = (title, str(path))
            if key not in seen:
                seen.add(key)
                related.append((title, path))

    related.sort(key=lambda item: item[0].lower())
    return related


def main() -> None:
    reader = PdfReader(str(PDF_PATH))
    pages = {
        index + 1: clean_page_text(page.extract_text() or "", index + 1)
        for index, page in enumerate(reader.pages)
    }
    outline = flatten_outline(reader, reader.outline)

    selected = [entry for entry in outline if should_export(entry)]
    selected_set = {entry.chain for entry in selected}
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    exports: list[tuple[OutlineEntry, Path, str]] = []
    title_to_path: dict[str, list[tuple[str, Path]]] = {}

    for index, entry in enumerate(outline):
        if entry.chain not in selected_set:
            continue

        next_entry = outline[index + 1] if index + 1 < len(outline) else None
        start_page = locate_page_for_title(pages, entry.page, entry.title)
        end_page = (
            locate_page_for_title(pages, next_entry.page, next_entry.title)
            if next_entry
            else len(pages)
        )

        chunks: list[str] = []
        for page_number in range(start_page, end_page + 1):
            if page_number in pages:
                chunks.append(pages[page_number])
        text = "\n\n".join(chunks)
        text = trim_to_heading(text, entry.title)

        if next_entry is not None:
            text = trim_before_heading(text, next_entry.title)

        for trim_title in extra_trim_titles(entry):
            updated = trim_before_heading(text, trim_title)
            if updated != text:
                text = updated
                break

        text = normalize_markdown_text(text)

        if not text:
            continue

        body = text.split("\n", 1)[1].strip() if "\n" in text else ""
        if len(re.sub(r"\W+", "", body)) < 40:
            continue

        path = export_path(entry)
        exports.append((entry, path, body))
        title_to_path.setdefault(entry.title, []).append((entry.chain[-2] if len(entry.chain) > 1 else "", path))

    for entry, path, body in exports:
        path.parent.mkdir(parents=True, exist_ok=True)
        related = find_related_titles(body, entry.title, title_to_path)
        lines = [f"# {entry.title}", "", body]

        if related:
            lines.extend(["", "## Referencias"])
            for title, related_path in related:
                rel = relative_link(path, related_path)
                lines.append(f"- [{title}]({rel})")

        path.write_text("\n".join(lines).strip() + "\n", encoding="utf-8")

    readme_lines = ["# SRD Rules Extract", "", "Archivos generados desde el indice del PDF, filtrando clases, feats, equipo, conjuros, objetos magicos, monstruos y animales salvo sus partes definitorias.", ""]
    for _, path, _ in sorted(exports, key=lambda item: item[1].as_posix()):
        rel = path.relative_to(OUTPUT_DIR).as_posix()
        readme_lines.append(f"- [{rel}]({rel})")

    (OUTPUT_DIR / "README.md").write_text("\n".join(readme_lines) + "\n", encoding="utf-8")
    print(f"Generated {len(exports)} files in {OUTPUT_DIR}")


if __name__ == "__main__":
    main()
