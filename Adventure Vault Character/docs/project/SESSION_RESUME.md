# Session Resume

Last updated: 2026-03-27

This is the single file to read first when resuming work on Adventure Vault
Character. It consolidates the current product, architecture, repository
state, active MVP decisions, and the exact open questions that still block the
next major implementation slices.

## Resume Protocol

1. Read this file first.
2. Use the linked source documents only for the area you are actively
   changing.
3. At the end of each relevant session, update this file so it remains the
   authoritative continuity handoff.

## Project Identity

- Product: Adventure Vault Character
- Platform: Android-first Flutter client
- Language: Dart
- Architecture: offline-first
- Local persistence: Drift over SQLite
- Product boundary: player app only; DM app remains a separate product

## Confirmed Constraints

These are active constraints, not suggestions:

- Rules accuracy has priority over UI convenience or implementation speed.
- Core player flows must work offline.
- The local device is the source of truth for character state.
- Rule logic must not live in widgets.
- Accepted ADRs remain binding until replaced.

Primary references:

- `docs/project/PROJECT_GUIDELINES.md`
- `docs/adr/ADR-002-offline-first-architecture.md`
- `docs/adr/ADR-004-separate-player-and-dm-apps.md`
- `docs/adr/ADR-006-use-flutter-for-client-application.md`
- `docs/adr/ADR-007-use-drift-for-local-persistence.md`

## Repository Reality

Verified on 2026-03-27:

- Flutter project scaffolding exists for Android, iOS, web, Windows, Linux,
  and macOS.
- `lib/` now contains the first feature-first application shell under
  `lib/src/`.
- The app now implements the startup path `bootstrap -> access -> main menu`
  with controller-driven state and repository boundaries.
- Character summaries now load through a Drift-backed repository over a local
  SQLite database.
- The previous single-table character persistence has now been extended into a
  normalized Drift schema.
- The Drift schema is now at `v10` and includes dedicated character-side tables
  for `ability scores`, `ability score provenance`, `hit points`,
  `finishing details`, `equipment loadout`, `skills`, `saving throws`, `inventory`,
  `proficiencies`, and `currency`, plus
  compendium-side definition tables for `skills`, `equipment`, `classes`,
  `character advancement`, `class standard array recommendations`,
  `narrative option groups`, `narrative options`,
  `backgrounds`, `spells`, and `trinkets`.
- A first vertical slice now supports `create -> save -> card -> open sheet`
  with a minimal character record: `name`, `race`, `class`, and `level`.
- The create-character UI now uses a first guided draft with explicit sections
  for `Race + name`, `Background`, `Class / level / experience`, and
  `Ability scores`.
- The guided draft now also covers `Equipment` and `Finishing details` with
  starter loadout selection plus optional alignment, appearance, and
  narrative notes.
- The repository save path now persists the draft's `background`,
  `ability scores`, `experience`, starter equipment details, finishing
  details, and initial `hit points`.
- The Drift-backed repository now seeds and persists normalized character data
  for ability scores, class/background references, basic saving throws,
  inventory rows, proficiencies, and currency snapshot data while keeping the
  current UI-compatible snapshot fields in `characters`.
- The read side for `getCharacterSheetById` and `watchCharacterSheetById`
  now also pulls from the normalized Drift tables for `ability scores`,
  `currency`, `inventory`, `saving throws`, `skills`, and `proficiencies`
  instead of relying only on snapshot fields in `characters`.
- New character creation now keeps redundant `characters` snapshots narrower:
  `background name / summary`, raw `ability score` columns, and equipment /
  currency snapshot payloads are no longer written for new records when
  normalized tables already carry the real data.
- Character-sheet mapping now prefers normalized reads and background
  definition records over `characters` snapshot columns, leaving those
  snapshots as compatibility fallback only.
- `background_definition_ref_id` now stores the raw background id
  consistently with the migration backfill, while the read path still accepts
  the previous prefixed legacy form for compatibility.
- Drift `v5` now removes the redundant `background`, raw `ability score`,
  `proficiency bonus`, and equipment/currency snapshot columns from
  `characters`, preserving old data through migration and treating the
  normalized tables as the only source of truth for those areas.
