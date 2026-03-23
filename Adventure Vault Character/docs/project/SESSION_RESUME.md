# Session Resume

Last updated: 2026-03-23

This is the single file to read first when resuming work on Adventure Vault
Character. It consolidates the current product, architecture, repository
state, active MVP decisions, and the exact open questions that still block the
first real implementation slice.

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

Verified on 2026-03-19:

- Flutter project scaffolding exists for Android, iOS, web, Windows, Linux,
  and macOS.
- `lib/main.dart` is still a minimal bootstrap screen.
- `test/widget_test.dart` exists and matches the current bootstrap screen.
- `flutter analyze` passes.
- `flutter test` passes.

This means the repository baseline is currently green, but the app is still
pre-MVP in implementation terms.

## Current Phase

Early implementation bootstrap.

The project has strong documentation coverage, but `lib/` still does not
implement the first MVP shell. The current work has advanced from basic MVP
uncertainty into implementation preparation: the main product flow, the first
character sheet structure, and the first character-domain proposal are now
documented, and the next step is to translate them into package boundaries,
persistence, and application tasks.

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

1. Define the first package and module boundaries for `lib/`.
2. Define the first Drift schema from the proposed domain model.
3. Define application services and task breakdown for `create -> save -> card
   -> open sheet`.
4. Decide when XML import moves from documented entry point into a real
   implementation slice.
5. Decide when deeper `Combat` features and the `Equipment` panel move from
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

Do not jump straight into UI implementation.

The next logical session should use the documented MVP flow and domain
proposal:

1. Define the first `lib/` package and module boundaries.
2. Define the first Drift schema from the proposed character model.
3. Define application services and mapping boundaries for character creation,
   character-card summaries, and character-sheet view models.
4. Break the approved MVP flow into concrete implementation tasks in `lib/`.
5. Keep `HP` in scope as real MVP character-sheet data, not as a deferred
   combat placeholder.

Next-session starting point:

- Start with package boundaries and persistence planning.
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
