# Architecture Index

This directory contains the arc42 architecture documentation for
Adventure Vault Character. The content is split into one file per section so
the architecture can evolve incrementally without losing the standard
structure.

Policy note: `docs/README.md` is the canonical documentation policy.

## arc42 Sections

| Section | Focus | File |
| --- | --- | --- |
| 01 | Introduction, goals, stakeholders | [01. Introduction and Goals](01-introduction-and-goals.md) |
| 02 | Business, technical, and documentation constraints | [02. Constraints](02-constraints.md) |
| 03 | System boundary, actors, and external systems | [03. Context and Scope](03-context-and-scope.md) |
| 04 | Core architectural approach | [04. Solution Strategy](04-solution-strategy.md) |
| 05 | System, container, and component breakdown | [05. Building Block View](05-building-block-view.md) |
| 06 | Critical runtime scenarios | [06. Runtime View](06-runtime-view.md) |
| 07 | Deployment assumptions and runtime environment | [07. Deployment View](07-deployment-view.md) |
| 08 | Cross-cutting concepts and recurring design rules | [08. Cross-Cutting Concepts](08-cross-cutting-concepts.md) |
| 09 | ADR summary and links | [09. Architecture Decisions](09-architecture-decisions.md) |
| 10 | Quality goals and quality attributes | [10. Quality Requirements](10-quality-requirements.md) |
| 11 | Risks, unknowns, and technical debt | [11. Risks and Technical Debt](11-risks-and-technical-debt.md) |
| 12 | Domain and technical terminology | [12. Glossary](12-glossary.md) |

## Related Architecture Artifacts

- ADRs: [ADR Index](../adr/README.md)
- Diagrams: [Diagrams Index](../diagrams/README.md)
- Project state: [Project Snapshot](../project/PROJECT_SNAPSHOT.md)
- Specifications: [Specifications Index](../specs/README.md)

## Recommended Reading Path

If you are new to the project, read the sections in this order:

1. [01. Introduction and Goals](01-introduction-and-goals.md)
2. [03. Context and Scope](03-context-and-scope.md)
3. [04. Solution Strategy](04-solution-strategy.md)
4. [05. Building Block View](05-building-block-view.md)
5. [09. Architecture Decisions](09-architecture-decisions.md)
6. [10. Quality Requirements](10-quality-requirements.md)

## Current State

The architecture describes the intended implementation of the player-facing
Flutter application targeting Android first. It should be treated as the
baseline for future codebase scaffolding, MVP definition, and implementation
planning.
