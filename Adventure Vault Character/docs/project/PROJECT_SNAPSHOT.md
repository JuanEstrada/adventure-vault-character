# Adventure Vault Character - Project Snapshot

## Last Update
2026-03-19

## Role of This Document

This file is the operational project-state summary.

For session restart, use `docs/project/SESSION_RESUME.md` first.
Use this snapshot for a compact view of phase, focus, progress, pending work,
and delivery risks.

## Project Phase

Early implementation bootstrap

## Current Focus

Closing the remaining MVP decisions around startup, access, main menu,
guided character creation, and the first usable character sheet before
opening real implementation in `lib/`.

## Repository State

- Flutter scaffolding is present for Android, iOS, web, Windows, Linux,
  and macOS.
- `lib/main.dart` is still a minimal bootstrap screen.
- The current repository baseline is green for `flutter analyze` and
  `flutter test`.
- The codebase is still pre-MVP from an implementation standpoint.

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
  and guided character creation.
- Session continuity simplified around a single handoff file:
  `docs/project/SESSION_RESUME.md`.

## Work In Progress

- Defining the first implementation-oriented workflow.
- Defining the first package and module boundaries.
- Closing the minimum-valid-character definition for the MVP.

## Pending Work

- Decide whether guided character creation needs one additional mandatory step
  before save.
- Define the first character sheet contents.
- Define the core domain model for characters.
- Define the initial application modules and package boundaries.
- Add the first production dependencies required by the accepted architecture.
- Map the approved MVP flow into implementation tasks in `lib/`.
- Add implementation documentation once production code exists.

## Next Recommended Steps

1. Close the minimum-valid-character decision for guided creation.
2. Define the first character sheet contents from that decision.
3. Derive the first domain entities and module boundaries.
4. Break the approved MVP flow into implementation tasks in `lib/`.
5. Update `SESSION_RESUME.md` and this snapshot after each relevant session.

## Risks and Unknowns

- The MVP is materially outlined but still blocked by the unresolved stopping
  point of guided creation.
- The first domain model is not yet finalized.
- The compendium-backed creation flow depends on structured local content
  modeling that does not yet exist.
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
