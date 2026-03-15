# AI Context – Adventure Vault Character

## Project Overview
Adventure Vault Character is an Android application for managing Dungeons & Dragons characters.

The application is designed with an offline-first approach and focuses on allowing players to create, manage, and use characters efficiently during tabletop sessions.

The project is part of a broader product vision that includes two separate applications:

- Adventure Vault Character (player-focused app)
- Adventure Vault Master (Dungeon Master-focused app)

## Technology Stack
- Platform: Android
- Language: Kotlin
- Architecture approach: Offline-first
- Local database: Room

Additional technologies may be defined as the project evolves.

## Documentation Structure

### Architecture (arc42)
Location: `docs/architecture/`

This folder contains the formal architecture documentation, including:
- introduction and goals
- constraints
- context and scope
- solution strategy
- building block view
- runtime view
- deployment view
- cross-cutting concepts
- architecture decisions summary
- quality requirements
- risks and technical debt
- glossary

### Architectural Decisions (ADR)
Location: `docs/adr/`

This folder contains architecture decision records.

Current ADRs:
- `ADR-001-use-kotlin-for-android.md`
- `ADR-002-offline-first-architecture.md`
- `ADR-003-use-room-database.md`
- `ADR-004-separate-player-and-dm-apps.md`

### Diagrams (C4 Model)
Location: `docs/diagrams/`

This folder contains:
- `context.md`
- `containers.md`
- `components.md`

### Project State
Location: `docs/project/PROJECT_SNAPSHOT.md`

This file contains the current operational state of the project:
- current phase
- completed work
- work in progress
- pending work
- next recommended steps

Always read this file first before proposing new work.

## How AI Should Navigate This Project
1. Read `docs/project/PROJECT_SNAPSHOT.md` first.
2. Use `docs/adr/` before suggesting changes to architecture.
3. Use `docs/architecture/` for formal architecture understanding.
4. Use `docs/diagrams/` for structural views.
5. Do not duplicate existing documentation.
6. Reference existing documents instead of rewriting them.

## Development Philosophy
- Offline-first design
- Clear separation between player tools and DM tools
- Structured architecture documentation
- Architectural decisions documented as ADRs
- Documentation maintained as code

## Quick Context Block
Project: Adventure Vault Character  
Platform: Android  
Language: Kotlin  
Architecture: Offline-first  
Database: Room  
Documentation: arc42 + ADR + C4  
Project State: `docs/project/PROJECT_SNAPSHOT.md`