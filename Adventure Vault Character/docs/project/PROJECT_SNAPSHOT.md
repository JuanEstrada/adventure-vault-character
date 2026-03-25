# Adventure Vault Character - Project Snapshot

## Last Update
2026-03-25

## Role of This Document

This file is the operational project-state summary.

For session restart, use `docs/project/SESSION_RESUME.md` first.
Use this snapshot for a compact view of phase, focus, progress, pending work,
and delivery risks.

## Project Phase

Implementation shell established

## Current Focus

Stabilizing the normalized Drift model now that the `characters` row has been
trimmed back further in Drift `v7`, while keeping the guided draft, sheet
flow, and edit/reopen path stable on top of normalized reads.

## Repository State

- Flutter scaffolding is present for Android, iOS, web, Windows, Linux,
  and macOS.
- `lib/` now includes the first feature-first app shell under `lib/src/`.
- The app implements `bootstrap -> access -> main menu` with controller-driven
  state.
- Character-summary loading is abstracted behind a repository and now reads
  from a local Drift-backed SQLite database.
- The Drift schema is now at `v7` and includes normalized character-side
  tables for `ability scores`, `ability score provenance`, `hit points`,
  `finishing details`, `skills`, `saving throws`, `inventory`,
  `proficiencies`, and `currency`.
- The local database now also includes compendium definition tables for
  `skills`, `equipment`, `classes`, `backgrounds`, `spells`, and `trinkets`.
- The create-character screen now uses a first guided draft covering
  `Race + name`, `Background`, `Class / level / experience`, and
  `Ability scores`.
- The guided draft now includes `Equipment` and `Finishing details`, with
  starter loadout and optional narrative fields persisted locally.
- Draft validation now runs outside widgets before persistence and reports
  missing builder sections with user-facing labels.
- The Drift repository now writes normalized character records and seeds core
  SRD-aligned skill/class/background/equipment definition data needed by the
  current save path.
- The Drift repository now also reads normalized character-sheet data for
  `ability scores`, `currency`, `inventory`, `saving throws`, `skills`, and
  `proficiencies`.
- New character writes now avoid storing redundant background, ability-score,
  and equipment/currency snapshot payloads in `characters` when normalized
  tables already persist the same data.
- Character-sheet mapping now prefers normalized tables and background
  definitions over `characters` snapshots, with legacy snapshot fallbacks kept
  only for compatibility.
- `background_definition_ref_id` is now aligned with migration backfill and
  stores the raw background id for new records.
- Drift `v5` now removes redundant `background`, raw `ability score`,
  `proficiency bonus`, and equipment/currency snapshot columns from
  `characters`, with migration coverage preserving the normalized data path
  for existing characters.
- Drift `v6` now also removes `ability_score_method` and
  `ability_score_provenance` from `characters`, migrates the previous
  semicolon provenance string into a dedicated normalized provenance table,
  and uses that normalized record for sheet/edit ability method reads.
- Drift `v7` now also removes `hit point`, `portrait`, and finishing-detail
  columns from `characters`, migrates those values into dedicated normalized
  tables, and keeps summary, sheet, and editable-character reads on the same
  normalized source of truth.
- The characters feature now uses explicit application services for
  `create character` and `character sheet` loading, with shared summary
  mapping extracted from the repository implementation.
- The characters feature now also exposes an editing-oriented load path:
  `CharacterRecordLoader` assembles normalized read inputs once,
  `EditableCharacterService` maps them into an editable aggregate, and the
  repository now exposes `getEditableCharacterById`.
- Existing characters can now be edited through a guided form reopened from
  the character sheet. The app uses a dedicated
  `CharacterEditorController`, reuses the existing builder sections for edit,
  and persists updates back into normalized Drift rows.
- Character-sheet reads now flow through a dedicated read-side domain layer:
  `CharacterRecord` gathers the read inputs and `CharacterDomainMapper`
  translates them into `CharacterDomainModel`.
- The character sheet now renders directly from `CharacterDomainModel`
  instead of from a separate flat sheet DTO layer.
