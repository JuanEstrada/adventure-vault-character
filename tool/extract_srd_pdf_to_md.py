from __future__ import annotations

import argparse
import re
import sys
import unicodedata
from dataclasses import dataclass
from pathlib import Path

from pypdf import PdfReader

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from tool.normalize_srd_rules import (
    KNOWN_TEXT_FIXES,
    expand_search_titles,
    normalize_lookup_key,
    normalize_section_markdown,
)


PDF_HEADER = "System Reference Document 5.2.1"
ROOT_TITLE = "System Reference Document 5.2.1"
SKIP_TITLES = {"Monsters", "Monsters A-Z", "Monsters A–Z", "Animals"}
CONTAINER_FOLDERS = {
    "001_playing-the-game": "001_playing-the-game",
    "040_character-creation": "040_character-creation",
    "052_classes": "052_classes",
    "087_character-origins": "087_character-origins",
    "103_feats": "103_feats",
    "109_equipment": "109_equipment",
    "126_spells": "126_spells",
    "144_magic-items-2": "144_magic-items",
}
CONTAINER_STEMS = set(CONTAINER_FOLDERS)


@dataclass(frozen=True)
class OutlineEntry:
    title: str
    level: int
    page_number: int | None
    search_titles: tuple[str, ...]


@dataclass(frozen=True)
class PageText:
    page_number: int
    lines: list[str]


def slugify(text: str) -> str:
    normalized = unicodedata.normalize("NFKD", text)
    ascii_text = normalized.encode("ascii", "ignore").decode("ascii")
    ascii_text = ascii_text.lower()
    ascii_text = re.sub(r"[^a-z0-9]+", "-", ascii_text)
    return ascii_text.strip("-") or "section"


def flatten_outline(reader: PdfReader) -> list[OutlineEntry]:
    entries: list[OutlineEntry] = []

    def walk(items: list[object], level: int = 0) -> None:
        index = 0
        while index < len(items):
            item = items[index]
            if isinstance(item, list):
                walk(item, level)
                index += 1
                continue

            title = item.get("/Title") if isinstance(item, dict) else None
            keep = title and title != ROOT_TITLE
            current_level = level
            if keep:
                try:
                    page_number = reader.get_destination_page_number(item) + 1
                except Exception:
                    page_number = None
                entries.append(
                    OutlineEntry(
                        title=KNOWN_TEXT_FIXES.get(title, title),
                        level=current_level,
                        page_number=page_number,
                        search_titles=expand_search_titles(KNOWN_TEXT_FIXES.get(title, title)),
                    )
                )

            if index + 1 < len(items) and isinstance(items[index + 1], list):
                walk(items[index + 1], level + 1)
                index += 2
            else:
                index += 1

    walk(reader.outline)
    return entries


def is_monster_or_animal_block(entry: OutlineEntry, seen_monsters: bool) -> bool:
    if entry.title in SKIP_TITLES:
        return True
    if seen_monsters:
        return True
    return False


def filter_entries(entries: list[OutlineEntry]) -> tuple[list[OutlineEntry], list[str]]:
    kept: list[OutlineEntry] = []
    skipped: list[str] = []
    seen_monsters = False
    for entry in entries:
        if entry.title == "Monsters":
            seen_monsters = True
        if is_monster_or_animal_block(entry, seen_monsters):
            skipped.append(entry.title)
            continue
        kept.append(entry)
    return kept, skipped


def clean_page_lines(page_text: str, page_number: int) -> list[str]:
    lines: list[str] = []
    for raw_line in page_text.splitlines():
        stripped = raw_line.strip()
        if not stripped:
            continue
        if stripped == PDF_HEADER:
            continue
        if stripped == str(page_number):
            continue
        lines.append(stripped)
    return lines


def extract_pages(reader: PdfReader) -> list[PageText]:
    pages: list[PageText] = []
    for index, page in enumerate(reader.pages, start=1):
        raw = page.extract_text() or ""
        pages.append(PageText(page_number=index, lines=clean_page_lines(raw, index)))
    return pages