- Drift `v6` now also removes `ability_score_method` and
  `ability_score_provenance` from `characters`, backfills the previous
  semicolon provenance string into a dedicated normalized provenance table,
  and uses that normalized record as the source of truth for edit/reopen
  ability method state.
- The character sheet now renders normalized `saving throws`,
  `skill proficiencies`, `other proficiencies`, and inventory-derived
  equipment labels.
- Character loading now also supports an editing-oriented aggregate:
  `EditableCharacterService` reuses the normalized read assembly,
  `EditableCharacterMapper` projects `CharacterRecord` into an editable
  domain model, and `CharacterRepository` now exposes
  `getEditableCharacterById`.
- Existing characters can now reopen into a guided edit flow from the
  character sheet. The app uses a dedicated `CharacterEditorController`,
  reuses the guided builder sections for editing, and persists updates back
  through the normalized Drift model instead of recreating snapshot-heavy
  writes.
- Drift persistence is now split across focused DAOs for `read`,
  `reference/seed`, and `write` responsibilities.
- The characters feature now also has an explicit application layer:
  `CreateCharacterService` coordinates draft persistence,
  `CharacterSheetService` assembles sheet reads, and
  `CharacterSummaryMapper` defines summary mapping shared across repository
  implementations.
- Character-sheet loading now also passes through a read-only character domain
  layer: `CharacterRecord` aggregates the read-side inputs and
  `CharacterDomainMapper` builds the read model consumed by the app.
- The character sheet now renders directly from `CharacterDomainModel`
  instead of from a separate flat `CharacterSheetViewData` contract.
- Small derived rules used by the character sheet now live in the read domain
  instead of a sheet view mapper, including `ability score modifiers`,
  `proficiency bonus by level`, `level progress percent`,
  `other proficiency formatting`, and visible equipment item composition.
- Shared character rules are now centralized under `CharacterRules`, and the
  same formulas are reused by sheet derivation, editable-character loading,
  and create-character persistence for `ability modifiers`,
  `proficiency bonus`, `level progress`, and initial `hit points`.
- Character updates now also reuse those shared rules. When class, level, or
  Constitution change during edit, maximum HP is recomputed deterministically
  and current HP is preserved when possible, then clamped to the new maximum.
- The read-side domain is now also structured around dedicated value objects
  for `progression`, `hit points`, `background`, and `money/equipment`
  summaries, so future sheet growth can stay inside the domain layer before
  reaching UI mappers.
- The read-side domain now also models `background output entries`,
  `proficient skills`, and `saving throws` explicitly instead of flattening
  them immediately into display strings; the UI now consumes domain display
  getters for these values directly.
- `CharacterSheetMapper` and the old `CharacterSheetViewData` hierarchy have
  now been removed from the active code path, with the remaining
  `EquipmentSummaryViewData` extracted into its own small shared type.
- Drift migration regression coverage now exists for legacy schemas through
  `v10`, including verification of backfilled normalized tables, migrated
  ability-score provenance, and preserved hit-point / finishing-detail /
  equipment-loadout data.
- The app startup path now shares one `AppDatabase` instance between the
  Drift character repository and the asset compendium repository, so local
  compendium loads can also seed normalized rule-reference tables.
- `AssetCompendiumRepository` no longer treats
  `character advancement` and `standard array by class` as runtime-only
  lists. Those rules are now seeded into normalized Drift tables and read
  back through the compendium catalog load path.
- The app now also normalizes official narrative option catalogs into Drift:
  `alignment` as a core reference group, `personality traits / ideals / bonds / flaws`
  from `backgrounds-phb.xml`, and an initial `faction` base from
  `backgrounds-scag.xml`, `backgrounds-pam.xml`, `backgrounds-ggr.xml`, and
  `backgrounds-erlw.xml`.
- `CompendiumCatalog` now exposes normalized `narrativeOptionGroups`, so the
  future finishing-details flow can consume official options without reparsing
  raw XML in widgets.
- The create/edit flow now consumes those normalized narrative option groups
  directly through a dedicated `FinishingDetailsService`.
