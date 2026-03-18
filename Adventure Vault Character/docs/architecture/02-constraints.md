# 02. Constraints

## Business Constraints

- Adventure Vault Character must be documented and designed in detail before the Dungeon Master application.
- The architecture must keep the player application independent while allowing future integration with Adventure Vault Master.
- The product must automate core D20 mechanics instead of acting only as a passive character sheet.

## Technical Constraints

- The application runs on Android devices.
- The application must work offline as a primary operating mode.
- The system must support future synchronization, but no backend platform is defined yet.
- Rules content may be imported through XML.
- The codebase is expected to be modular.
- Kotlin is the implementation language.
- The Android Jetpack ecosystem is the assumed application foundation.
- Jetpack Compose is the primary UI technology.
- Local persistence is based on Room over SQLite.
- The architecture must remain local-first.

## Documentation Constraints

- Architecture documentation is stored as Markdown in the repository.
- arc42 is the primary structure for architecture documentation.
- C4 concepts are expressed as textual architecture descriptions in Markdown.
- Architectural decisions are captured as ADR files.

## Design Implications

These constraints favor a modular Android architecture with strong local persistence, a dedicated rules and dice domain, controlled XML import processing, and explicit seams for later synchronization and DM-facing interaction.
