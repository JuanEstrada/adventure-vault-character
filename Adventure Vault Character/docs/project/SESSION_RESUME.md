# Session Resume

Last updated: 2026-03-19

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
implement the first MVP shell. The current work is still about closing the
remaining MVP decisions before opening real feature implementation.

## MVP Slice In Focus

The first implementation slice is the offline path from app launch to a usable
character sheet.

Canonical MVP flow:

1. App launch
2. Bootstrap startup
3. Access screen
4. `Continuar offline`
5. Main menu
6. `Crear personaje nuevo`
7. Guided character creation
8. Local save
9. Character sheet

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
- Character creation is guided, not a free-form advanced builder.
- Creation currently includes race, name, background, ability scores, class,
  level, and experience.
- Race, background, and class data are compendium-backed.
- Ability scores are part of the minimum valid character record.
- Experience and level must stay synchronized.
- Background bonuses and social perks must be shown on the character sheet.
- Final ability scores and their modifiers must be shown on the character
  sheet.
- Successful creation persists locally and opens the character sheet.

## Main Open Product Decisions

These are the highest-value unresolved items:

1. Define the exact minimum contents of the first character sheet.
2. Define the first core domain model for characters.
3. Define the first package and module boundaries for `lib/`.
4. Define how background bonuses and social perks should be represented in
   persistence and view models.
5. Define how ability score methods and assigned values should be represented
   in persistence and view models.

Resolved MVP decision:

- Guided creation does require one additional mandatory step before save:
  background selection.
- The reason is product-driven, not heavy rules automation: background brings
  bonuses and social perks from the compendium that the player must be able to
  review later on the character sheet.
- Guided creation also requires a mandatory ability score step before save.
- The MVP ability score step is based on the builder reference UI and supports
  at least random generation with manual assignment and point buy with visible
  remaining budget.

## Recommended Next Step

Do not jump straight into UI implementation.

The next logical session should use the updated minimum-valid-character
definition:

1. Define the first character sheet contents from race, name, background,
   ability scores, class, level, and experience.
2. Derive the initial domain entities from those required fields.
3. Define how background bonuses and social perks are stored and rendered.
4. Define how ability score methods, assigned values, and modifiers are stored
   and rendered.
5. Only then open implementation tasks in `lib/`.

Next-session starting point:

- Start only with the first character sheet contents.
- Do not advance to domain modeling or implementation until that scope is
  explicitly confirmed in-session.

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