- Character-side narrative selections are now persisted in a dedicated
  normalized table, separate from the compendium-side narrative catalogs.
- Finishing details now support exactly three implemented modes per narrative
  field: `empty`, `rolled`, and `manual`.
- `alignment`, `faction`, `personality traits`, `ideals`, `bonds`, and
  `flaws` now reopen correctly through `create -> save -> open -> edit -> save -> reopen`.
- The character sheet now renders the resolved narrative fields individually
  instead of depending only on the old merged `narrativeDetails` note.
- The character sheet now also exposes a first deterministic spellcasting
  summary for spellcaster classes, derived from normalized class definitions,
  canonical ability scores, and the loaded compendium spell catalog.
- The current spellcasting foundation now computes `casting ability`,
  `ability modifier`, `spell save DC`, and `spell attack bonus` in the
  read-side domain instead of deriving those values in widgets.
- The sheet now lists the locally available compendium spells for the active
  class as a first read-only spell foundation, ordered by spell level and
  name.
- Draft save now runs through a non-widget validator that reports missing
  sections using builder-facing names before persistence.
- A dedicated `CompendiumRepository` boundary now sits between the app and
  local catalog data.
- The current app catalog now loads directly from the FightClub SRD 5.5e XML
  source files under
  `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/`,
  with `assets/compendium/catalog.json` kept as fallback.
- The XML parser now reads FightClub `background`, `race`, `class`, `spell`,
  `feat`, and `monster` entries directly instead of depending on the previous
  curated runtime compendium XML set.
- The parsed compendium seed now also includes the full
  `Character Advancement` table, the `Standard Array by Class` table, a small
  spell seed spanning levels `0-9`, three feats, and three monsters, with the
  progression defaults kept as static SRD-aligned rules.
- `local-assets/runtime/compendium/` has been removed; active app XML now
  lives under `FightClub5eXML-master/`, and deleted asset paths are tracked in
  `local-assets/reference/removed_assets/`.
- The repository root now includes a project `LICENSE` plus
  `THIRD_PARTY_LICENSES.md` so the bundled FightClub5eXML MIT notice ships
  with the project.
- `local-assets/por ordenar/srd_rules/` now also has a reproducible
  normalization pipeline driven by the canonical PDF source
  `local-assets/por ordenar/SRD_CC_v5.2.1.pdf`.
- The repo now includes `tool/normalize_srd_rules.py`, which extracts section
  text from the SRD PDF with `pypdf`, rewrites the markdown corpus in document
  order, and regenerates the local `srd_rules/README.md` index from the
  normalized files.
- The repo now also includes `tool/extract_srd_markdown_source.py`, which
  splits the clean third-party markdown corpus under
  `local-assets/dnd-5e-srd-markdown-master/` into a section-based tree under
  `local-assets/por ordenar/srd_55e_source_from_markdown/`.
- The generated `srd_55e_source_from_markdown/` corpus is organized by
  top-level SRD blocks, with dedicated folders for `Playing the Game`,
  `Character Creation`, `Classes`, `Character Origins`, `Feats`, `Equipment`,
  `Spells`, `Rules Glossary`, `Gameplay Toolbox`, and `Magic Items`.
- `Rules Glossary` is further split into individual term files so definitions
  can be referenced directly by rule name.
- The split markdown corpus intentionally excludes `Monsters`, `Monsters A-Z`,
  and `Animals` from the generated output tree.
- The local assets area now also includes the upstream markdown source corpus
  in `local-assets/dnd-5e-srd-markdown-master/`, which is treated as a
  reference-quality text source rather than an app runtime asset.
- The generated ability-score path now applies the
  `Standard Array by Class` recommendation on initial load and every time the
  selected class changes.
- Project docs now also include
  `docs/project/APP_DISCOVERY_QUESTIONNAIRE.md` as a compact current-state
  briefing for AI-assisted sessions.
- Project docs now also include
  `docs/project/USER_INPUTS_AND_AUTOMATIC_CALCULATIONS.md`, which separates
  automatic app calculations from player-entered or player-confirmed data and
  marks current versus future behavior.
