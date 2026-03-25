from __future__ import annotations

import os
import re
from pathlib import Path


ROOT = Path(
    r"C:/Users/Mocy/Documents/Playground/Adventure Vault Character/local-assets/por ordenar/srd_rules"
)


def get_title(path: Path) -> str | None:
    text = path.read_text(encoding="utf-8")
    for line in text.splitlines():
        if line.startswith("# "):
            return line[2:].strip()
    return None


def relative_link(from_file: Path, to_file: Path) -> str:
    return Path(os.path.relpath(to_file, start=from_file.parent)).as_posix()


def strip_references_block(text: str) -> str:
    return re.sub(r"\n## Referencias\n(?:- .*\n?)*\s*$", "\n", text, flags=re.M).rstrip() + "\n"


def main() -> None:
    files = sorted(p for p in ROOT.rglob("*.md") if p.name != "README.md")
    title_to_paths: dict[str, list[Path]] = {}
    file_to_title: dict[Path, str] = {}

    for path in files:
        title = get_title(path)
        if not title:
            continue
        file_to_title[path] = title
        title_to_paths.setdefault(title, []).append(path)

    for path in files:
        text = path.read_text(encoding="utf-8")
        text = strip_references_block(text)
        body = "\n".join(text.splitlines()[1:]) if "\n" in text else ""
        current_title = file_to_title.get(path, "")

        refs: list[tuple[str, Path]] = []
        seen: set[tuple[str, str]] = set()

        for title, paths in title_to_paths.items():
            if title == current_title:
                continue
            if not re.search(rf"\b{re.escape(title)}\b", body, re.I):
                continue
            for target in paths:
                key = (title, str(target))
                if key not in seen:
                    seen.add(key)
                    refs.append((title, target))

        refs.sort(key=lambda item: (item[0].lower(), item[1].as_posix()))
        if refs:
            text = text.rstrip() + "\n\n## Referencias\n"
            for title, target in refs:
                text += f"- [{title}]({relative_link(path, target)})\n"

        path.write_text(text, encoding="utf-8")

    print(f"Updated references in {len(files)} files")


if __name__ == "__main__":
    main()
