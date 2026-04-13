# Adventure Vault Character — Project Snapshot

## Last Updated
2026-04-12

## Role of This Document

This file is the consolidated project-state reference.

- Use this document for current implemented scope, roadmap posture, and risks.
- For session handoff and immediate next actions, read
  `docs/project/SESSION_RESUME.md` first.

## Current Phase

Post-foundation implementation and hardening.

- Character-sheet completion slice: implemented.
- Deterministic combat MVP slice: implemented.
- Current work posture: MinFunc gap closure has moved past direct spell-slot
  actions and is now focused on targeted regression hardening plus minimum
  sheet resilience work.

## Architecture Baseline (Current)

- Flutter, feature-first structure under `lib/src/features/*`.
- Layered separation by feature:
  - `presentation`: widgets, route views, and controllers.
  - `application`: use-case orchestration and service coordination.
  - `domain`: rules, invariants, and read/write domain models.
  - `data`: Drift DAOs/repositories, compendium ingestion, local persistence.
- Offline-first behavior remains the default operating mode.
- Drift over SQLite remains the local persistence baseline.
- Player app and DM app remain separate products.

Primary constraints are tracked in:

- `docs/project/PROJECT_GUIDELINES.md`
- `docs/adr/ADR-002-offline-first-architecture.md`
- `docs/adr/ADR-004-separate-player-and-dm-apps.md`
- `docs/adr/ADR-006-use-flutter-for-client-application.md`
- `docs/adr/ADR-007-use-drift-for-local-persistence.md`

## Repository State (Consolidated)

- Flutter targets are present for Android, iOS, web, Linux, Windows, and macOS.
- Startup flow `bootstrap -> access -> main menu` is implemented.
- Character workflow `create -> save -> card -> open sheet -> edit -> save` is
  implemented on top of normalized persistence.
- Compendium flow includes local source policy visibility, imported-pack
  registration, pack activation state, and effective-catalog filtering.
- The bundled runtime asset set is currently reduced to `assets/compendium/catalog.json`; missing local XML source trees now fall through to the repository's existing fallback behavior instead of blocking asset-bundle builds.
- Character sheet renders deterministic derived state for key gameplay areas,
  including combat helpers, spell-state summaries, rest effects, and inventory
  mutation feedback.
- S2 MinFunc audit confirmed inventory minimum usability is already implemented.
- S3-S5 confirmed the spell-slot read path, persistence path, and exact minimum
  gap.
- S6A-S6C3 closed the non-UI spend-slot slice: explicit repository/application
  spend mutation now exists with Drift + in-memory parity and minimum non-widget
  coverage.
- S9A-S9C closed the non-UI restore-slot slice: restore now mirrors spend-path
  validation and persistence semantics before UI.
- S10 exposed the restore action in the sheet, so the minimum in-session
  spell-slot loop now supports both `Spend 1` and `Restore 1`.
- S11 closed the remaining spell-slot proof point with widget coverage for
  restore action, persistence, and reopen.
- S12 confirmed inventory is already sufficient for the MinFunc offline player
  loop: the sheet exposes quantity, consumable usage, carry/equip, charge
  tracking, and container assignment on top of deterministic repository
  validation.
- S14 added minimum widget smoke/regression coverage for the inventory path,
  proving the sheet can persist equip/carry toggles and container assignment in
  a real in-session flow.
- S15 hardened minimum partial-state sheet rendering with simple Equipment-panel
  fallbacks for missing loadout/summary/item data.

## Drift Status

- Current schema version is **`v20`**.
- Character-side normalized tables include abilities, provenance, hit points,
  finishing details, narrative selections, equipment loadout, saves, skills,
  proficiencies, inventory, currency, and death saves.
- Compendium-side tables include definitions and pack-state metadata used by
  current offline catalog behavior.
- Migration coverage is documented as active for legacy-to-current upgrades;
  references to `v19` in project-state docs are obsolete and replaced by `v20`.

## Progress by Roadmap Area

- **Phase 1 — Character Sheet Completion:** complete.
- **Phase 2 — Core Combat Rules (Deterministic MVP):** complete.
- **Phase 3 — Spellcasting Workflow Completion:** partially complete
  (foundation implemented; in-session ergonomics still expandable).
- **Phase 4 — Inventory & Resource Session UX:** partially complete
  (deterministic mutation model implemented; UX depth still expandable).
- **Phase 5 — Rules Coverage & Validation Hardening:** partially complete.
- **Phase 6 — Finish-the-App Polish & Recovery:** mostly pending.

## Active Delivery Focus

1. Close the **MinFunc** release bar so a real offline player session can be
   completed without functional blockers.
2. Surface minimum expected mutation rejections next (`S16`) so the sheet flow
   remains visible and operable when actions are rejected.
3. Keep broader UX depth, non-blocking edge-case breadth, and polish outside
   the minimum-functional release scope unless they prove to be blockers.

## Risks and Follow-Ups

- Inventory/spell UX can become inconsistent if new UI actions bypass
  domain/application contracts.
- Imported-content conflict diagnostics may need richer visibility if more
  sections become pack-sensitive.
- Remaining polish work (recovery and interruption handling) is still required
  before declaring finish-the-app quality.

## Primary References

- Session handoff: `docs/project/SESSION_RESUME.md`
- MinFunc tracker: `docs/project/MINFUNC_TRACKER.md`
- Roadmap: `docs/project/ROADMAP.md`
- Project rules: `docs/project/PROJECT_GUIDELINES.md`
- Architecture index: `docs/architecture/README.md`
- Diagrams index: `docs/diagrams/README.md`
- Specs index: `docs/specs/README.md`
