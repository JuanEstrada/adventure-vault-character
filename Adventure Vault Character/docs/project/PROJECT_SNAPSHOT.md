# Adventure Vault Character - Project Snapshot

## Last Update
2026-03-24

## Role of This Document

This file is the operational project-state summary.

For session restart, use `docs/project/SESSION_RESUME.md` first.
Use this snapshot for a compact view of phase, focus, progress, pending work,
and delivery risks.

## Project Phase

Implementation shell established

## Current Focus

Stabilizing the normalized Drift model now that both write-side persistence
and character-sheet read-side mapping use the expanded schema, while reducing
redundant snapshot dependence in `characters` and keeping the guided draft and
sheet flow stable.

## Repository State

- Flutter scaffolding is present for Android, iOS, web, Windows, Linux,
  and macOS.
- `lib/` now includes the first feature-first app shell under `lib/src/`.
- The app implements `bootstrap -> access -> main menu` with controller-driven
  state.
- Character-summary loading is abstracted behind a repository and now reads
  from a local Drift-backed SQLite database.
- The Drift schema is now at `v4` and includes normalized character-side
  tables for `ability scores`, `skills`, `saving throws`, `inventory`,
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
- The characters feature now uses explicit application services for
  `create character` and `character sheet` loading, with shared summary
  mapping extracted from the repository implementation.
- Character-sheet reads now flow through a dedicated read-side domain layer:
  `CharacterRecord` gathers the read inputs, `CharacterDomainMapper`
  translates them into a read model, and `CharacterSheetMapper` now depends
  on that domain model instead of on Drift rows.
- The character sheet view data is now split into panel-specific contracts for
  `identity`, `combat`, `abilities`, `features / notes`, and `equipment`
  instead of one flat sheet DTO.
- Small sheet-facing derived rules now sit in the read domain rather than the
  view mapper, including ability modifiers, proficiency bonus by level,
  level progress percent, formatted proficiencies, and visible equipment item
  composition.
- The read-side domain now also uses dedicated value objects for progression,
  hit points, background outputs, and money/equipment summaries, which makes
  the sheet mapper closer to a pure projection layer.
- Background entries, proficient skills, and saving throws are now also
  represented explicitly in the read domain instead of being flattened at the
  first mapping step, which reduces incidental string formatting in the UI
  mapper.
- Drift persistence responsibilities are now split into focused DAOs for
  `read`, `reference/seed`, and `write` work.
- The character sheet now renders mapped MVP data for identity, background,
  abilities, progression, hit points, structured equipment data, normalized
  saving throws, proficiencies, and finishing details.
- Regression tests now cover Drift migrations from legacy schemas into `v4`.
- A dedicated `CompendiumRepository` now loads a parsed local XML base dataset
  for races, classes, backgrounds, and starter equipment loadouts, with JSON
  fallback preserved.
- The XML parser now skips duplicate metadata indexes and reads the real
  gameplay `backgrounds` and `classes` sections from
  `local-assets/srd_5_2_1_app_base.xml`.
- The compendium seed now also exposes `Character Advancement`,
  `Standard Array by Class`, a compact spell sample across levels `0-9`,
  three feats, and three monsters from local XML assets.
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
- The local persistence model now writes both a legacy-compatible snapshot row
  and the new normalized tables introduced in Drift `v4`.
- Local catalog data is now centralized under `lib/src/features/compendium`
  behind a repository boundary and seeded from local asset examples for
  background, race, and class.
- Session continuity simplified around a single handoff file:
  `docs/project/SESSION_RESUME.md`.

## Work In Progress

- Extending the new read-side domain model and keeping it coherent as more
  sheet logic and future edit flows move away from direct persistence mapping.

## Pending Work

- Remove or narrow redundant snapshot state in `characters` where the
  normalized tables are now the real source of truth, including any remaining
  schema-level cleanup that should only happen with a deliberate migration.
- Define application services and mappers for full guided character creation,
  card summaries, and character-sheet rendering beyond the current first
  service split.
- Decide how far the new read-side character domain model should expand before
  edit workflows begin to depend on it.
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

## Next Recommended Steps

1. Introduce a read-side character domain model that can feed the new
   panel-specific sheet contracts without mapping straight from persistence
   rows.
2. Deepen the parsed compendium fidelity beyond the current XML base starter
   dataset.
3. Break the approved MVP flow into implementation tasks in `lib/`.
4. Update `SESSION_RESUME.md` and this snapshot after each relevant session.

## Next Session Guardrail

- Resume by extending the current shell into persistence and creation flow,
  not by reopening closed MVP flow decisions.
- Use the approved flow and proposed domain-model docs as the working basis
  unless a new product decision replaces them.

## Risks and Unknowns

- The first domain model is not yet finalized.
- Schema-level snapshot cleanup is still pending even though new writes and
  sheet reads now prefer the normalized model.
- Background bonuses and social perks still need deeper normalized
  representation if the app moves beyond the current MVP-compatible snapshots.
- Ability score method state and assignment provenance still need a richer
  normalized representation that supports later editing.
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
