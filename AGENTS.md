# AGENTS.md

## Architecture & Core Conventions
- **Structure**: Adhere strictly to the Flutter feature-first structure (Presentation, Domain, Data layers).
- **Data Persistence**: The application uses `Drift` (SQLite) for persistent data storage. Repository implementation must respect the separation between in-memory and persistent data sources.
- **Domain Logic**: Domain models define the core business rules (e.g., Character rules, Compendium definitions). Changes to domain models should drive updates to the UI and data layer.
- **Code Style**: Prefer small, incremental changes and reuse existing providers/repositories.

## Development Workflow
- **Formatting & Analysis**: Always run `dart format` and `flutter analyze` before committing to ensure code quality and adherence to project style.
- **Testing**: Run `flutter test` when working in the `features` directory to verify changes.
- **Code Language**: Keep documentation and user-facing text in English.

## Tooling Safety
- **Delegation**: Subagents must use only explicitly available tools. Do not assume external namespaces exist.
- **File Access**: Prefer session-native tools (Read/Glob/Grep/Edit) over shell commands for file operations.

## Editing Reliability
- **Markdown Updates**: Prefer `apply_patch` over exact-string replacement when updating Markdown trackers, plans, or tables.
- **Retry Rule**: If an edit fails, re-read the smallest relevant file section and retry with `apply_patch`.
- **Verification**: Do not report a documentation update as complete until the edited lines are re-read and verified.
- **No Skipping Ahead**: Do not continue to the next task if the current requested file update failed.

## Before Finishing
- Run `dart format`
- Run `flutter analyze`
- Run `flutter test` if code in the `lib/src/features` directory is modified.
- Update `SESSION_RESUME.md` and `PROJECT_SNAPSHOT.md` when relevant.
- Record unresolved bugs/missing capabilities in the session roadmap.
