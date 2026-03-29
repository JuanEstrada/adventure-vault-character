# AI Session Runbook

Use this runbook as the single operational guide for AI-assisted sessions.

## Instruction Precedence

When instructions overlap, apply them in this order:

1. `AGENTS.md` (repository-wide operating constraints)
2. `docs/project/PROJECT_GUIDELINES.md` (product and technical decision rules)
3. `docs/project/AI_SESSION_GUIDE.md` (session execution runbook)
4. `docs/project/playbooks/AI_MODEL_PLAYBOOK.md` (model-routing strategy)

## Start Here

1. Read [SESSION_RESUME.md](SESSION_RESUME.md).
2. Read [PROJECT_SNAPSHOT.md](PROJECT_SNAPSHOT.md).
3. Read [PROJECT_GUIDELINES.md](PROJECT_GUIDELINES.md).
4. Open only the linked documents needed for the area you will modify.

## Open By Work Area

- Product phase and next steps: `docs/project/ROADMAP.md`
- Specs index: `docs/specs/README.md`
- MVP flow: `docs/specs/mvp-scope.md`
- Navigation flow: `docs/specs/initial-navigation-flow.md`
- Character creation: `docs/specs/create-character-screen.md`
- Character sheet: `docs/specs/character-sheet-screen.md`
- Initial domain model: `docs/specs/initial-character-domain-model.md`

## If You Will Edit Code

- App entry: `lib/main.dart`
- App shell: `lib/src/app/adventure_vault_app.dart`
- App controller: `lib/src/app/app_controller.dart`
- Baseline widget test: `test/widget_test.dart`

## Working Rules

- Do not duplicate documentation when a source-of-truth document already covers
  the topic.
- Treat accepted ADRs as active constraints.
- Keep architecture docs aligned with implementation planning.
- Keep project-state docs aligned with repository reality.
- Prefer updating index pages when adding new documents.
- Record accepted product requirements in `docs/specs/`.

## Continuity Rule

`SESSION_RESUME.md` is the single-file session restart document.

If any deeper source document and `SESSION_RESUME.md` disagree, verify the
repository state and then bring both back into alignment in the same session.
