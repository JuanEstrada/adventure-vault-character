# Local Assets

This directory is organized around the local content sources used by the app,
reference material used to validate or normalize them, and templates for future
authoring work.

## Structure

- `FightClub5eXML-master/`: active local XML source tree currently consumed by
  the app for SRD 5.5e classes, races, backgrounds, spells, feats, and
  monsters.
- `dnd-5e-srd-markdown-master/`: third-party SRD markdown corpus kept as a
  clean text reference and section-splitting source.
- `por ordenar/`: working area for local PDF assets and generated markdown
  corpora, including `srd_55e_source_from_markdown/`.
- `reference/`: supporting source material for research, parsing, and future
  ingestion work.
- `reference/source_documents/`: PDFs and office documents used as source
  reference.
- `reference/removed_assets/`: manifests of deleted local assets kept only for
  traceability and future recovery work.
- `local-rule-bases/`: working inventory of local rules sources, what is
  already usable, and what still needs extraction or normalization.
- `templates/`: reusable templates for authoring safe or custom compendium
  inputs.

## Working Rules

- Treat `FightClub5eXML-master/` as the active app-consumed XML source.
- Treat `dnd-5e-srd-markdown-master/` as a local reference corpus, not as a
  runtime app asset.
- Treat `por ordenar/srd_55e_source_from_markdown/` as a generated reference
  tree derived from the markdown corpus, not as the canonical structured data
  source for the app.
- Keep new filenames in `snake_case`.
- Prefer placing new exploratory or third-party source material under
  `reference/` unless it is intentionally being kept as an actively used local
  reference source.
- Record deleted files under `reference/removed_assets/` before removing them.
- Update `pubspec.yaml` and any hardcoded asset paths when moving active XML
  files.
