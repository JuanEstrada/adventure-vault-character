# AI Session Guide

Use this file when continuing work in future AI-assisted sessions.

## Start Here

1. Read [PROJECT_SNAPSHOT.md](PROJECT_SNAPSHOT.md) for the current project
   state.
2. Read [PROJECT_GUIDELINES.md](PROJECT_GUIDELINES.md) before proposing new
   features, architecture changes, or implementation tradeoffs.
3. Use [../README.md](../README.md) for documentation navigation.
4. Read [../adr/README.md](../adr/README.md) before changing architectural
   direction.
5. Use [../architecture/README.md](../architecture/README.md) for the formal
   architecture baseline.
6. Use [../specs/README.md](../specs/README.md) for implementation-facing
   product specs.

## Current Architectural Baseline

- Platform: Android
- Language: Kotlin
- UI: Jetpack Compose
- Persistence: Room over SQLite
- Architecture: offline-first
- Product boundary: separate player and DM applications

## Working Rules

- Do not duplicate documentation when an existing source-of-truth document
  already covers the topic.
- Treat accepted ADRs as active constraints.
- Keep architecture docs aligned with implementation planning.
- Prefer updating index pages when adding new documents.
- Record new product requirements in `docs/specs/` when they are accepted for
  implementation planning.

## Decision Priority

When a tradeoff is required, evaluate options in this order:

1. Exactitud de reglas
2. Alineación con decisiones y lineamientos del proyecto
3. Escalabilidad futura
4. Simplicidad y mantenibilidad de implementación
5. Optimización avanzada
