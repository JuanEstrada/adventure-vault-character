# AGENTS.md

## Architecture
- Preserve the existing Flutter feature-first structure
- Respect presentation, application, domain, and data layers
- Keep Drift schema and migrations synchronized

## Code Style
- Prefer small, incremental changes
- Reuse existing providers, repositories, DAOs, and patterns
- Do not rewrite working code unnecessarily
- Keep code null-safe and strongly typed

## Before Finishing
- Run dart format
- Run flutter analyze
- Run tests if affected
- Update SESSION_RESUME.md and PROJECT_SNAPSHOT.md when relevant
