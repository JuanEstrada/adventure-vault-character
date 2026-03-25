# Local Assets

This directory is organized around the local content sources used by the app,
reference material used to validate or normalize them, and templates for future
authoring work.

## Structure

- `FightClub5eXML-master/`: active local XML source tree currently consumed by
  the app for SRD 5.5e classes, races, backgrounds, spells, feats, and
  monsters.
- `reference/`: supporting source material for research, parsing, and future
  ingestion work.
- `reference/source_documents/`: PDFs and office documents used as source
  reference.
- `reference/removed_assets/`: manifests of deleted local assets kept only for
  traceability and future recovery work.
- `templates/`: reusable templates for authoring safe or custom compendium
  inputs.

## Working Rules

- Treat `FightClub5eXML-master/` as the active app-consumed XML source.
- Keep new filenames in `snake_case`.
- Prefer placing exploratory or third-party source material under `reference/`.
- Record deleted files under `reference/removed_assets/` before removing them.
- Update `pubspec.yaml` and any hardcoded asset paths when moving active XML
  files.
