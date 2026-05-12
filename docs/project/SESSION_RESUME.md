# Session Resume

Last updated: 2026-05-12

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
- Drift schema: **`v21`** (canonical current version).
- Current phase: MinFunc is complete, the validation recovery queue is green, and the remaining closeout is the final commit/push closeout.
- Active planning focus: the tracked P2 completion chain in `docs/project/POST_MVP_P1_TRACKER.md` is fully closed at `P2-12b — Declare current player-app scope complete`; the remaining follow-up is the final recovery closeout at `VR-03d — Commit and push the recovery closeout`.
- Phase 8 accessibility work remains complete and verified: P8-02-1 (panel headers and identity semantics), P8-02-2b (combat and recovery control semantics), P8-02-4 (sheet-level focus traversal), P8-04 (focus states), P8-05 (advanced inventory stack management), P8-06 (spell slot bulk operations), P8-07 (spell selection mode enhancements), P8-08 (advanced combat automation helpers), P8-09 (compendium search/filtering), and P8-10 (session persistence / auto-save).
- **P2-01 complete:** Canonical docs are aligned with the current player-app scope.
- **P2-02 complete:** The inventory sheet already exposes direct action buttons in `_InventoryItemRow`; later dialog slices wired the live transfer/manage entry points.
- **P2-03 complete:** The live sheet now opens `TransferToContainerDialog` from the inventory transfer button; the placeholder container data and submit path are gone.
- **P2-04 complete:** The transfer dialog now populates its container list from the current character's container items; the static sample list is gone.
- **P2-05a complete:** Transfer submit now routes through the real app-controller/repository mutation path, with controller and widget regression coverage in place.
- **P2-10a complete:** Inventory actions are grouped in a dedicated section above the equipment item list, while stack actions stay on the item rows.
- **P2-12b is complete:** The roadmap, snapshot, resume, and tracker now agree that the current player-app scope is closed.
- Verification status: `flutter analyze` and `flutter test` passed in VR-03a; this handoff now reflects the reconciled state.

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

Phase 8 accessibility work is complete and verified. **P2-12b** (scope closure) is complete.

**Next:** `VR-03d — Commit and push the recovery closeout`.

### Validation Recovery Closeout

1. `VR-01 — Fix spell-slot overspend validation parity`
2. `VR-02 — Stabilize container-management dialog interactions`
3. `VR-03 — Re-run validation and reconcile docs`

**Context:** spell-slot overspend rejection is now aligned across Drift and in-memory repositories; `test/drift_character_repository_test.dart` and `test/in_memory_character_repository_test.dart` both validate the same overspend guard, and VR-01c/VR-01d are complete.

**Validation watchlist:** keep the closeout narrow; do not reopen closed P2 inventory scope unless a fix exposes a broader regression.

**Status:** the compendium search/filter domain service, quick-access results panel, session persistence wiring, and targeted tests remain in place; the open work is limited to the final commit/push closeout above.

### Canonical Active P2 Task Names

1. `P2-12b — Declare current player-app scope complete` (complete)

**Context:** P8-09 (advanced compendium search and filtering) and P8-10 (session persistence / auto-save) are complete, and the sheet-level keyboard focus traversal regression is green.

**Validation watchlist:** the only known open failures are the recovery queue above; only open a new implementation slice if a fresh regression or backlog priority appears.

**Status:** the compendium search/filter domain service, quick-access results panel, session persistence wiring, and targeted tests are in place.

### Current Progression

**P6-03 through P6-05 are complete and verified.** Phase 6 recovery flow now includes:

- Spell-slot restoration persistence verified.
- Inventory and spell-slot restore persisted after navigation.
- S14-S20 slices complete covering minimum loop audit and post-MVP debt separation.

**Phase 7 is complete and verified.** The sheet now includes inventory split / merge / transfer wiring, a usable interrupted-mutation recovery dialog, and targeted regression coverage.

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
- Phase 5 mixed-source coverage now includes fallback JSON base + multiple
  imported packs with catalog source-policy note assertions.
- S14 is complete: the existing inventory regression/smoke coverage already
  proves the minimum inventory flow needed by MinFunc.
- S18 is complete: the full minimum loop audit passed, including creation,
  save/reopen, spell slots, inventory, rests/resources, and offline continuation.
- S19 is complete: post-MVP debt has been separated into UI/UX debt, future
  functional depth, non-critical hardening, and future features.
- S20 is complete: canonical docs now reflect the finished MinFunc status and
  the next post-MVP focus split.
- P8-02-1 is complete: the character sheet now exposes semantics labels for
  the sheet chrome and identity area.
- P8-02-2b is complete: combat and recovery controls now expose semantics labels; P8-02-2c is the next pending slice for spells and inventory controls before moving to the next accessibility sub-slice.
- S23 is complete: the mixed-source precedence audit confirms the current test
  suite already covers the main XML-base and fallback-base merge paths.
- S24 is complete: fallback JSON base now has regression coverage for multiple
  imported packs and the catalog source-policy note assertions that close the
  remaining mixed-source collision gap.
- S25/S26 are complete: parity is verified and the Phase 5 hardening slice is
  closed.
