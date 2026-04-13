# Session Resume

Last updated: 2026-04-12

This is the canonical, short handoff file for resuming work quickly.

## Resume Protocol

1. Read this file first.
2. Execute only the next actionable slice listed below.
3. Use linked docs for deeper context only when needed.
4. After meaningful changes, update this file and then update
   `PROJECT_SNAPSHOT.md` if project-state facts changed.
5. After each session, close the work, give the next single recommended
   instruction, and then wait for a new session before continuing.
6. If you find an unresolved bug, missing capability, or intentionally deferred
   improvement, record it in the session roadmap/tracker before closing.

## Current State at a Glance

- Project: Adventure Vault Character (player app).
- Stack: Flutter + Dart, offline-first, Drift/SQLite local persistence.
- Architecture: feature-first with layered separation
  (`presentation -> application -> domain -> data`).
- Drift schema: **`v20`** (canonical current version).
- Current phase: MinFunc gap-closure after code audit.
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
- Runtime asset bundling currently relies on `assets/compendium/catalog.json`; missing local XML trees no longer block Flutter test startup.

## Next Actionable Slice

Prioritize the **MinFunc** execution path before broader hardening work:

1. Spell-slot mapping is complete through `S5`: read path, existing mutation
   path, and the minimum missing gap are now verified.
2. Execute one atomic implementation session at a time starting with the split
   spend path: contract (`S6A`, done), Drift persistence (`S6B`, done), then
   the in-memory parity sub-slice: behavior (`S6C1`, done), parity tests (`S6C2`, done),
   and closeout (`S6C3`, done), followed by spend UI (`S7`, done), spend test (`S8`, done), restore
   contract (`S9A`, done), restore behavior (`S9B`, done), restore closeout (`S9C`, done),
   restore UI (`S10`, done), and restore test (`S11`, done).
3. Treat inventory as already sufficient for MinFunc unless a later regression
   proves otherwise; keep all later sessions equally atomic.

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
- S3-S5 are complete: the sheet read path, mutation/persistence path, and
  minimum spell-slot gap are now frozen.
- S6A-S6C3 are complete: spend-slot mutation now exists end-to-end in the
  repository/application non-UI path with Drift + in-memory parity and minimum
  non-widget coverage.
- S7 is complete: the sheet now exposes minimal `Spend 1` slot actions and
  routes them through the existing controller/repository path without widget-side
  rules logic.
- S8 is complete: targeted widget coverage now proves spend remains persisted
  after navigating back and reopening the same character.
- S9A-S9C are complete: restore-slot contract, non-UI behavior, and tracker
  closeout now match the spend-path parity baseline.
- S10 is complete: the sheet now exposes minimal `Restore 1` slot actions next
  to `Spend 1`, so spend + restore form the minimum in-sheet slot loop.
- S11 is complete: targeted widget coverage now proves restore returns the slot
  state to zero, persists immediately, and remains correct after navigating
  back and reopening the same character.
- The next step is S12: audit whether inventory already satisfies the minimum
  offline table-session bar without adding non-blocking UX depth.