def detect_unassigned_pages(pages: list[PageText], second_section_page: int | None) -> dict[int, str]:
    reasons: dict[int, str] = {}
    for page in pages:
        if second_section_page is not None and 2 <= page.page_number < second_section_page:
            if page.lines and (page.lines[0] == "Contents" or "Contents" in page.lines[:3]):
                reasons[page.page_number] = "Pagina del indice / tabla de contenidos"
                continue
            dotted = sum(1 for line in page.lines if "." in line and re.search(r"\d+$", line))
            if dotted >= 8:
                reasons[page.page_number] = "Continuacion de la tabla de contenidos"
    return reasons


def find_title_line(lines: list[str], search_titles: tuple[str, ...], start_index: int = 0) -> tuple[int, int, str] | None:
    normalized_titles = [(title, normalize_lookup_key(title)) for title in search_titles]

    for index in range(start_index, len(lines)):
        for span in (1, 2, 3):
            if index + span > len(lines):
                continue
            combined = " ".join(lines[index : index + span])
            normalized_line = normalize_lookup_key(combined)
            for title, normalized_title in normalized_titles:
                if normalized_line == normalized_title:
                    return index, span, title

    for index in range(start_index, len(lines)):
        normalized_line = normalize_lookup_key(lines[index])
        for title, normalized_title in normalized_titles:
            if len(normalized_title) < 12:
                continue
            if normalized_title and (
                normalized_line.startswith(normalized_title)
                or normalized_title.startswith(normalized_line)
            ):
                return index, 1, title
    return None


def locate_title(
    pages_by_number: dict[int, PageText],
    nominal_page: int | None,
    search_titles: tuple[str, ...],
    start_index: int = 0,
    max_lookahead: int = 2,
) -> tuple[int, int, int, str] | None:
    if nominal_page is None:
        return None
    page_numbers = sorted(pages_by_number)
    for offset in range(0, max_lookahead + 1):
        page_number = nominal_page + offset
        if page_number not in pages_by_number:
            continue
        local_start = start_index if offset == 0 else 0
        match = find_title_line(pages_by_number[page_number].lines, search_titles, local_start)
        if match is not None:
            line_index, span, matched_title = match
            return page_number, line_index, span, matched_title
    return None


def build_raw_section_text(
    entry: OutlineEntry,
    next_entry: OutlineEntry | None,
    pages_by_number: dict[int, PageText],
    unassigned_pages: dict[int, str],
) -> tuple[str | None, str | None, int | None, int | None, list[str]]:
    if entry.page_number is None:
        return None, None, None, None, [f"No se pudo resolver pagina de inicio para '{entry.title}'."]

    start_location = locate_title(pages_by_number, entry.page_number, entry.search_titles)
    if start_location is None:
        return (
            None,
            None,
            None,
            None,
            [f"No se encontro el encabezado de inicio '{entry.title}' cerca de la pagina {entry.page_number}."],
        )
    actual_start_page, start_index, start_span, matched_title = start_location
    notes: list[str] = []

    first_page = pages_by_number[actual_start_page]
    next_location = None
    if next_entry:
        next_location = locate_title(
            pages_by_number,
            next_entry.page_number,
            next_entry.search_titles,
            start_index + start_span if next_entry.page_number == actual_start_page else 0,
        )

    if next_location and next_location[0] == actual_start_page:
        next_page_number, next_index, _, _ = next_location
        page_lines = [matched_title, *first_page.lines[start_index + start_span : next_index]]
        return "\n".join(page_lines).strip(), matched_title, actual_start_page, next_page_number, notes

    end_page = next_location[0] if next_location else max(pages_by_number)
    collected: list[str] = [matched_title, *first_page.lines[start_index + start_span :]]
    for page_number in range(actual_start_page + 1, end_page):
        if page_number in unassigned_pages:
            notes.append(f"Se omitio la pagina {page_number}: {unassigned_pages[page_number]}.")
            continue
        page = pages_by_number[page_number]
        collected.extend(page.lines)

    if next_location:
        next_page_number, next_index, _, _ = next_location
        if next_page_number not in unassigned_pages:
            collected.extend(pages_by_number[next_page_number].lines[:next_index])

    return "\n".join(collected).strip(), matched_title, actual_start_page, end_page, notes


