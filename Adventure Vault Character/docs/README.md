# Documentation Hub

Use this file as the canonical documentation policy for Adventure Vault
Character.

## Documentation Policy (Canonical)

1. Repo docs are the durable source of truth.
2. External working memory complements repo docs; it does not replace them.
3. One topic, one home: keep a single canonical document per topic and link
   to it from index files.
4. Keep all documentation in English.
5. Keep durable, reviewable decisions in git-versioned docs; keep transient
   session notes outside the repo unless they are promoted.

## Purpose Boundaries

| Area | Owns | Does Not Own |
| --- | --- | --- |
| `docs/specs/` | Accepted or in-planning product requirements and behavior | Session notes, architecture rationale, ADR decisions |
| `docs/project/` | Current project state, continuity, runbooks, and delivery direction | Long-lived architecture definition or duplicated spec content |
| `docs/architecture/` | arc42 architecture baseline and cross-cutting technical structure | Daily status notes or decision-history details |
| `docs/adr/` | Durable architecture decisions and status history | Feature specs, implementation checklists, or session logs |
| `docs/diagrams/` | Durable diagram views that support architecture and specs | Narrative policy text already owned elsewhere |
| External session memory | Transient notes, working memory, and in-session continuity | Replacement for durable repo documentation |

## Cleanup Rules

- Keep durable docs in the repository.
- Keep transient working notes outside the repo.
- Promote durable findings into the correct repo doc when they
  become stable decisions, requirements, or architecture facts.
- Keep docs in English.
- Avoid duplicate sources of truth; link to canonical docs instead of restating
  them.

## Start Here

- [Session Resume](project/SESSION_RESUME.md): **canonical short handoff** for
  continuing the next work session.
- [Project Snapshot](project/PROJECT_SNAPSHOT.md): **canonical consolidated
  project state** (status, implemented baseline, and next steps).
- [Architecture Index](architecture/README.md): **canonical architecture
  baseline entry point** (arc42 structure and related artifacts).
- [Roadmap](project/ROADMAP.md): **canonical delivery roadmap**.
- [Project Guidelines](project/PROJECT_GUIDELINES.md): **canonical project
  rules** for product and technical decisions.
- [Project Index](project/README.md): routing index for project-governance
  files under `docs/project/`.
- [Specifications Index](specs/README.md): accepted or in-planning functional
  specifications.
- [ADR Index](adr/README.md): architecture decision history and status.
- [Diagrams Index](diagrams/README.md): durable diagram map and ownership
  boundaries.

## Documentation Map

| Area | Purpose | Entry Point |
| --- | --- | --- |
| Session continuity | Single-file project handoff | [Session Resume](project/SESSION_RESUME.md) |
| Project state | Consolidated current-state reference | [Project Snapshot](project/PROJECT_SNAPSHOT.md) |
| Project index | Central routing for project governance docs | [Project Index](project/README.md) |
| Project guidelines | Official decision and implementation rules | [Project Guidelines](project/PROJECT_GUIDELINES.md) |
| AI session runbook | Canonical execution guide for AI sessions | [AI Session Runbook](project/AI_SESSION_GUIDE.md) |
| Future features | Deferred or speculative feature candidates | [Future Specs](project/FUTURE_SPECS.md) |
| Specifications | Accepted or in-planning functional specs | [Specifications Index](specs/README.md) |
| Architecture | Canonical arc42 architecture baseline | [Architecture Index](architecture/README.md) |
| ADRs | Decision record history | [ADR Index](adr/README.md) |
| Diagrams | Durable diagram views and links | [Diagrams Index](diagrams/README.md) |
| Session memory | Transient AI session continuity notes | Non-repo working notes (promoted when durable) |

## Recommended Reading Order

1. Read the [Session Resume](project/SESSION_RESUME.md).
2. Review the [Project Guidelines](project/PROJECT_GUIDELINES.md).
3. Review the [Project Snapshot](project/PROJECT_SNAPSHOT.md).
4. Review the [Architecture Index](architecture/README.md).
5. Scan the key [ADRs](adr/README.md).
6. Review [Diagrams Index](diagrams/README.md) for visual references.
7. Use the [Roadmap](project/ROADMAP.md) to connect architecture to delivery
   planning.

## Local Reference Assets

- `local-ui-assets/` contains visual reference images used by multiple specs
  as UI direction examples.
- `local-assets/FightClub5eXML-master/` contains the active local XML source
  tree currently consumed by the app runtime for SRD 5.5e compendium data.
- `local-assets/reference/` contains project reference material such as XML
  samples, imported rule-content documents, and larger raw source files.
- `local-assets/templates/` contains reusable authoring templates for future
  compendium work.
- Specs may reference `local-ui-assets/` directly when describing layouts or
  interaction flows.
- Only the XML files explicitly declared in `pubspec.yaml` should be assumed
  to be part of the app runtime asset bundle.
