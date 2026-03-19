# Adventure Vault Character – Project Snapshot

## Last Update
2026-03-18

## Project Phase
Architecture

## Current Focus
Preparing the repository for implementation planning with clearer
documentation boundaries, Compose-aware architecture views, and dedicated spec
entry points.

## Project Summary
Adventure Vault Character is an Android application for Dungeons & Dragons players to create, manage, and use their characters. The project is designed with an offline-first architecture and is part of a larger ecosystem that may include a separate Dungeon Master application.

## Project Guidelines

Official project rules and decision criteria are defined in
`docs/project/PROJECT_GUIDELINES.md`.

## Confirmed Architectural Decisions
- Use Kotlin for Android  
  → `docs/adr/ADR-001-use-kotlin-for-android.md`

- Use offline-first architecture  
  → `docs/adr/ADR-002-offline-first-architecture.md`

- Use Room as local database  
  → `docs/adr/ADR-003-use-room-database.md`

- Separate Player and DM apps  
  → `docs/adr/ADR-004-separate-player-and-dm-apps.md`

- Use Jetpack Compose for UI  
  → `docs/adr/ADR-005-use-jetpack-compose-for-ui.md`

## Architecture Documentation
- Introduction and goals  
  → `docs/architecture/01-introduction-and-goals.md`

- Constraints  
  → `docs/architecture/02-constraints.md`

- Context and scope  
  → `docs/architecture/03-context-and-scope.md`

- Solution strategy  
  → `docs/architecture/04-solution-strategy.md`

- Building block view  
  → `docs/architecture/05-building-block-view.md`

- Runtime view  
  → `docs/architecture/06-runtime-view.md`

- Deployment view  
  → `docs/architecture/07-deployment-view.md`

- Cross-cutting concepts  
  → `docs/architecture/08-cross-cutting-concepts.md`

- Architecture decisions summary  
  → `docs/architecture/09-architecture-decisions.md`

- Quality requirements  
  → `docs/architecture/10-quality-requirements.md`

- Risks and technical debt  
  → `docs/architecture/11-risks-and-technical-debt.md`

- Glossary  
  → `docs/architecture/12-glossary.md`

## Diagram Documentation (C4)
- System Context  
  → `docs/diagrams/context.md`

- Containers  
  → `docs/diagrams/containers.md`

- Components  
  → `docs/diagrams/components.md`

## Work Completed
- Initial project documentation structure has been defined.
- arc42 documentation sections have been created.
- Initial ADR structure has been created.
- C4-related diagram documentation files have been created.
- Documentation navigation has been improved with central index pages.
- Project and ADR index pages have been added.
- A dedicated specs directory has been added for implementation-facing
  requirements.
- Diagram views have been aligned with the Compose-based architecture.
- Core strategic decisions have been documented:
  - Kotlin for Android
  - Offline-first architecture
  - Room database
  - Jetpack Compose for UI
  - Separate Player and DM apps
- AI-oriented repository context structure has been defined.

## Work In Progress
- Defining implementation-oriented project workflow.
- Transitioning from architecture definition to implementation planning.
- Consolidating repository-level documentation for faster contributor
  onboarding.

## Pending Work
- Define the first implementation slice of the application.
- Define the core domain model for characters.
- Define the initial application modules/packages.
- Define the MVP scope.
- Define the first development milestones.
- Align architecture documents with implementation priorities.
- Start codebase scaffolding if not yet created.
- Add implementation documentation once source code exists.
- Evaluate future usability specs such as guided help for new players.

## Next Recommended Steps
1. Define the MVP scope for Adventure Vault Character.
2. Define the core domain entities for the character system.
3. Define the first implementation milestone.
4. Create the initial Android project structure.
5. Map architecture decisions to implementation tasks.
6. Update this snapshot after each relevant project session.

## Risks or Unknowns
- MVP scope is not yet explicitly consolidated in this file.
- Core domain model is not yet finalized.
- The repository still contains documentation only; no Android source tree is present yet.
- Future synchronization/network features are not yet defined for implementation.
- Legal and content-boundary constraints for D&D-related material may require later refinement.

## Context for Future AI Sessions
See `docs/project/AI_SESSION_GUIDE.md` for operational continuity guidance.

## Continuation Prompt
Use this snapshot as the current project state. Continue from the
implementation planning stage, identify the most logical next step, and keep
all new work aligned with the existing architecture, ADR, diagram, and specs
documentation.

## Information That Still Needs Consolidation
- Final MVP feature list
- Core domain entity definitions
- Initial package/module structure
- Implementation roadmap tied to milestones
- Initial Android project scaffolding and module layout
- Future-facing usability specs in `docs/project/FUTURE_SPECS.md`