- Small sheet-facing derived rules now sit in the read domain rather than the
  view mapper, including ability modifiers, proficiency bonus by level,
  level progress percent, formatted proficiencies, and visible equipment item
  composition.
- Shared formulas for `ability modifiers`, `proficiency bonus`,
  `level progress`, and initial `hit points` are now centralized in
  `CharacterRules` and reused by create, read, and editable-character paths.
- Character updates now also apply those shared rules so changes to class,
  level, or Constitution recompute maximum HP deterministically while
  preserving current HP when possible.
- The read-side domain now also uses dedicated value objects for progression,
  hit points, background outputs, and money/equipment summaries, which makes
  the UI path closer to a direct domain render path.
- Background entries, proficient skills, and saving throws are now also
  represented explicitly in the read domain instead of being flattened at the
  first mapping step, which reduces incidental string formatting in widgets.
- The previous `CharacterSheetMapper` and `CharacterSheetViewData` layer has
  been removed, with `EquipmentSummaryViewData` retained separately as a small
  shared compendium/UI type.
- Drift persistence responsibilities are now split into focused DAOs for
  `read`, `reference/seed`, and `write` work.
- The character sheet now renders mapped MVP data for identity, background,
  abilities, progression, hit points, structured equipment data, normalized
  saving throws, proficiencies, and finishing details.
- Regression tests now cover Drift migrations from legacy schemas into `v4`.
- Regression tests now also cover loading an editable aggregate from
  normalized persistence and mapping it back into the current
  `CreateCharacterInput` contract.
- Regression tests now also cover `open -> edit -> save -> reopen` through
  both repository and widget-level flows.
- A dedicated `CompendiumRepository` now loads active XML assets directly from
  `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/`,
  with JSON fallback preserved.
- The compendium parser now reads FightClub SRD 5.5e `background`,
  `race`, `class`, `spell`, `feat`, and `monster` entries directly rather than
  depending on the previous curated runtime compendium XML set.
- The compendium seed now also exposes `Character Advancement`,
  `Standard Array by Class`, a compact spell sample across levels `0-9`,
  three feats, and three monsters sourced from the FightClub SRD files plus
  static SRD progression defaults.
- `local-assets/runtime/compendium/` has been removed to avoid duplicated
  sources of truth; active XML now lives under `FightClub5eXML-master/`, while
  removals are tracked under `local-assets/reference/removed_assets/`.
- The repository root now includes `LICENSE` and
  `THIRD_PARTY_LICENSES.md` so the project license and the bundled
  FightClub5eXML MIT notice are kept with the source tree.
- The generated ability-score method now tracks the selected class and applies
  the class-specific standard array recommendation whenever the class changes.
- Widget coverage exists for the offline continuation path into the main menu.
- `flutter test` passed after the schema normalization changes.

## Active Architecture Constraints

- Flutter and Dart client baseline
  -> `docs/adr/ADR-006-use-flutter-for-client-application.md`
- Offline-first architecture
  -> `docs/adr/ADR-002-offline-first-architecture.md`
- Drift over SQLite for local persistence
  -> `docs/adr/ADR-007-use-drift-for-local-persistence.md`
- Separate player and DM applications
  -> `docs/adr/ADR-004-separate-player-and-dm-apps.md`

## Work Completed

- Documentation baseline established across project, architecture, ADR, and
  diagram areas.
- Flutter project scaffolding added to the repository.
- Core strategic decisions documented and aligned to Flutter, offline-first,
  Drift, and separate player/DM products.
- MVP-oriented specs expanded for bootstrap, access, main menu, navigation,
  guided character creation, character cards, and character sheet layout.
- The first character sheet contents are defined in proposal form.
- The first character-domain model is defined in proposal form.
- The builder flow now covers overview, XML-load entry point visibility,
  class/level/experience, ability scores, equipment, finishing details, and
  finalize validation.
- The first production app shell is implemented in `lib/src/` with package
  boundaries for app, navigation, bootstrap, access, main menu, and character
  summary data.
- A first non-widget validator now protects draft persistence by section.
- A first character-sheet view-model mapper now derives MVP sheet content from
  persisted records.
