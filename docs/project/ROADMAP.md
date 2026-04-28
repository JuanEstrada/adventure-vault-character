# Adventure Vault Character - Roadmap

## Last Updated

2026-04-28

## Roadmap Intent

This roadmap focuses on **closing the remaining in-session player gaps** on top
of the current offline-first, normalized architecture.

The implementation has moved past the old "sheet foundation" state: core sheet
visibility and deterministic combat MVP rules are already live. The roadmap now
tracks what is complete versus what still needs delivery hardening.

## Current Reality (implementation audit — 2026-04-03)

- Normalized persistence is in place for character state, spell state, class
  resources, inventory/container state, and death saves.
- Character sheet already shows passive perception, combat core values (AC,
  initiative), death saves, attack helpers, class resources, spells summary,
  and actionable inventory mutations.
- Compendium import and pack activation are implemented with persisted optional
  pack state, section-level source policy metadata, and XML import validation.
- Major remaining work is no longer "foundations"; it is completion polish for
  spellcasting/inventory workflows, broader rule coverage, and quality/recovery
  hardening.

## Phase Status Snapshot

| Phase | Status | Notes |
|---|---|---|
| Phase 1 — Character Sheet Completion | ✅ Complete | Header, portrait, passive perception, skills, and proficiency/language readability are implemented in the sheet domain+UI path. |
| Phase 2 — Core Combat Rules (Deterministic MVP) | ✅ Complete | AC, initiative, death-save state/mutations, and equipped-weapon attack helpers are implemented and surfaced on sheet. |
| Phase 3 — Spellcasting Workflow Completion | ✅ Complete | Class-specific selection modes, persisted spells/slots, slot recovery, and per-slot spend/restore controls are all implemented and functional. |
| Phase 4 — Inventory & Resource Session UX | ✅ Complete | Core mutations (equip/carry/quantity/charges/container/stack operations) and rest/resource actions are implemented. Split/merge/transfer dialogs integrated with explicit controls for stack operations. |
| Phase 5 — Rules Coverage & Validation Hardening | 🟡 In progress | Combat/spell/inventory/migration tests exist; broader edge/path parity and deeper mixed-source regressions remain. |
| Phase 6 — Finish-the-App Polish & Recovery | ⚪ Not started | Partial improvements exist, but no full missing-data/error-recovery polish pass yet. |

## Outdated Roadmap Assumptions (now implemented)

- "No AC/initiative/attacks/death saves yet" is obsolete; all are implemented.
- Phase 1 wording that implied only early sheet visibility work remained is
  obsolete; those scope items are complete.
- Immediate-next guidance to "continue Phase 1, then start Phase 2" is obsolete;
  the project is already beyond both phases.
- Phase 4 "transfer UX depth and compact clarity still need improvement" is obsolete;
  split/merge/transfer dialogs are now fully integrated with explicit controls.

## Phase 1 — Character Sheet Completion

Goal: Make the sheet the reliable in-session home screen using already
available data and deterministic derivations.

### Scope

- Improve identity header clarity (including optional portrait display).
- Surface passive perception from existing character data.
- Improve visibility of skills and proficiencies/languages.
- Keep all logic in domain/application outputs; avoid widget-side rule logic.
- Do not add speculative combat systems in this phase.

### Exit Criteria

- ✅ Achieved.

## Phase 2 — Core Combat Rules (Deterministic MVP)

Goal: Fill missing essential combat calculations using canonical state.

### Scope

- Armor Class derivation (base armor + shield + Dex rules).
- Initiative derivation.
- Attack and damage roll helpers from equipped weapons and ability mapping.
- Death saves and stable tracking state.

### Exit Criteria

- ✅ Achieved for MVP scope.

## Phase 3 — Spellcasting Workflow Completion

Goal: Move from spell foundation to full day-to-day spell use flow.

### Scope

- Better prepared/known/spellbook interaction UX.
- Slot expenditure and recovery visibility integrated in sheet workflows.
- Class-specific edge handling for known/prepared constraints.