def dedupe_filename(base_slug: str, used: dict[str, int]) -> str:
    current = used.get(base_slug, 0) + 1
    used[base_slug] = current
    if current == 1:
        return base_slug
    return f"{base_slug}-{current}"


def write_notes_file(path: Path, notes: list[str], orphan_pages: dict[int, str], pages_by_number: dict[int, PageText]) -> None:
    parts = ["# Notas no asignadas", ""]

    if orphan_pages:
        for page_number in sorted(orphan_pages):
            reason = orphan_pages[page_number]
            text = "\n".join(pages_by_number[page_number].lines).strip()
            parts.append(f"## Pagina {page_number}")
            parts.append("")
            parts.append(f"- Motivo: {reason}")
            if text:
                parts.append(f"- Texto:")
                parts.append("")
                parts.append("> " + text.replace("\n", "\n> "))
            parts.append("")

    if notes:
        parts.append("## Observaciones del proceso")
        parts.append("")
        for note in notes:
            parts.append(f"- {note}")
        parts.append("")

    if not orphan_pages and not notes:
        parts.append("No se detectaron notas o fragmentos huerfanos.")
        parts.append("")

    path.write_text("\n".join(parts).rstrip() + "\n", encoding="utf-8")


def write_index(
    path: Path,
    generated: list[tuple[str, str, int | None, int | None, str | None]],
) -> None:
    parts = ["# Index", "", "Lista ordenada de archivos generados a partir del indice del PDF.", ""]
    for filename, title, start_page, end_page, note in generated:
        page_label = "paginas no resueltas"
        if start_page is not None and end_page is not None:
            page_label = f"paginas aprox. {start_page}-{end_page}"
        elif start_page is not None:
            page_label = f"pagina aprox. {start_page}"
        line = f"- [{filename}]({filename}): {title} ({page_label})"
        if note:
            line += f" - Observacion: {note}"
        parts.append(line)
    path.write_text("\n".join(parts).rstrip() + "\n", encoding="utf-8")


def build_container_indexes(output_dir: Path) -> None:
    files = sorted(
        [path for path in output_dir.iterdir() if path.is_file() and path.suffix == ".md" and path.name not in {"index.md", "00_notas_no_asignadas.md"}],
        key=lambda path: path.name,
    )
    containers: list[tuple[Path, list[Path]]] = []
    current_container: Path | None = None
    current_children: list[Path] = []

    for path in files:
        title = read_title(path)
        if path.stem in CONTAINER_STEMS:
            if current_container is not None:
                containers.append((current_container, current_children))
            current_container = path
            current_children = []
            continue
        if title in {"Rules Glossary", "Gameplay Toolbox"}:
            if current_container is not None:
                containers.append((current_container, current_children))
            current_container = None
            current_children = []
            continue
        if current_container is not None:
            current_children.append(path)

    if current_container is not None:
        containers.append((current_container, current_children))

    for container_file, children in containers:
        title = read_title(container_file)
        folder = output_dir / CONTAINER_FOLDERS[container_file.stem]
        folder.mkdir(exist_ok=True)
        if container_file.exists():
            container_file.unlink()
        for child in children:
            child.rename(folder / child.name)
        lines = [f"# {title}", "", "Secciones contenidas en este bloque del SRD.", ""]
        for child in sorted(folder.glob("*.md")):
            child_title = read_title(child)
            lines.append(f"- [{child_title}]({child.name})")
        (folder / "index.md").write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def rewrite_root_index_for_containers(output_dir: Path) -> None:
    index_path = output_dir / "index.md"
    lines = index_path.read_text(encoding="utf-8").splitlines()
    current_container_folder = ""
    rewritten: list[str] = []

    for line in lines:
        match = re.match(r"^- \[(.+?)\]\((.+?)\): (.+?) \((.+?)\)(.*)$", line)
        if not match:
            rewritten.append(line)
            continue

        label, href, title, page_info, suffix = match.groups()
        stem = Path(href).stem
        if stem in CONTAINER_STEMS:
            current_container_folder = CONTAINER_FOLDERS[stem]
            rewritten.append(f"- [{current_container_folder}]({current_container_folder}/index.md): {title} ({page_info}){suffix}")
            continue

        if title in {"Rules Glossary", "Gameplay Toolbox"}:
            current_container_folder = ""
            rewritten.append(line)
            continue

        if current_container_folder:
            filename = Path(href).name
            rewritten.append(f"- [{label}]({current_container_folder}/{filename}): {title} ({page_info}){suffix}")
        else:
            rewritten.append(line)

    index_path.write_text("\n".join(rewritten).rstrip() + "\n", encoding="utf-8")


