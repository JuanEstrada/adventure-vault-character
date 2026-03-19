# Adventure Vault Character - Project Snapshot

## Last Update
2026-03-19

## Project Phase
Early implementation bootstrap

## Current Focus
Aligning the generated Flutter project with the documented architecture,
stabilizing the repository baseline, and preparing the first MVP
implementation slice.

## Project Summary
Adventure Vault Character is an Android-first Flutter application for Dungeons
& Dragons players to create, manage, and use their characters. The project is
designed with an offline-first architecture and is part of a larger ecosystem
that may include a separate Dungeon Master application.

## Project Guidelines

Official project rules and decision criteria are defined in
`docs/project/PROJECT_GUIDELINES.md`.

## Confirmed Architectural Decisions
- Use Flutter and Dart for the client application
  -> `docs/adr/ADR-006-use-flutter-for-client-application.md`

- Use offline-first architecture
  -> `docs/adr/ADR-002-offline-first-architecture.md`

- Use Drift over SQLite as local database
  -> `docs/adr/ADR-007-use-drift-for-local-persistence.md`

- Separate Player and DM apps
  -> `docs/adr/ADR-004-separate-player-and-dm-apps.md`

## Architecture Documentation
- Introduction and goals
  -> `docs/architecture/01-introduction-and-goals.md`

- Constraints
  -> `docs/architecture/02-constraints.md`

- Context and scope
  -> `docs/architecture/03-context-and-scope.md`

- Solution strategy
  -> `docs/architecture/04-solution-strategy.md`

- Building block view
  -> `docs/architecture/05-building-block-view.md`

- Runtime view
  -> `docs/architecture/06-runtime-view.md`

- Deployment view
  -> `docs/architecture/07-deployment-view.md`

- Cross-cutting concepts
  -> `docs/architecture/08-cross-cutting-concepts.md`

- Architecture decisions summary
  -> `docs/architecture/09-architecture-decisions.md`

- Quality requirements
  -> `docs/architecture/10-quality-requirements.md`

- Risks and technical debt
  -> `docs/architecture/11-risks-and-technical-debt.md`

- Glossary
  -> `docs/architecture/12-glossary.md`

## Diagram Documentation (C4)
- System Context
  -> `docs/diagrams/context.md`

- Containers
  -> `docs/diagrams/containers.md`

- Components
  -> `docs/diagrams/components.md`

## Work Completed
- Initial project documentation structure has been defined.
- Generated Flutter project scaffolding has been added to the repository.
- arc42 documentation sections have been created.
- Initial ADR structure has been created.
- C4-related diagram documentation files have been created.
- Documentation navigation has been improved with central index pages.
- Project and ADR index pages have been added.
- A dedicated specs directory has been added for implementation-facing
  requirements.
- Diagram views have been aligned with the Flutter-based architecture.
- Core strategic decisions have been documented:
  - Flutter and Dart for the client application
  - Offline-first architecture
  - Drift over SQLite
  - Separate Player and DM apps
- AI-oriented repository context structure has been defined.
- Platform directories are present for Android, iOS, web, Windows, Linux,
  macOS, and Flutter test support.
- A minimal application bootstrap screen exists in `lib/main.dart`.

## Work In Progress
- Defining the first implementation-oriented workflow and package boundaries.
- Consolidating repository-level documentation for faster contributor
  onboarding.
- Cleaning up generated starter artifacts that still conflict with the current
  application bootstrap.

## Pending Work
- Define the first implementation slice of the application.
- Define the core domain model for characters.
- Define the initial application modules and package boundaries.
- Define the MVP scope.
- Define the first development milestones.
- Align architecture documents with implementation priorities.
- Replace remaining starter-template placeholders in code, tests, and platform
  metadata.
- Add implementation documentation once source code exists.
- Evaluate future usability specs such as guided help for new players.
- Add the first production dependencies required by the accepted architecture,
  starting with persistence and state boundaries.

## Next Recommended Steps
1. Define the MVP scope for Adventure Vault Character.
2. Define the core domain entities for the character system.
3. Define the first implementation milestone.
4. Fix the broken starter test and restore a green `flutter analyze` and
   `flutter test` baseline.
5. Replace example Android identifiers and other generated placeholder
   metadata.
6. Map architecture decisions to implementation tasks and update this snapshot
   after each relevant project session.

## Risks or Unknowns
- MVP scope is not yet explicitly consolidated in this file.
- Core domain model is not yet finalized.
- The repository has generated platform scaffolding, but the application code
  is still only a minimal bootstrap and does not yet realize the documented
  architecture.
- The current baseline is not green because the generated widget test still
  references the old counter template app.
- Future synchronization and network features are not yet defined for
  implementation.
- Legal and content-boundary constraints for D&D-related material may require
  later refinement.

## Context for Future AI Sessions
See `docs/project/AI_SESSION_GUIDE.md` for operational continuity guidance.

## Continuation Prompt
Use this snapshot as the current project state. Continue from the
early implementation stage, identify the most logical next step, and keep all
new work aligned with the existing architecture, ADR, diagram, and specs
documentation.

## Information That Still Needs Consolidation
- Final MVP feature list
- Core domain entity definitions
- Initial package and module structure
- Implementation roadmap tied to milestones
- Initial production-ready Flutter module layout
- Future-facing usability specs in `docs/project/FUTURE_SPECS.md`
