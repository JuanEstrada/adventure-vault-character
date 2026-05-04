# Session Resume

Last updated: 2026-05-03

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
- Current phase: MinFunc complete; canonical doc alignment and validation
  hardening.
- Active planning focus: post-MinFunc validation hardening in
  `docs/project/ROADMAP.md`, with continuity docs kept in sync.

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

Prioritize **Phase 5 validation hardening** before broader polish work:

1. MinFunc is complete; do not reopen frozen minimum-scope work unless a
   regression is confirmed.
2. Start the next implementation slice from Phase 5 validation hardening in
   `docs/project/ROADMAP.md`, focusing on broader rule parity and mixed-source
   regressions.
3. Keep inventory and spell workflows frozen at the verified minimum bar while
   broader post-MVP work continues.

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
- S10 is complete: the sheet now exposes the restore control through the
  existing controller/repository path.
- S11 is complete: targeted widget coverage now proves spell-slot restore
  persists after navigating back and reopening the same character.
- S12 is complete: inventory minimum usability is already sufficient for the
  MinFunc bar; no code changes were needed.
- S15 is complete: the sheet now has stable fallbacks for blank identity,
  background, finishing-details, and equipment summary fields.
- S16 is complete: expected mutation rejections and recoverable errors are now
  visible for spells, inventory, and class resources.
- Phase 5 now has one mixed-source regression guard: fallback JSON base catalogs
  correctly merge imported XML packs.
- Phase 5 now also has a second mixed-source regression guard for multiple
  imported XML packs staying independently active while keeping merged source
  notes deterministic.
- Phase 5 now also has codec regression coverage for spell-slot usage
  serialization edge cases.
- S14 is complete: the existing inventory regression/smoke coverage already
  proves the minimum inventory flow needed by MinFunc.
- S18 is complete: the full minimum loop audit passed, including creation,
  save/reopen, spell slots, inventory, rests/resources, and offline continuation.
- S19 is complete: post-MVP debt has been separated into UI/UX debt, future
  functional depth, non-critical hardening, and future features.
- S20 is complete: canonical docs now reflect the finished MinFunc status and
  the next post-MVP focus split.