- The create-character and initial domain-model specs now document the planned
  three-path capture model for narrative finishing details:
  custom value or empty, roll from official options, or manual selection from
  official options for `alignment`, `faction`, `personality traits`,
  `ideals`, `bonds`, and `flaws`, while `portrait` and `appearance` remain
  free optional fields.
- The local assets area now also includes
  `local-assets/local-rule-bases/README.md`, an inventory of local rules
  sources that records what is already usable and what still needs extraction
  or normalization.
- Project terminology now treats the imported rules dataset as the
  `Compendio`, and the XML ingestion subsystem as the
  `Compendium Import System`.
- Future compendium management should include a content selector so the player
  can review installed compendium packs and control which optional packs are
  active while the bundled base compendium remains always enabled.
- `test/widget_test.dart` covers the offline path into the main menu.
- `flutter test` passed after the schema and repository changes.
- `flutter analyze` and `flutter test` passed after the `v10` narrative-rules
  normalization work.

This means the repository now has an end-to-end offline character edit flow on
top of the normalized read/write model, with shared rules and regression
coverage protecting both create and update paths. `characters` is now closer
to an identity/resume row, with HP and finishing details moved into dedicated
normalized tables, equipment loadout metadata in its own normalized table, and
the narrative-field selections now also stored in their own normalized
character-side table. The latest documentation pass also leaves the repo with
a clearer product briefing, a better separation between automatic calculations
and player input, and an explicit local-source inventory for future rules
extraction. The next major improvement is extending the same deterministic
approach further into persisted spell selection, slots/resources, combat, and
richer inventory behavior.

## Current Phase

Implementation shell established, with SRD source extraction now materialized
as repository content.

The project has moved from documentation-only preparation into a real app
shell. The startup path, access screen, main menu shell, and character-summary
repository boundary now exist in code. In parallel, the local SRD now has a
reproducible normalized PDF-derived corpus in `srd_rules/` and a cleaner
section-based reference tree in `srd_55e_source_from_markdown/` derived from a
clean markdown source corpus. The next step is to keep the app work moving
while using these sources to formalize deterministic rules and compendium
contracts instead of spending more time on PDF cleanup.

## MVP Slice In Focus

The first implementation slice is the offline path from app launch to a usable
character sheet.

Canonical MVP flow:

1. App launch
2. Bootstrap startup
3. Access screen
4. `Continuar offline`
5. Main menu
6. Character cards visible when saved characters exist
7. `Crear personaje nuevo`
8. Builder overview
9. Optional visible `LOAD XML` entry point from main menu
10. Guided creation: `Race + name`
11. Guided creation: `Background`
12. Guided creation: `Class / level / experience`
13. Guided creation: `Ability scores`
14. Guided creation: `Equipment`
15. Guided creation: `Finishing details`
16. Finalize validation
17. Local save
18. Character card appears in main menu
19. Character sheet

Primary references:

- `docs/specs/mvp-scope.md`
- `docs/specs/initial-navigation-flow.md`
- `docs/specs/create-character-screen.md`
- `docs/specs/character-sheet-screen.md`
- `docs/project/ROADMAP.md`

## What Is Already Decided

- Startup always begins in bootstrap.
- Startup loads the local compendium catalog and saved character summaries.
- The access screen keeps a dummy online login but must expose
  `Continuar offline`.
- The main menu must expose `Compendio`, `Reglas`, `Settings`, and
  `Crear personaje nuevo`.
- The main menu uses character cards as the saved-character entry point.
- Character creation is guided, not a free-form advanced builder.
- The main menu exposes a visible `LOAD XML` entry for future XML import work.
- Full XML import behavior is not required for MVP completion.
- Creation currently includes race, name, background, ability scores,
  class, level, experience, equipment, and finishing details.
- Race, background, and class data are compendium-backed.
- Ability scores are part of the minimum valid character record.
- Experience and level must stay synchronized.
- Finalization validates `Race + name`, `Background`, `Ability scores`, and
  `Class / level / experience`.
- Successful finalization persists locally, adds the character to the main-menu
  card list, and opens the character sheet.
