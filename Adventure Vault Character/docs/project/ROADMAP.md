# Adventure Vault Character - Roadmap

## Last Updated

2026-04-02

## Roadmap Intent

This roadmap is now focused on **finishing the playable character sheet and
missing core 5e player rules** on top of the existing offline-first,
normalized architecture.

The app already has a strong baseline: guided create/edit, normalized
persistence, compendium import management, deterministic spell foundations, and
inventory mutations. The remaining work is primarily about turning those
foundations into a complete in-session player tool.

## Current Reality (from implementation audit)

- Normalized data already exists for skills, proficiencies/languages, portrait,
  currency detail, spell selections/slots, class resources, and inventory.
- Character sheet has meaningful content but still has high-value usability
  gaps.
- Core combat automation is intentionally partial (no AC/initiative/attacks/
  death saves yet).

## Phase 1 — Character Sheet Completion (Now)

Goal: Make the sheet the reliable in-session home screen using already
available data and deterministic derivations.

### Scope

- Improve identity header clarity (including optional portrait display).
- Surface passive perception from existing character data.
- Improve visibility of skills and proficiencies/languages.
- Keep all logic in domain/application outputs; avoid widget-side rule logic.
- Do not add speculative combat systems in this phase.

### Exit Criteria

- Sheet exposes key information players look up constantly without opening
  edit/create screens.
- UI improvements are presentation-first and do not require schema changes.
- Behavior is covered by focused tests.

## Phase 2 — Core Combat Rules (Deterministic MVP)

Goal: Fill missing essential combat calculations using canonical state.

### Scope

- Armor Class derivation (base armor + shield + Dex rules).
- Initiative derivation.
- Attack and damage roll helpers from equipped weapons and ability mapping.
- Death saves and stable tracking state.

### Exit Criteria

- Combat panel no longer depends on placeholders for core table play.
- Rules are deterministic, testable, and persistence-agnostic.

## Phase 3 — Spellcasting Workflow Completion

Goal: Move from spell foundation to full day-to-day spell use flow.

### Scope

- Better prepared/known/spellbook interaction UX.
- Slot expenditure and recovery visibility integrated in sheet workflows.
- Class-specific edge handling for known/prepared constraints.

### Exit Criteria

- Spellcasters can run common session actions without leaving the app context.

## Phase 4 — Inventory & Resource Session UX

Goal: Expose existing inventory/resource mutation capabilities clearly in the
sheet.

### Scope

- Better in-sheet interaction affordances for stack/container operations.
- Resource tracking consistency across rests and manual adjustments.
- Item-state clarity (equipped/carried/container/charges) in compact layouts.

### Exit Criteria

- Inventory/resource operations are usable and understandable during live play.

## Phase 5 — Rules Coverage & Validation Hardening

Goal: Raise confidence that deterministic rules stay correct as scope expands.

### Scope

- Expand rule-level tests for combat, skills, spell edge cases, and rest flows.
- Add regression coverage for mixed compendium/base/imported content scenarios.
- Strengthen migration and repository parity tests for new rule slices.

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

Continue Phase 1 with minimal, justified sheet improvements only where data is
already available, then move directly to deterministic AC/initiative/attack
foundations in Phase 2.
