# Adventure Vault Character — Project Snapshot

## Last Updated

2026-05-12

## Role of This Document

This file is the consolidated project-state reference.

- Use this document for current implemented scope, roadmap posture, and risks.
- For session handoff and immediate next actions, read
  `docs/project/SESSION_RESUME.md` first.

## Current Phase

Post-foundation implementation, validation hardening, and documentation alignment.

- Character-sheet completion slice: implemented.
- Deterministic combat MVP slice: implemented.
- Current work posture: MinFunc is complete; the canonical docs are aligned; and the validation recovery queue is closed, with only the final commit/push closeout remaining.
- Phase 8 accessibility work is complete and verified.
- P2-02 audit is complete: the character sheet already exposes direct inventory action buttons in `_InventoryItemRow`, and the later dialog slices wired those entry points to live call sites.
- P2-03 is complete: the live sheet now opens `TransferToContainerDialog` from the inventory transfer button; the placeholder container data and submit path are gone.
- P2-04 is complete: the transfer dialog now populates its container list from the current character's container items; the static sample list is gone.
- P2-05a is complete: transfer submit now routes through the real app-controller/repository mutation path, with regression coverage in place.
- P2-05b is complete: the selected character sheet reloads immediately after a successful transfer so the equipment/container panels reflect the new state.
- P2-05c is complete: the transferred stack remains visible after reopening the character, with controller and repository-backed assertions in place.
- P2-06 is complete: the transfer dialog widget tests now cover opening the dialog, validation, container selection, and successful submit behavior.
- P2-07 is complete: The character sheet now exposes a live manage-containers button that opens `ContainerManagementDialog`; widget coverage verifies the entry point.
- P2-08a is complete: The management dialog now reads container items from the live character sheet instead of a hard-coded sample list.
- P2-12b is complete: The roadmap, snapshot, resume, and tracker now agree that the current player-app scope is closed.

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
- Phase 5 validation hardening now includes a regression for merging imported
  XML content into a fallback JSON base catalog.
- Phase 5 now also includes a regression for multiple imported XML packs staying
  independently active while keeping merged source notes deterministic.
- Phase 5 now also includes codec regression coverage for spell-slot usage
  serialization edge cases.
- Phase 5 mixed-source coverage now also includes fallback JSON base catalog note
  assertions and reload parity checks for multiple imported packs.
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
- S11 is complete: targeted widget coverage now proves restore persistence after
  navigating back and reopening the same character.
- S12 confirmed inventory minimum usability is already sufficient for MinFunc;
  S14 confirmed the existing inventory regression/smoke coverage is enough for
  the minimum flow.
- S15 is complete: the character sheet now uses stable fallbacks for blank
  identity, background, finishing-details, and equipment summary fields.
- S16 is complete: controller-level handling now surfaces expected mutation
  rejections and recoverable errors for spells, inventory, and class resources.
- S18 is complete: the full minimum loop audit passed, including creation,
  save/reopen, spell slots, inventory, rests/resources, and offline continuation.
- S19 is complete: post-MVP debt has been separated into UI/UX debt, future
  functional depth, non-critical hardening, and future features.
- S20 is complete: canonical docs now reflect the finished MinFunc status and
  the post-MVP focus split.
- P8-02-1 is complete: the sheet header and identity area now expose semantics
  labels.
- P8-02-2b is complete: combat and recovery controls now expose semantics
  labels, and the remaining Phase 8 accessibility work continues with the
  spells/inventory slice.
- S23 is complete: the mixed-source precedence audit confirmed the existing
  regression coverage for XML-base and fallback-base merges, while leaving a
  small gap for fallback JSON base plus multiple imported packs and explicit
  source-policy note assertions around mixed-source collisions.
- No further scope-closure slice remains; future work should be filed as backlog.
- Verification status: `flutter analyze` passes after the inventory container-creation and repository async fixes; `flutter test` passes for the inventory/container regressions exercised in this closeout.

## Drift Status

- Current schema version is **`v21`**.

- Character-side normalized tables include abilities, provenance, hit points,
  finishing details, narrative selections, equipment loadout, saves, skills,
  proficiencies, inventory, currency, and death saves.
- Compendium-side tables include definitions and pack-state metadata used by
  current offline catalog behavior.
- Migration coverage is documented as active for legacy-to-current upgrades;
  references to `v19` in project-state docs are obsolete and replaced by `v21`.

## Progress by Roadmap Area

- **Phase 1 — Character Sheet Completion:** complete.
- **Phase 2 — Core Combat Rules (Deterministic MVP):** complete.
- **Phase 3 — Spellcasting Workflow Completion:** complete.
- **Phase 4 — Inventory & Resource Session UX:** complete.
- **Phase 5 — Rules Coverage & Validation Hardening:** in progress.
- **Phase 6 — Finish-the-App Polish & Recovery:** complete.
- **Phase 7 — Post-MVP Polish & Feature Expansion:** complete.
- Phase 8 — Advanced Features & Accessibility: complete.

## Active Delivery Focus

1. Keep the canonical project docs aligned with the finished MinFunc state and completed Phase 8 slices.
2. Keep future work in backlog form and separate from the finished player-app scope.
3. Keep broader UX depth, non-blocking edge-case breadth, and post-Phase-8 polish outside the minimum-functional release scope unless they prove to be blockers.

### Canonical Active P2 Task Names

1. `P2-12b — Declare current player-app scope complete` (complete)

## Risks and Follow-Ups

- Inventory/spell UX can become inconsistent if new UI actions bypass
  domain/application contracts.
- Imported-content conflict diagnostics may need richer visibility if more
  sections become pack-sensitive.
- The current live worktree has a small recovery closeout: the code fixes and validation are green, and the remaining work is the final commit/push before the repo is fully wrapped up.
- **P2-10a complete:** Inventory actions are grouped in a dedicated section above the equipment item list, while stack actions stay on the item rows.
- Future accessibility work, if any, should be treated as a new backlog item
  rather than a continuation of the completed Phase 8 slices.

## Primary References

- Session handoff: `docs/project/SESSION_RESUME.md`
- MinFunc tracker: `docs/project/MINFUNC_TRACKER.md`
- Roadmap: `docs/project/ROADMAP.md`
- Project rules: `docs/project/PROJECT_GUIDELINES.md`
- Architecture index: `docs/architecture/README.md`
- Diagrams index: `docs/diagrams/README.md`
- Specs index: `docs/specs/README.md`
