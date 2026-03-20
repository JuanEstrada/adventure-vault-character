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
- Creation currently includes race, name, class, level, and experience.
- Race and class data are compendium-backed.
- Experience and level must stay synchronized.
- Successful creation persists locally and opens the character sheet.

## Main Open Product Decisions

These are the highest-value unresolved items:

1. Decide whether guided creation needs one additional mandatory step before
   save.
2. Define the exact minimum contents of the first character sheet.
3. Define the first core domain model for characters.
4. Define the first package and module boundaries for `lib/`.

The most important open question is the first one, because it defines the
minimum valid character record in the domain.

Current interpretation of that open question:

- If the MVP goal is fast local save plus later editing, then no additional
  mandatory step is required.
- If the MVP goal is that the first saved character is already session-usable,
  then attributes are the strongest candidate for an additional required step.

No final decision has been committed yet in the docs.

## Recommended Next Step

Do not jump straight into UI implementation.

The next logical session should close the minimum-valid-character definition:

1. Decide whether guided creation stops at race, name, class, level, and
   experience, or adds one more mandatory step.
2. Define the first character sheet contents from that decision.
3. Derive the initial domain entities from those required fields.
4. Only then open implementation tasks in `lib/`.

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
