# Session Resume

Last updated: 2026-03-25

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

Verified on 2026-03-25:

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
- The Drift schema is now at `v4` and includes dedicated character-side tables
  for `ability scores`, `skills`, `saving throws`, `inventory`,
  `proficiencies`, and `currency`, plus compendium-side definition tables for
  `skills`, `equipment`, `classes`, `backgrounds`, `spells`, and `trinkets`.
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
- The character sheet now renders normalized `saving throws`,
  `skill proficiencies`, `other proficiencies`, and inventory-derived
  equipment labels.
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
- Drift migration regression coverage now exists for `v1 -> v4` and
  `v3 -> v4`, including verification of backfilled normalized tables.
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
- The generated ability-score path now applies the
  `Standard Array by Class` recommendation on initial load and every time the
  selected class changes.
- Project terminology now treats the imported rules dataset as the
  `Compendio`, and the XML ingestion subsystem as the
  `Compendium Import System`.
- `test/widget_test.dart` covers the offline path into the main menu.
- `flutter test` passed after the schema and repository changes.

This means the repository has moved beyond the single-screen bootstrap and now
has real local persistence scaffolding, a parsed local compendium baseline,
reactive character flows, normalized read/write paths, and migration coverage.
The next major improvement is reducing duplicated snapshot state and tightening
the normalized model before expanding more player-facing features.

## Current Phase

Implementation shell established.

The project has moved from documentation-only preparation into a real app
shell. The startup path, access screen, main menu shell, and character-summary
repository boundary now exist in code. The next step is to build on the new
Drift boundary and the new compendium repository by expanding the minimal
saved-character slice into the approved guided create-character flow and a
richer character sheet.

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
- The first character sheet contents and the first domain-model proposal are
  documented in `docs/specs/first-character-sheet-contents.md` and
  `docs/specs/initial-character-domain-model.md`.

## Recommended Next Step

The next logical session should build on the current shell instead of
restructuring it again:

1. Start defining an editing-oriented character domain on top of the new
   read-side value objects instead of reintroducing flat UI view models.
2. Reduce the remaining static SRD defaults in the compendium repository by
   deriving more gameplay data directly from the FightClub source set.
3. Break the approved `create -> save -> card -> open sheet` flow into
   concrete implementation tasks in `lib/`.
4. Keep `HP` in scope as real MVP character-sheet data, not as a deferred
   combat placeholder.

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
- Treat the current `characters` table snapshot fields as compatibility support
  only where the normalized model still lacks a deliberate replacement; for
  new records, avoid writing redundant snapshot values when normalized tables
  already persist the same data.
- Use the accepted flow specs and proposed domain-model docs as the source of
  truth unless a new decision replaces them.

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
