# Adventure Vault Character - Project Snapshot

## Last Update
2026-03-30

## Role of This Document

This file is the operational project-state summary.

For session restart, use `docs/project/SESSION_RESUME.md` first.
Use this snapshot for a compact view of phase, focus, progress, pending work,
and delivery risks.

## Project Phase

Implementation shell established, with SRD source extraction materialized, the
first official finishing-details integration implemented, and a first
spellcasting summary now exposed on the character sheet

## Current Focus

Stabilizing and extending the normalized Drift model now that the guided
draft, sheet flow, and edit/reopen path now also consume the official
narrative option catalogs through a real finishing-details integration. In
parallel, the project now also needs to keep translating the local SRD and
Wizards XML sources into deterministic character systems for spells, combat,
and richer inventory behavior, while turning the compendium source-policy work
into a first dedicated offline screen instead of leaving it only as a main-menu
summary.

## Repository State

- Flutter scaffolding is present for Android, iOS, web, Windows, Linux,
  and macOS.
- `lib/` now includes the first feature-first app shell under `lib/src/`.
- The app implements `bootstrap -> access -> main menu` with controller-driven
  state.
- Character-summary loading is abstracted behind a repository and now reads
  from a local Drift-backed SQLite database.
- The Drift schema is now at `v16` and includes normalized character-side
  tables for `ability scores`, `ability score provenance`, `hit points`,
  `finishing details`, `narrative selections`, `equipment loadout`,
  `skills`, `saving throws`, `inventory`, `proficiencies`, and `currency`.
- The local database now also includes compendium definition tables for
  `skills`, `equipment`, `classes`, `character advancement`,
  `class standard array recommendations`, `narrative option groups`,
  `narrative options`, `compendium pack states`, `backgrounds`, `spells`,
  and `trinkets`.
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
- Drift `v8` now also removes `equipment_loadout_id` and
  `equipment_loadout_label` from `characters`, migrates them into a dedicated
  normalized loadout table, and keeps edit/draft reopening on an explicit
  persisted loadout reference instead of inventory inference.
- Drift `v9` now also adds normalized reference tables for
  `character advancement` and `class standard array recommendations`, so
  those rules no longer need to live only as runtime hardcoded lists.
- Drift `v10` now also adds normalized reference tables for narrative
  finishing-detail catalogs, including official `alignment`,
  `personality traits`, `ideals`, `bonds`, `flaws`, and an initial
  setting-backed `faction` base.
- Drift `v11` now also adds a dedicated normalized character-side table for
  persisted narrative selections, so `empty / rolled / manual` state survives
  `save -> reopen` independently of the compendium tables.
- Drift `v12` now also adds a dedicated normalized compendium-side table for
  persisted pack state, keeping the bundled base pack fixed as active while
  storing local active/inactive preferences for optional packs.
- Drift `v13` now also adds explicit optional-pack ownership to normalized
  narrative option groups, so effective catalog filtering survives the local
  persistence roundtrip.
- Drift `v14` now also adds a dedicated imported-compendium table so
  registered XML payloads can be rebuilt into effective catalog content on
  future loads.
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
- The create/edit finishing-details step now consumes normalized official
  narrative option groups through a dedicated `FinishingDetailsService`.
- The guided form now exposes `empty`, `rolled`, and `manual` modes for
  `alignment`, `faction`, `personality traits`, `ideals`, `bonds`, and
  `flaws`.
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
- The character sheet now also renders the resolved narrative fields
  individually instead of depending only on the old merged narrative note.
- The character sheet now also exposes a first `Spells` panel for
  spellcaster classes, with deterministic `casting ability`,
  `spell save DC`, `spell attack bonus`, and a read-only list of available
  compendium spells for the active class.
- Standard spellcaster classes now also persist selected spells and spell-slot
  usage in the normalized character model, and that state now survives
  create, reopen, edit, and sheet rendering.
- The supported standard-caster spell flow now also enforces simplified
  class-specific selection limits, shows `selected / max` in the builder and
  sheet, and trims overflow selections deterministically when the current
  class, level, or casting ability changes.
- Regression tests now cover Drift migrations from legacy schemas into `v4`.
- Regression tests now also cover loading an editable aggregate from
  normalized persistence and mapping it back into the current
  `CreateCharacterInput` contract.
- Regression tests now also cover `open -> edit -> save -> reopen` through
  both repository and widget-level flows.
- Regression tests now also cover deterministic narrative-option source
  resolution, normalized persistence of narrative selections, and the new
  spellcasting summary foundation.