def read_title(path: Path) -> str:
    for line in path.read_text(encoding="utf-8").splitlines():
        if line.startswith("# "):
            return line[2:].strip()
    return path.stem


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--pdf", default="local-assets/por ordenar/SRD_CC_v5.2.1.pdf")
    parser.add_argument("--output", default="local-assets/por ordenar/sdr_55e_source")
    args = parser.parse_args()

    pdf_path = Path(args.pdf)
    output_dir = Path(args.output)
    output_dir.mkdir(parents=True, exist_ok=True)

    reader = PdfReader(str(pdf_path))
    all_entries = flatten_outline(reader)
    entries, skipped_titles = filter_entries(all_entries)
    pages = extract_pages(reader)
    pages_by_number = {page.page_number: page for page in pages}
    second_section_page = entries[1].page_number if len(entries) > 1 else None
    unassigned_pages = detect_unassigned_pages(pages, second_section_page)

    width = len(str(len(entries)))
    notes: list[str] = []
    generated: list[tuple[str, str, int | None, int | None, str | None]] = []
    used_slugs: dict[str, int] = {}

    for index, entry in enumerate(entries, start=1):
        next_entry = entries[index] if index < len(entries) else None
        raw_text, matched_title, actual_start_page, actual_end_page, local_notes = build_raw_section_text(
            entry, next_entry, pages_by_number, unassigned_pages
        )
        notes.extend(local_notes)

        if not raw_text or not matched_title:
            notes.append(f"Seccion no generada: {entry.title}")
            continue

        try:
            markdown = normalize_section_markdown(entry.title, raw_text, matched_title)
            issue = None
        except Exception as exc:
            issue = f"Normalizacion parcial: {exc}"
            notes.append(f"{entry.title}: {issue}")
            markdown = f"# {entry.title}\n\n{raw_text}\n"

        prefix = str(index).zfill(width)
        slug = dedupe_filename(slugify(entry.title), used_slugs)
        filename = f"{prefix}_{slug}.md"
        (output_dir / filename).write_text(markdown, encoding="utf-8")

        if actual_start_page is not None and actual_end_page is not None:
            if next_entry and actual_end_page > actual_start_page:
                final_end_page = actual_end_page
            else:
                final_end_page = actual_start_page
        else:
            final_end_page = actual_end_page
        generated.append((filename, entry.title, actual_start_page, final_end_page, issue))

    write_notes_file(output_dir / "00_notas_no_asignadas.md", notes, unassigned_pages, pages_by_number)
    write_index(output_dir / "index.md", generated)
    build_container_indexes(output_dir)
    rewrite_root_index_for_containers(output_dir)

    top_level_titles = [entry.title for entry in entries if entry.level == 1]
    summary_lines = [
        f"generated_sections={len(generated)}",
        f"skipped_outline_entries={len(skipped_titles)}",
        f"top_level_sections={len(top_level_titles)}",
        "top_level_titles=" + " | ".join(top_level_titles),
        f"output_dir={output_dir}",
    ]
    print("\n".join(summary_lines))


if __name__ == "__main__":
    main()