- The local persistence model now treats `characters` as the identity/edit
  metadata row and the normalized tables as the canonical source for
  background detail, abilities, inventory, and currency.
- Local catalog data is now centralized under `lib/src/features/compendium`
  behind a repository boundary and seeded from local asset examples for
  background, race, and class.
- Session continuity simplified around a single handoff file:
  `docs/project/SESSION_RESUME.md`.

## Work In Progress

- Deciding whether the remaining equipment-loadout metadata in `characters`
  should be normalized next, now that ability-score provenance, hit points,
  and finishing details have been moved out of the row.

## Pending Work

- Expand the edit flow beyond the current guided MVP fields and decide how
  later post-creation inventory or combat editing should interact with the
  same aggregate.
- Decide when the local normalized compendium catalog becomes a generated or
  parsed XML-backed source instead of curated asset data.
- Map the approved MVP flow into implementation tasks in `lib/`.
- Add implementation documentation once production code exists.

## Newly Confirmed MVP Decision

- Guided character creation includes background as a mandatory compendium-
  backed choice.
- Background contributes player-facing bonuses and social perks that must be
  visible on the character sheet.
- Guided character creation includes a mandatory ability score step.
- The MVP ability score step supports generated set assignment and manual
  point allocation with visible remaining budget.
- Guided creation places class/level/experience before ability scores and
  before equipment.
- Generated set assignment should follow the compendium's
  `Standard Array by Class` recommendation for the active class.
- Guided creation includes equipment and finishing-details before save.
- Finalization validates required creation sections before persistence.
- The builder overview exposes `LOAD` for XML as a documented entry point, not
  a required MVP import implementation.
- The first character sheet uses a panel-based layout.
- The first character sheet includes real hit-points content.
- `Equipment` can remain a simple placeholder panel in the first sheet.

## Newly Confirmed Naming Decision

- The project term for the imported rules/content dataset is `Compendio`.
- The project term for the XML ingestion subsystem is
  `Compendium Import System`.
- Future XML files uploaded to add or modify classes, races, spells,
  equipment, and related rules content should be treated as `compendium packs`
  processed through the `Compendium Import System`, not as ad hoc direct app
  data.

## Newly Confirmed Future Direction

- A future `Compendio` management screen should include a content selector for
  installed compendium packs.
- The bundled base compendium should remain always active.
- Future imported compendium packs should be manageable as optional active /
  inactive content sources instead of being treated as implicitly enabled.

## Next Recommended Steps

1. Build the next editing-oriented character domain on top of the current
   read-side model instead of introducing another UI-facing mapper layer.
2. Decide whether `equipment_loadout_id` and `equipment_loadout_label` should
   remain lightweight edit metadata in `characters` or move into a dedicated
   normalized contract.
3. Deepen the parsed compendium fidelity beyond the current seeded FightClub
   SRD subset and static progression defaults.
4. Break the approved MVP flow into implementation tasks in `lib/`.
5. Update `SESSION_RESUME.md` and this snapshot after each relevant session.

## Next Session Guardrail

- Resume by extending the current shell into persistence and creation flow,
  not by reopening closed MVP flow decisions.
- Use the approved flow and proposed domain-model docs as the working basis
  unless a new product decision replaces them.

## Risks and Unknowns

- Background bonuses and social perks still need deeper normalized
  representation if the app moves beyond the current MVP-compatible snapshots.
- Ability score provenance is now normalized, but the UI/application contract
  still reconstructs the legacy string shape for compatibility and will need a
  future typed contract when edit behavior expands.
- Future sync and network features remain out of implementation scope.
- Legal and content-boundary constraints for D&D-related material may still
  need refinement later.

## Primary References

- Session continuity: `docs/project/SESSION_RESUME.md`
- Project rules: `docs/project/PROJECT_GUIDELINES.md`
- Roadmap: `docs/project/ROADMAP.md`
- MVP scope: `docs/specs/mvp-scope.md`
- Specs index: `docs/specs/README.md`
- Architecture index: `docs/architecture/README.md`
- ADR index: `docs/adr/README.md`