- The spellcasting rules now include warlock pact magic in the deterministic
  pipeline (known-spell limits plus pact slot progression) across
  create/edit/persistence/sheet paths.
- Wizard spell state now uses explicit `spellbook` mode across create/edit,
  persisted selection-kind storage, editable reload, and sheet-facing labels.
- Wizard create/edit now captures both spellbook choices and prepared subset
  choices with deterministic subset/limit enforcement.
- Drift schema is now at `v16`, including expanded spell-selection identity so
  `spellbook` and `prepared` rows can coexist for a single spell id.
- Spell-slot tracking now exposes deterministic short-rest/long-rest reset
  actions in create/edit spell state handling.
- Pack-state filtering now also trims pack-tagged backgrounds, spells, feats,
  and monsters, not only narrative-option groups.
- Imported XML backgrounds now derive bonuses and social-perk style values from
  XML fields/traits instead of static placeholder defaults.
- Project documentation, internal messages, runtime UI strings, and test
  assertions now use English consistently across the repository.
- Wizard spell UX now exposes spellbook-entry count separately from prepared
  daily count in the creation flow.
- Rest processing now runs through explicit domain rest rules, including
  deterministic long-rest HP restoration and temporary-HP clearing.
- Source-policy section notes now include explicit conflict reporting when
  imported content is skipped due to base-precedence collisions.
- Wizard spell UX now includes explicit helper actions for prepared-list
  management (`Prepare all valid`, `Clear prepared`).
- Shared rest rules are now encapsulated in `CharacterRestRules` and applied by
  create/edit spell-state handling.
- The baseline SRD 5.5e compendium now includes optional-features spell/feat
  ingestion, reaching strict 2024 SRD runtime parity for those sections.
- Source-policy metadata for `spells` and `feats` now includes the optional
  features XML source path used by the baseline loader.
- A dedicated `CompendiumRepository` now loads active XML assets directly from
  `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/`,
  with JSON fallback preserved.
- The default app wiring now shares the same `AppDatabase` between
  `DriftCharacterRepository` and `AssetCompendiumRepository`, allowing
  compendium startup loads to seed normalized rules-reference data locally.
- `AssetCompendiumRepository` now parses and seeds normalized narrative option
  groups from local Wizards XML sources instead of leaving those official
  finishing-detail bases only in source documents.
- The compendium parser now reads FightClub SRD 5.5e `background`,
  `race`, `class`, `spell`, `feat`, and `monster` entries directly rather than
  depending on the previous curated runtime compendium XML set.
- The compendium now exposes `Character Advancement`,
  `Standard Array by Class`, and strict 2024 SRD baseline coverage for
  `spells`, `feats`, and `monsters` from FightClub SRD 5.5e sources.
- `local-assets/runtime/compendium/` has been removed to avoid duplicated
  sources of truth; active XML now lives under `FightClub5eXML-master/`, while
  removals are tracked under `local-assets/reference/removed_assets/`.
- The repository root now includes `LICENSE` and
  `THIRD_PARTY_LICENSES.md` so the project license and the bundled
  FightClub5eXML MIT notice are kept with the source tree.
- The local SRD markdown corpus now has a dedicated regeneration tool,
  `tool/normalize_srd_rules.py`, which rebuilds from
  `local-assets/por ordenar/SRD_CC_v5.2.1.pdf`.
- The local assets area now also includes
  `local-assets/dnd-5e-srd-markdown-master/`, a cleaner third-party markdown
  SRD corpus used as a semantic reference source.
- The repo now also includes `tool/extract_srd_markdown_source.py`, which
  splits that markdown corpus into a section-based tree under
  `local-assets/por ordenar/srd_55e_source_from_markdown/`.
- `srd_55e_source_from_markdown/` is organized around top-level SRD blocks and
  additionally breaks `Rules Glossary` into individual term files.
- The markdown-derived split corpus intentionally skips `Monsters`,
  `Monsters A-Z`, and `Animals`.
- The generated ability-score method now tracks the selected class and applies
  the class-specific standard array recommendation whenever the class changes.
- The project docs now also include
  `docs/project/APP_DISCOVERY_QUESTIONNAIRE.md` as a compact current-state
  briefing for AI-assisted sessions.
- The project docs now also include
  `docs/project/USER_INPUTS_AND_AUTOMATIC_CALCULATIONS.md`, which records what
  the app calculates automatically, what the player must enter or confirm, and
  which parts are current versus future.