- Background bonuses and social perks must be shown on the character sheet.
- Final ability scores and their modifiers must be shown on the character
  sheet.
- Current, maximum, and temporary hit points must be shown on the character
  sheet.
- Selected starter equipment and finishing details should be shown on the
  character sheet when present.
- The first character sheet uses a panel-based layout.
- `Abilities` and `Features / Notes` carry real MVP content.
- `Combat` carries real hit-points content in MVP, while deeper combat
  features may still remain placeholders.
- `Equipment` may exist as a simple placeholder panel in MVP even though
  equipment is captured during creation.
- The first character card uses a library-style layout with portrait or
  placeholder plus a short identity summary.

## Main Open Product Decisions

These are the highest-value unresolved items:

1. Decide whether the next refactor introduces a real read-side character
   domain model between Drift rows and sheet view models, now that panel-level
   sheet contracts are separated.
2. Decide when XML import moves from documented entry point into a real
   implementation slice.
3. Decide when deeper `Combat` features and the `Equipment` panel move from
   MVP-minimal states into populated panels.

Resolved architecture decision:

- The next domain refactor does introduce a real editing-oriented character
  aggregate on top of the normalized read-side model instead of reintroducing
  flat UI-facing DTOs.

Resolved MVP decision:

- Guided creation does require one additional mandatory step before save:
  background selection.
- The reason is product-driven, not heavy rules automation: background brings
  bonuses and social perks from the compendium that the player must be able to
  review later on the character sheet.
- Guided creation also requires a mandatory ability score step before save.
- The MVP ability score step is based on the builder reference UI and supports
  generated set assignment plus a manual assignment mode with per-ability
  selection.
- Guided creation places class, level, and experience before ability scores
  and before equipment.
- The generated-set variant should default to the compendium's
  `Standard Array by Class` recommendation for the currently selected class
  and update when the class changes.
- Guided creation includes an equipment step before final save.
- Guided creation includes a finishing-details step before final save.
- `Alignment` is captured inside finishing details for MVP.
- The `LOAD XML` action remains visible from the main menu, but full XML
  import behavior is deferred.
- Future uploaded XML files that add or modify classes, races, spells,
  equipment, and similar rules content are considered `compendium packs` and
  belong to the `Compendium Import System`.
- A future `Compendio` screen should expose a content selector for installed
  compendium packs, with the bundled base compendium fixed as active and
  imported packs treated as optional content sources.
- The first character sheet contents and the first domain-model proposal are
  documented in `docs/specs/first-character-sheet-contents.md` and
  `docs/specs/initial-character-domain-model.md`.

## Recommended Next Step

The next logical session should build on the current shell instead of
restructuring it again:

1. Start defining an editing-oriented character domain on top of the new
   read-side value objects instead of reintroducing flat UI view models.
2. Build the first real edit/reopen flow on top of
   `getEditableCharacterById`, keeping widgets thin and avoiding new
   persistence-specific contracts in presentation.
3. Reduce the remaining static SRD defaults in the compendium repository by
   deriving more gameplay data directly from the FightClub source set.
4. Break the approved `create -> save -> card -> open sheet` flow into
   concrete implementation tasks in `lib/`.
5. Keep `HP` in scope as real MVP character-sheet data, not as a deferred
   combat placeholder.

Completed since the previous handoff:

- The first real `open -> edit -> save -> reopen` flow is now implemented.
- The edit flow reuses the guided builder sections instead of introducing a
  second form surface.
- Repository and widget regression coverage now includes the edit/update path.
- Drift schema cleanup is now implemented through `v8`, and redundant snapshot,
  ability-provenance, hit-point, finishing-detail, and equipment-loadout
  columns have been removed from `characters` with migration coverage for the
  preserved normalized data path.
- The local assets area now includes the third-party markdown corpus
  `local-assets/dnd-5e-srd-markdown-master/`, which is cleaner than the
  previous PDF-split output for many rules sections and class tables.
- The repo now also includes `tool/extract_srd_markdown_source.py`, which
  regenerates a section-based SRD tree under
  `local-assets/por ordenar/srd_55e_source_from_markdown/`.
