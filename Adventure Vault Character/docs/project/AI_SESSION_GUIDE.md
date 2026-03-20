# AI Session Guide

Use the project session handoff file as the default continuity entry point for
all future AI-assisted sessions.

## Start Here

1. Read [SESSION_RESUME.md](SESSION_RESUME.md).
2. Open linked source documents only for the area you will modify.
3. Update `SESSION_RESUME.md` at the end of the session if the project state,
   decisions, or implementation status changed.

## Working Rules

- Do not duplicate documentation when an existing source-of-truth document
  already covers the topic.
- Treat accepted ADRs as active constraints.
- Keep architecture docs aligned with implementation planning.
- Keep project-state docs aligned with the actual repository contents.
- Prefer updating index pages when adding new documents.
- Record new product requirements in `docs/specs/` when they are accepted for
  implementation planning.

## Continuity Rule

`SESSION_RESUME.md` is the single-file session restart document.

If any deeper source document and `SESSION_RESUME.md` disagree, verify the
repository state and then bring both back into alignment in the same session.
