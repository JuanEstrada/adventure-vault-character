# Adventure Vault

Adventure Vault is a family of applications intended to support tabletop
role-playing sessions, starting with Dungeons & Dragons. The product vision
includes one application for players and one future application for Dungeon
Masters.

## Adventure Vault Character

Adventure Vault Character is the current project in scope. It is an
Android-first Flutter application for players who need to create and manage
characters, roll dice with modifiers, track spells and inventory, maintain
character statistics, and import rules content through XML while remaining
fully usable offline.

## Documentation

- Documentation hub: [docs/README.md](docs/README.md)
- Session resume: [docs/project/SESSION_RESUME.md](docs/project/SESSION_RESUME.md)
- Project docs index: [docs/project/README.md](docs/project/README.md)
- Architecture index: [docs/architecture/README.md](docs/architecture/README.md)
- Architecture decisions: [docs/adr/README.md](docs/adr/README.md)
- C4 textual diagrams: [docs/diagrams/context.md](docs/diagrams/context.md)
- Current project state: [docs/project/PROJECT_SNAPSHOT.md](docs/project/PROJECT_SNAPSHOT.md)

## Scope Status

The current architecture documentation covers Adventure Vault Character in
detail. Adventure Vault Master is treated as a future related system whose
integration needs influence today's design decisions, especially around
offline operation, synchronization readiness, and modular boundaries.

## Repository Status

The repository now contains the project documentation baseline, Flutter
platform scaffolding for Android, iOS, web, desktop, and the first production
app shell under `lib/src/`. The current coded flow covers
`bootstrap -> access -> main menu` with repository boundaries for character
summaries, while character creation, Drift-backed persistence, and the
character sheet remain the next implementation slices.
