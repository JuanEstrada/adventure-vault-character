# Adventure Vault Character - Project Snapshot

## Last Update
2026-03-23

## Role of This Document

This file is the operational project-state summary.

For session restart, use `docs/project/SESSION_RESUME.md` first.
Use this snapshot for a compact view of phase, focus, progress, pending work,
and delivery risks.

## Project Phase

Early implementation bootstrap

## Current Focus

Translating the now-documented MVP flow, first character-sheet layout, and
initial character-domain proposal into implementation boundaries for `lib/`
and Drift.

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
  guided character creation, character cards, and character sheet layout.
- The first character sheet contents are defined in proposal form.
- The first character-domain model is defined in proposal form.
- The builder flow now covers overview, XML-load entry point visibility,
  ability scores, class/level/experience, equipment, finishing details, and
  finalize validation.
- Session continuity simplified around a single handoff file:
  `docs/project/SESSION_RESUME.md`.

## Work In Progress

- Defining the first implementation-oriented workflow.
- Defining the first package and module boundaries.
- Translating the documented MVP flow and proposed domain model into
  persistence and application structure.

## Pending Work

- Define the initial application modules and package boundaries.
- Define the first Drift schema from the proposed character model.
- Define application services and mappers for character creation, card
  summaries, and character-sheet rendering.
- Add the first production dependencies required by the accepted architecture.
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
- Guided creation places class/level/experience before equipment.
- Guided creation includes equipment and finishing-details before save.
- Finalization validates required creation sections before persistence.
- The builder overview exposes `LOAD` for XML as a documented entry point, not
  a required MVP import implementation.
- The first character sheet uses a panel-based layout.
- The first character sheet includes real hit-points content.
- `Equipment` can remain a simple placeholder panel in the first sheet.

## Next Recommended Steps

1. Define the first `lib/` package and module boundaries.
2. Define the first Drift schema from the proposed domain model.
3. Break the approved MVP flow into implementation tasks in `lib/`.
4. Update `SESSION_RESUME.md` and this snapshot after each relevant session.

## Next Session Guardrail

- Resume by defining implementation boundaries, not by reopening closed MVP
  flow decisions.
- Use the approved flow and proposed domain-model docs as the working basis
  unless a new product decision replaces them.

## Risks and Unknowns

- The first domain model is not yet finalized.
- The compendium-backed creation flow depends on structured local content
  modeling that does not yet exist.
- Background bonuses and social perks still need a normalized representation
  that preserves fidelity without pushing rules logic into widgets.
- Ability score method state and assignment provenance still need a normalized
  representation that supports validation and later editing.
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