- The create-character and initial domain-model specs now capture the planned
  three-path narrative finishing-detail model:
  custom or empty input, roll from official options, or manual selection from
  official options for `alignment`, `faction`, `personality traits`,
  `ideals`, `bonds`, and `flaws`, while `portrait` and `appearance` remain
  free optional fields.
- `local-assets/README.md` now indexes `local-assets/local-rule-bases/`.
- `local-assets/local-rule-bases/README.md` now inventories the current local
  rule sources, confirms the best known official XML sources for narrative
  option tables, and records the main extraction gaps still pending.
- The Flutter asset bundle now explicitly includes the narrative XML files
  used for normalized finishing-detail option seeding, preventing web runtime
  `404` asset fetches during compendium load.
- The project now also declares `cupertino_icons` explicitly, so web builds no
  longer warn about a missing `CupertinoIcons` font family.
- `CompendiumCatalog` now exposes explicit source-policy metadata for the
  active catalog, including the current split between SRD 5.5e structured
  FightClub XML and bundled JSON fallback mode, with legacy narrative XML now
  modeled as optional pack-managed supplemental input.
- The main menu now renders a read-only `Active compendium` summary card from
  that source-policy metadata, making the loaded rules basis visible in the
  offline home flow.
- The app now also exposes a dedicated `Compendium` screen from the main menu,
  showing source-policy details and current section coverage from the loaded
  offline catalog.
- That compendium screen now also shows the first read-only management
  entry points for `Import XML` and pack-management work while keeping the
  bundled base compendium explicitly active.
- `Manage packs` now opens a dedicated read-only screen, and
  `Import XML` now opens a dedicated offline registration screen instead of
  staying purely decorative.
- The compendium-pack route now also persists and renders local active /
  inactive state for optional packs.
- The effective compendium now also filters optional narrative-supplement
  content based on that persisted pack state, reducing both visible narrative
  groups and supplemental source-policy metadata when the pack is inactive.
- That filtering now comes from explicit pack metadata on normalized
  compendium content and source-policy sections instead of broad
  `sourceType`-based assumptions.
- Pasted XML can now also be validated and registered locally as an imported
  optional pack, and that imported-pack metadata persists through the same
  Drift-backed pack-management path.
- Active imported XML packs now also contribute supported imported
  `backgrounds`, `races`, `classes`, `spells`, `feats`, and `monsters` to the
  effective catalog, with source-policy notes showing those imported sources
  section by section.
- Imported background `Suggested Characteristics` tables now also contribute
  narrative option groups to the effective catalog for active imported packs,
  and those imported narrative groups disappear again when the pack is
  deactivated.
- Widget coverage exists for the offline continuation path into the main menu.
- Widget coverage now also verifies navigation into the compendium screen.
- Widget coverage now also verifies the visible compendium management/import
  placeholders.
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
- The local SRD reference material now includes both a normalized PDF-derived
  corpus and a cleaner markdown-derived section tree, reducing the need for
  manual PDF extraction cleanup when consulting rules text.
- Session continuity simplified around a single handoff file:
  `docs/project/SESSION_RESUME.md`.
- The documentation set now includes a short project briefing, a player-input
  versus automatic-calculation reference, and a local rules-source inventory
  to support faster future rule extraction work.
- The compendium source-policy work now has a first dedicated UI route instead
  of living only as a home-screen summary card.
- The compendium route now also exposes the first visible management/import
  management block with persisted activation controls and ingestion visibility.
- The compendium area now also has its first real management interaction,
  now wired to active catalog filtering behavior.
- The compendium area now also persists local pack state through Drift, and the
  legacy narrative pack policy is explicit: SRD-aligned core remains fixed while
  legacy PHB/setting narrative catalogs are optional-pack content.
- Imported compendium source-policy notes now include deterministic precedence
  diagnostics per section (`processed`, `accepted`, and conflict totals when
  collisions occur).
- Optional-pack policy interpretation is now centralized in
  `CompendiumCatalog`, reducing duplicated helper logic in presentation code.
- Regression coverage now includes mixed base+legacy+imported scenarios to
  protect precedence behavior and pack-state filtering across sections.
- Inventory behavior now includes a first post-baseline depth slice: sheet-side
  equipment items can persist optional charge tracking and container assignment
  state through the same repository/application contracts used for other
  inventory mutations.
- Long-rest recovery now also refills tracked inventory charges to their
  persisted maximum, aligning item-resource recovery with existing deterministic
  rest-state updates.
