# AGENTS.md

## Workspace

- Keep documentation, comments, identifiers, and user-facing text in English unless the project explicitly states otherwise.

## Architecture

- Preserve the existing Flutter feature-first structure
- Respect presentation, application, domain, and data layers
- Keep Drift schema and migrations synchronized

## Code Style

- Prefer small, incremental changes
- Reuse existing providers, repositories, DAOs, and patterns
- Do not rewrite working code unnecessarily
- Keep code null-safe and strongly typed

## Delegation Tooling Safety

- Subagents must use only tools explicitly available in the current session/runtime.
- Never assume external MCP namespaces exist.
- Do not call `google:mcp:*` or any undeclared tool namespace unless it is explicitly available in the current environment.
- For file access, prefer the session-native tools for reading/searching/editing; use shell only when the available toolset requires it.
- If a required tool is unavailable, stop and report the constraint instead of improvising with another namespace.
- Do not use implementation agents for documentation-only tasks when inline editing or a documentation/planning/exploration path is sufficient.

## Model Preference

- For code implementation, edits, refactors, and test fixes, prefer `gpt-5.3-codex` when that model is available in the current runtime.
- For planning, architecture, analysis, and user-facing explanations, the primary model may remain in use unless the task is explicitly implementation-heavy.

## Before Finishing

- Run dart format
- Run flutter analyze
- Run tests if affected
- Update SESSION_RESUME.md and PROJECT_SNAPSHOT.md when relevant
- When you discover an unresolved bug, missing capability, or intentionally deferred improvement, record it in the session roadmap/tracker before finishing.
- Create a commit that matches the completed task or grouped tasks with an intentional message.
- Push the branch after the commit when the work is ready to publish.
