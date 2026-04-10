# Session Resume

Last updated: 2026-04-09

This is the canonical, short handoff file for resuming work quickly.

## Resume Protocol

1. Read this file first.
2. Execute only the next actionable slice listed below.
3. Use linked docs for deeper context only when needed.
4. After meaningful changes, update this file and then update
   `PROJECT_SNAPSHOT.md` if project-state facts changed.

## Current State at a Glance

- Project: Adventure Vault Character (player app).
- Stack: Flutter + Dart, offline-first, Drift/SQLite local persistence.
- Architecture: feature-first with layered separation
  (`presentation -> application -> domain -> data`).
- Drift schema: **`v20`** (canonical current version).
- Current phase: post-foundation hardening and workflow depth.
- Active planning focus: `MinFunc` minimal functional release tracking in
  `docs/project/MINFUNC_TRACKER.md`.

## What Is Stable (Do Not Reopen)

- Startup baseline `bootstrap -> access -> main menu`.
- Guided create/save/open/edit character workflow.
- Normalized character persistence and read-side domain rendering.
- Deterministic combat foundations (AC, initiative, attacks, death saves).
- Deterministic inventory mutation contracts and stack/container validation.
- Compendium source-policy visibility, pack persistence, and pack-state
  filtering behavior.

## Next Actionable Slice

Prioritize the **MinFunc** execution path before broader hardening work:

1. Audit real code-level gaps against the frozen release bar (`S2`).
2. Only then implement the smallest blocking slice, expected to be spell-slot
   in-session control if the audit confirms it.

## Guardrails

- Keep rules logic out of widgets.
- Keep persistence and mutation semantics inside repository/service/domain layers.
- Do not introduce new source-of-truth duplication in docs.
- Keep all docs and user-facing copy in English.

## Where to Read Next (Only If Needed)

- Consolidated project state: `docs/project/PROJECT_SNAPSHOT.md`
- Roadmap priorities: `docs/project/ROADMAP.md`
- MinFunc execution tracker: `docs/project/MINFUNC_TRACKER.md`
- Constraints and rules: `docs/project/PROJECT_GUIDELINES.md`
- Architecture baseline: `docs/architecture/README.md`
- Functional specs: `docs/specs/README.md`

## Quick Working Set (Likely Touchpoints)

- Drift schema/migrations:
  `lib/src/features/characters/data/local/app_database.dart`
- Character inventory contracts/services:
  `lib/src/features/characters/application/character_inventory_service.dart`
  `lib/src/features/characters/data/character_repository.dart`
- Character domain and invariants:
  `lib/src/features/characters/domain/character_domain_model.dart`
  `lib/src/features/characters/domain/character_inventory_validation_error.dart`
- Compendium source policy and pack behavior:
  `lib/src/features/compendium/domain/compendium_catalog.dart`
  `lib/src/features/compendium/data/asset_compendium_repository.dart`

## Notes for the Next Session

- Treat this file as the handoff source of truth.
- Keep `PROJECT_SNAPSHOT.md` as the consolidated state reference, not an
  operational checklist duplicate.
