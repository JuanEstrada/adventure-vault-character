# Session Resume

Last updated: 2026-03-23

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

Verified on 2026-03-23:

- Flutter project scaffolding exists for Android, iOS, web, Windows, Linux,
  and macOS.
- `lib/` now contains the first feature-first application shell under
  `lib/src/`.
- The app now implements the startup path `bootstrap -> access -> main menu`
  with controller-driven state and repository boundaries.
- Character summaries now load through a Drift-backed repository over a local
  SQLite database.
- The first persisted schema is intentionally minimal and currently stores the
  fields required to render main-menu character cards.
- The Drift schema is now at `v2` and already includes additive fields for
  `background`, `ability scores`, `experience`, and `hit points`, ready for
  the next builder slice.
- A first vertical slice now supports `create -> save -> card -> open sheet`
  with a minimal character record: `name`, `race`, `class`, and `level`.
- The create-character UI now uses a first guided draft with explicit sections
  for `Race + name`, `Background`, `Ability scores`, and
  `Class / level / experience`.
- The repository save path now persists the draft's `background`,
  `ability scores`, `experience`, and initial `hit points`, even though the
  richer sheet mapping is still pending.
- Draft save now runs through a non-widget validator that reports missing
  sections using builder-facing names before persistence.
- A dedicated `CompendiumRepository` boundary now sits between the app and
  local catalog data.
- The current app catalog loads from `assets/compendium/catalog.json`
  instead of direct widget or mapper constants.
- `test/widget_test.dart` covers the offline path into the main menu.

This means the repository has moved beyond the single-screen bootstrap and now
has real local persistence scaffolding and a minimal end-to-end character
creation slice. The next major improvement is replacing the curated local
catalog asset with a generated or parsed source from `local-assets` while the
guided builder keeps expanding toward MVP completeness.

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
9. Optional visible `LOAD` entry point for XML
10. Guided creation: `Race + name`
11. Guided creation: `Background`
12. Guided creation: `Ability scores`
13. Guided creation: `Class / level / experience`
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
- Startup loads local config, saved character summaries, and the XML content
  index.
- The access screen keeps a dummy online login but must expose
  `Continuar offline`.
- The main menu must expose `Compendio`, `Reglas`, `Settings`, and
  `Crear personaje nuevo`.
- The main menu uses character cards as the saved-character entry point.
- Character creation is guided, not a free-form advanced builder.
- The builder begins from an overview screen and exposes a visible `LOAD`
  entry for future XML import work.
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

1. Extend the first Drift schema from summary-only storage toward the proposed
   character model.
2. Define application services and task breakdown for `create -> save -> card
   -> open sheet`.
3. Decide when XML import moves from documented entry point into a real
   implementation slice.
4. Decide when deeper `Combat` features and the `Equipment` panel move from
   MVP-minimal states into populated panels.

Resolved MVP decision:

- Guided creation does require one additional mandatory step before save:
  background selection.
- The reason is product-driven, not heavy rules automation: background brings
  bonuses and social perks from the compendium that the player must be able to
  review later on the character sheet.
- Guided creation also requires a mandatory ability score step before save.
- The MVP ability score step is based on the builder reference UI and supports
  generated set assignment and manual point allocation with visible remaining
  budget.
- Guided creation places class, level, and experience before equipment.
- Guided creation includes an equipment step before final save.
- Guided creation includes a finishing-details step before final save.
- `Alignment` is captured inside finishing details for MVP.
- The `LOAD` XML action remains visible in the builder overview, but full XML
  import behavior is deferred.
- The first character sheet contents and the first domain-model proposal are
  documented in `docs/specs/first-character-sheet-contents.md` and
  `docs/specs/initial-character-domain-model.md`.

## Recommended Next Step

The next logical session should build on the current shell instead of
restructuring it again:

1. Replace the curated compendium catalog asset with a generated or parsed
   source derived from `local-assets`.
2. Expand the current minimal create flow toward the approved guided builder
   sections.
3. Add write-side application services and mapping boundaries for character
   creation, character-card summaries, and character-sheet view models.
4. Extend the first Drift schema toward the approved MVP character model.
5. Break the approved `create -> save -> card -> open sheet` flow into
   concrete implementation tasks in `lib/`.
6. Keep `HP` in scope as real MVP character-sheet data, not as a deferred
   combat placeholder.

Next-session starting point:

- Start from the existing Drift schema, repository boundary, and minimal
  create/save/open flow.
- Use `assets/compendium/catalog.json` plus the `CompendiumRepository`
  boundary as the active source of truth for local catalog data until a
  generator or parser replaces that asset.
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