- The generated markdown-based SRD tree replaces the previous checked-in
  `sdr_55e_source/` PDF-split corpus as the main section-level local reference
  tree.
- `srd_55e_source_from_markdown/` keeps the top-level SRD block structure and
  additionally splits `Rules Glossary` into individual rule-definition files.
- Project docs now include a compact app-discovery snapshot and a dedicated
  automatic-calculations vs player-input reference for AI-guided sessions.
- The create-character and initial domain-model specs now capture the planned
  three-path narrative finishing-detail rule:
  custom or empty, roll from official options, or manual selection from
  official options.
- `local-assets/local-rule-bases/README.md` now identifies the current rule
  source hierarchy and confirms that the best local official sources for
  `traits`, `ideals`, `bonds`, `flaws`, and many `faction` options live in
  `local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/.../backgrounds-*.xml`.

Next-session starting point:

- Start from the normalized Drift schema in
  `lib/src/features/characters/data/local/app_database.dart` and the updated
  repository in `lib/src/features/characters/data/drift_character_repository.dart`.
- Use `lib/src/features/characters/domain/character_domain_model.dart` as the
  source of truth for current character-sheet rendering behavior.
- Use the new migration regression tests in
  `test/app_database_migration_test.dart` as the safety net before changing the
  schema again.
- Use the FightClub SRD 5.5e XML source files under
  `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/`
  through the `CompendiumRepository` boundary as the active source of truth
  for local creation data, with `assets/compendium/catalog.json` retained only
  as fallback.
- Use `tool/normalize_srd_rules.py` when refreshing
  `local-assets/por ordenar/srd_rules/`; the PDF
  `local-assets/por ordenar/SRD_CC_v5.2.1.pdf` is the source of truth for that
  markdown corpus, not the previous OCR-derived markdown text.
- Use `tool/extract_srd_markdown_source.py` when refreshing
  `local-assets/por ordenar/srd_55e_source_from_markdown/`; that split corpus
  is derived from `local-assets/dnd-5e-srd-markdown-master/` and currently
  serves as the cleaner section-level SRD reference tree.
- Use `local-assets/local-rule-bases/README.md` as the source of truth for the
  current local rule-source inventory before extracting new option catalogs.
- Use `local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/01_Core/01_Players_Handbook/backgrounds-phb.xml`
  as the first extraction target for `personality traits`, `ideals`, `bonds`,
  and `flaws`.
- Use `local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Sword_Coast_Adventurers_Guide/backgrounds-scag.xml`,
  `.../Planescape_Adventures_in_the_Multiverse/backgrounds-pam.xml`,
  `.../Guildmasters_Guide_to_Ravnica/backgrounds-ggr.xml`, and
  `.../Eberron_Rising_From_the_Last_War/backgrounds-erlw.xml` as the first
  faction-oriented extraction sources.
- Treat `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/`
  as the canonical structured source for app logic and compendium ingestion,
  and use the markdown corpora as supporting semantic references.
- Treat `characters` as the identity/resume row plus remaining lightweight
  metadata, while normalized tables remain the source of truth for background
  details, abilities, hit points, finishing details, equipment loadout,
  inventory, and currency.
- Use the accepted flow specs and proposed domain-model docs as the source of
  truth unless a new decision replaces them.
- Treat `docs/specs/create-character-screen.md`,
  `docs/specs/initial-character-domain-model.md`,
  `docs/project/USER_INPUTS_AND_AUTOMATIC_CALCULATIONS.md`, and
  `local-assets/local-rule-bases/README.md` as the source of truth for the
  newly documented narrative finishing-detail direction until code catches up.

## If You Need More Detail

Open only the source that matches the work:

- Project state and planning: `docs/project/PROJECT_SNAPSHOT.md`
- Project rules: `docs/project/PROJECT_GUIDELINES.md`
- Roadmap: `docs/project/ROADMAP.md`
- Architecture baseline: `docs/architecture/README.md`
- Decision log: `docs/adr/README.md`
- Screen and flow specs: `docs/specs/README.md`

## Maintenance Rule

When the project state changes, update this file first, then update any deeper
source documents affected by the same decision or implementation change.
