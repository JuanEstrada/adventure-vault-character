# Adventure Vault Character — Project Snapshot

## Last Updated
2026-04-04

## Role of This Document

This file is the consolidated project-state reference.

- Use this document for current implemented scope, roadmap posture, and risks.
- For session handoff and immediate next actions, read
  `docs/project/SESSION_RESUME.md` first.

## Current Phase

Post-foundation implementation and hardening.

- Character-sheet completion slice: implemented.
- Deterministic combat MVP slice: implemented.
- Current work posture: workflow depth, UX clarity for mutations, and regression
  hardening.

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
- Character sheet renders deterministic derived state for key gameplay areas,
  including combat helpers, spell-state summaries, rest effects, and inventory
  mutation feedback.

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

1. Keep deterministic inventory and spell behavior stable while expanding
   in-session UX clarity.
2. Expand high-value regression coverage for mixed-source and edge-case paths.
3. Improve recovery and missing-data resilience in sheet-driven play sessions.

## Risks and Follow-Ups

- Inventory/spell UX can become inconsistent if new UI actions bypass
  domain/application contracts.
- Imported-content conflict diagnostics may need richer visibility if more
  sections become pack-sensitive.
- Remaining polish work (recovery and interruption handling) is still required
  before declaring finish-the-app quality.

## Primary References

- Session handoff: `docs/project/SESSION_RESUME.md`
- Roadmap: `docs/project/ROADMAP.md`
- Project rules: `docs/project/PROJECT_GUIDELINES.md`
- Architecture index: `docs/architecture/README.md`
- Diagrams index: `docs/diagrams/README.md`
- Specs index: `docs/specs/README.md`