### Current Progress

- ✅ Class-specific selection modes and limits are implemented, including
  wizard spellbook/prepared subset handling and warlock pact magic.
- ✅ Selected spells and slot usage persist and survive create/edit/reopen.
- ✅ Slot recovery rules are integrated with short/long rest handling.
- ✅ Spells panel now surfaces explicit slot-usage progress and in-panel
  short/long rest recovery actions, reducing context switches during session
  tracking.
- ✅ The sheet now exposes direct minimal spend controls for spell slots through
  the existing mutation path.
- ✅ Targeted spend coverage now proves the spent slot state persists across
  back-navigation and character reopen.
- ✅ Direct per-slot spend/restore controls implemented in sheet UI with
   individual slot buttons.
- ✅ Restore-slot symmetry and full spend/restore loop completed.
- 🟡 Remaining: broader spell edge case coverage and mixed-source regression
   tests.

### Exit Criteria

- Spellcasters can run common session actions without leaving the app context.

## Phase 4 — Inventory & Resource Session UX

Goal: Expose existing inventory/resource mutation capabilities clearly in the
sheet.

### Scope

- Better in-sheet interaction affordances for stack/container operations.
- Resource tracking consistency across rests and manual adjustments.
- Item-state clarity (equipped/carried/container/charges) in compact layouts.

### Current Progress

- ✅ Deterministic inventory/resource mutation contracts are implemented and
  persisted, including quantity spend, charge spend/restore, container
  assignment, and stack lifecycle operations.
- ✅ Rest/resource mutations are service-driven and shown in sheet workflows.
- ✅ Inventory mutation rejection is now surfaced directly in the sheet
  equipment panel with explicit no-state-change messaging.
- ✅ Equipment rows now expose stack/container state more explicitly,
  including stack-size labels and container content summaries.
- 🟡 Remaining: richer explicit transfer controls (split/merge/transfer actions)
  are still pending beyond the current inline mutation controls.

### Exit Criteria

- Inventory/resource operations are usable and understandable during live play.

## Phase 5 — Rules Coverage & Validation Hardening

Goal: Raise confidence that deterministic rules stay correct as scope expands.

### Scope

- Expand rule-level tests for combat, skills, spell edge cases, and rest flows.
- Add regression coverage for mixed compendium/base/imported content scenarios.
- Strengthen migration and repository parity tests for new rule slices.

### Current Progress

- ✅ Dedicated rule tests exist for combat, spells, rest rules, encumbrance,
  class resources, and inventory stack rules.
- ✅ Migration and repository tests cover normalized schema evolution and
  behavior parity across in-memory and Drift paths for key flows.
- ✅ Transfer compatibility coverage now includes mixed same-item target-stack
  state rejection parity in both in-memory and Drift repository paths.
- 🟡 Remaining: additional advanced spell edge cases and broader mixed
  compendium regression breadth.

### Exit Criteria

- High-risk rule paths are protected by automated tests.

## Phase 6 — Finish-the-App Polish & Recovery

Goal: Close quality gaps before broader feature expansion.

### Scope

- Better missing-data and partial-state UX in character sheet.
- Error/recovery pass for read/write interruptions.
- Documentation and architecture alignment cleanup.

### Exit Criteria

- App is coherent for regular offline table use and resilient to edge states.

## Not In Current Roadmap Scope

- Network sync and account systems.
- DM tooling (separate product boundary remains in effect).
- Large net-new screens that bypass finishing the sheet-first strategy.

## Immediate Next Slice

Prioritize **Phase 3 + Phase 4 completion quality** by delivering one cohesive
"in-session action loop" slice:

1. ✅ Strengthened same-item transfer compatibility validation/coverage for
   container/stack states.
2. ✅ Exposed clearer in-sheet feedback for rejected inventory mutations and
   current stack/container state.
3. 🟡 Improved spell/resource session visibility by adding in-panel recovery
   actions and slot progress; direct per-slot mutation controls remain.