- Encumbrance derivation now treats container assignment as effective carried
  state, so nested item weight only counts when the full container chain is
  currently carried.
- Character-sheet equipment UX now includes charge progress and container-state
  hints, with widget coverage for persisted charge control behavior.
- Inventory rules now have a dedicated accepted policy-freeze spec at
  `docs/specs/inventory-rules-phase1.md`, defining weight-cap-only container
  capacity, nesting limits, effective carried-load semantics, and deterministic
  mutation error categories for the next implementation tickets.
- The read-side domain now includes explicit inventory invariant value objects,
  enabling deterministic checks for charge-state consistency, container
  structure validity, and container weight-cap overflow before deeper mutation
  service wiring.
- Inventory container mutations now run through policy-driven validation before
  persistence writes and expose stable error codes via
  `CharacterInventoryValidationError`, with regression tests asserting
  non-container target rejection, capacity overflow rejection, and nesting-depth
  rejection.

## Pending Work

- Expand the edit flow beyond the current guided MVP fields and decide how
  later post-creation inventory or combat editing should interact with the
  same aggregate now that sheet-side inventory mutation controls are live.
- Extend the current container-aware encumbrance behavior with explicit
  capacity-limited container evaluation and richer nested-container behavior
  using the accepted Phase 1 inventory policy as baseline.
- Wire the new read-side inventory invariants into application mutation
  services for additional inventory mutation types beyond container assignment
  (charges, consumables, and quantity-sensitive actions).
- Extend the new compendium screen toward future pack-management and import
  workflows without bypassing the existing repository/domain contract.
- Extend the current XML import flow beyond the currently supported imported
  catalog sections and first imported narrative-option slice into deeper
  compendium areas.
- Expand pack-state effects and precedence reporting across additional
  compendium concerns beyond the current narrative-catalog model.
- Expand precedence diagnostics from aggregate section notes into richer
  per-pack conflict visibility if UI/readability remains acceptable.
- Decide whether any additional reshaping is still needed in
  `local-assets/por ordenar/srd_55e_source_from_markdown/` before treating it
  as the stable long-term section reference tree.
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

- The project term for the imported rules/content dataset is `Compendium`.
- The project term for the XML ingestion subsystem is
  `Compendium Import System`.
- Future XML files uploaded to add or modify classes, races, spells,
  equipment, and related rules content should be treated as `compendium packs`
  processed through the `Compendium Import System`, not as ad hoc direct app
  data.

## Newly Confirmed Future Direction

- A future `Compendium` management screen should include a content selector for
  installed compendium packs.
- The bundled base compendium should remain always active.
- Future imported compendium packs should be manageable as optional active /
  inactive content sources instead of being treated as implicitly enabled.

## Next Recommended Steps

1. Continue translating the available rules sources into explicit
   deterministic application/domain services.
2. Expand compendium ingestion from strict 2024 SRD baseline into broader
   official 2024 sources with explicit precedence and conflict reporting.
3. Expand deterministic resource recovery beyond the now-implemented HP +
   spell-slot + initial class-resource rest actions (broader class coverage,
   rest cadence details, and richer sheet-visible recovery summaries).
4. Expand inventory/equipment modeling depth beyond the current mutation and
   encumbrance baseline into richer containment semantics, container capacity,
   and compendium-aware charge defaults.
5. Continue improving equipment definition quality so weight-aware
   encumbrance reflects more compendium items without fallback gaps.
6. Update `SESSION_RESUME.md` and this snapshot after each relevant session.

## Next Session Guardrail

- Resume by extending the current shell into persistence and creation flow,
  not by reopening closed MVP flow decisions.
- Use the approved flow, the proposed domain-model docs, and
  `local-assets/local-rule-bases/README.md` as the working basis unless a new
  product decision replaces them.

## Risks and Unknowns

- Background bonuses and social perks still need deeper normalized
  representation if the app moves beyond the current MVP-compatible snapshots.
- Ability score provenance is now normalized, but the UI/application contract
  still reconstructs the legacy string shape for compatibility and will need a
  future typed contract when edit behavior expands.
- The app still needs a deliberate source-of-truth policy for each rules
  concern: FightClub XML for structured data, markdown corpora for semantic
  reference, and the PDF for source validation.
- Narrative-option precedence is now policy-driven, but imported-pack conflict
  handling should still expand with richer diagnostics as more sections become
  pack-aware.
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
- Local rules inventory: `local-assets/local-rule-bases/README.md`
