# Documentation Hub

This repository currently contains the documentation baseline for
Adventure Vault Character together with the generated Flutter project
scaffolding. It captures the target architecture, architectural
decisions, diagrams, and project planning that now guide the first
implementation slices.

## Start Here

- [Session Resume](project/SESSION_RESUME.md): single-file handoff for
  resuming a project session.
- [Project Index](project/README.md): current status, roadmap, future specs,
  and AI session guidance.
- [Project Snapshot](project/PROJECT_SNAPSHOT.md): current phase, completed
  work, pending work, and next recommended steps.
- [Project Guidelines](project/PROJECT_GUIDELINES.md): official product and
  technical rules for evaluating proposals.
- [Future Specs](project/FUTURE_SPECS.md): candidate features intentionally
  deferred for later planning.
- [Specifications Index](specs/README.md): accepted or in-planning functional
  specs.
- [Architecture Index](architecture/README.md): guided entry point to the
  arc42 architecture documentation.
- [ADR Index](adr/README.md): decision log and current accepted architecture
  constraints.
- [Roadmap](project/ROADMAP.md): phased implementation direction.

## Documentation Map

| Area | Purpose | Entry Point |
| --- | --- | --- |
| Session continuity | Single-file project handoff | [Session Resume](project/SESSION_RESUME.md) |
| Project index | Central navigation for planning docs | [Project Index](project/README.md) |
| Project state | Current status and next steps | [Project Snapshot](project/PROJECT_SNAPSHOT.md) |
| Project guidelines | Official decision and implementation rules | [Project Guidelines](project/PROJECT_GUIDELINES.md) |
| Future features | Deferred or speculative feature candidates | [Future Specs](project/FUTURE_SPECS.md) |
| Specifications | Accepted or in-planning functional specs | [Specifications Index](specs/README.md) |
| Architecture | arc42-based system description | [Architecture Index](architecture/README.md) |
| ADRs | Decision record history | [ADR Index](adr/README.md) |
| Diagrams | C4 textual views | [Context Diagram](diagrams/context.md) |

## Recommended Reading Order

1. Read the [Session Resume](project/SESSION_RESUME.md).
2. Review the [Project Guidelines](project/PROJECT_GUIDELINES.md).
3. Review the [Project Index](project/README.md).
4. Review the [Architecture Index](architecture/README.md).
5. Scan the key [ADRs](adr/README.md).
6. Use the [Roadmap](project/ROADMAP.md) to connect architecture to delivery
   planning.

## Repository Status

At the time of this update, the repository contains documentation, project
planning artifacts, Flutter scaffolding for Android, iOS, web, desktop, and a
real app shell under `lib/src/`. The current codebase already implements the
startup path `bootstrap -> access -> main menu`, and the next slice is local
persistence plus `create -> save -> card -> open sheet`. The repository
baseline is green for `flutter analyze` and `flutter test`.

## Local Reference Assets

- `local-ui-assets/` contains visual reference images used by multiple specs
  as UI direction examples.
- `local-assets/` contains source reference material such as XML samples and
  imported rule-content documents.
- Specs may reference `local-ui-assets/` directly when describing layouts or
  interaction flows.
- `local-assets/` is project reference material and should not be assumed to
  be part of the app runtime asset bundle.
