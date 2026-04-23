# Post-MVP P1 Execution Tracker

## Purpose

This document tracks the **Post-MVP P1** work: the first wave of UI/UX improvements
that follow the MinFunc release. These are **non-blocking enhancements** that
improve discoverability, workflow speed, and usability for table use.

Unlike MinFunc (which was the minimal offline player release), this tracker
covers **post-launch quality-of-life improvements** that are still P1 priority
for a usable product.

## Release Bar Rule

A task belongs to **Post-MVP P1** only if it:

1. Addresses a discovered usability gap that impedes fast table use.
2. Improves discoverability of already-functional features.
3. Reduces friction in core workflows without adding new complexity.

If a task is purely cosmetic, adds advanced features, or improves edge cases
beyond the minimum table loop, it should remain in P2/P3 or future features.

## P1 Priority Definition

| Category | Definition |
|----------|------------|
| **UI/UX debt** | Missing dialogs/screens for already-functional backend features |
| **Future functional depth** | Expanding rules/content beyond the baseline |
| **Non-critical hardening** | Test coverage for future expansions |
| **Future features** | Nice-to-have capabilities outside current scope |

This tracker focuses on **UI/UX debt** items marked as P1.

## P1 Tasks Summary

### Inventory P1 (Discoverability)

| Task | Description | Backend Status | UI Status |
|------|-------------|----------------|-----------|
| Add merge stack dialog | Dialog to merge inventory stacks | ✅ Complete | ✅ Complete |
| Add transfer to container dialog | Dialog to transfer items between containers | ✅ Complete | ❌ Missing |
| Add container management dialog | Dialog to add/remove containers | ✅ Complete | ❌ Missing |

### Spell P1 (Workflow Speed)

| Task | Description | Backend Status | UI Status |
|------|-------------|----------------|-----------|
| Add spellbook management screen | Screen to add/remove spells from wizard spellbook | ✅ Complete | ✅ Complete |
| Add prepared spell selection screen | Screen to select/deselect prepared spells (bard, cleric, druid, paladin) | ✅ Complete | ❌ Missing |

## P1 Open Ambiguities

- **Merge threshold**: What's the minimum quantity to trigger merge suggestion?
- **Container types**: Which container types should be available by default?
- **Spellbook limits**: Are there level-based limits on spellbook capacity?
- **Preparation timing**: When can clerics prepare spells (morning before adventuring?)

## Session Tracker

| ID | Session | Objective | Dependencies | Status | Notes |
| --- | --- | --- | --- | --- | --- |
| P1-00 | Define P1 scope | Convert Post-MVP backlog into binary checklist. | MinFunc complete | Done | Frozen as pass/fail criteria; only UI/UX debt P1 items included. |
| P1-01 | Audit inventory backend | Verify inventory service is complete for P1 UI work. | P1-00 | Done | Backend ✅: mergeStacks, transferToContainer, container CRUD all implemented in `CharacterInventoryService`. |
| P1-02 | Add merge stack dialog | Implement merge inventory stacks UI dialog. | P1-01 | Done | Added `MergeStackDialog` following `SplitStackDialog` pattern; uses `CharacterInventoryService.mergeStacks()` and `CharacterInventoryStackRules`. |
| P1-03 | Add transfer to container dialog | Implement transfer items to containers UI dialog. | P1-01 | Planned | Requires `CharacterInventoryService.transferToContainer()` and container selection. |
| P1-04 | Add container management dialog | Implement add/remove containers UI dialog. | P1-01 | Planned | Requires container CRUD operations via `CharacterInventoryService`. |
| P1-05 | Audit spell backend | Verify spellcasting service is complete for P1 UI work. | P1-00 | Done | Backend ✅: spell progression, selection modes, slot tracking all implemented. |
| P1-06 | Add spellbook management screen | Implement wizard spellbook management screen. | P1-05 | Planned | Requires `CharacterSpellRules`, spellbook CRUD, and spell list display. |
| P1-07 | Add prepared spell selection screen | Implement prepared spell selection UI. | P1-05 | Planned | Requires `CharacterSpellRules`, prepared spell toggle, and spell list display. |
| P1-08 | Test P1 UI interactions | Add widget tests for P1 dialogs/screens. | P1-02, P1-03, P1-04, P1-06, P1-07 | Planned | Reuse existing test patterns from MinFunc. |
| P1-09 | Validate P1 flows end-to-end | Confirm P1 items work in character sheet context. | P1-02, P1-03, P1-04, P1-06, P1-07, P1-08 | Planned | Integration tests with `CharacterSheetScreen`. |
| P1-10 | Declare P1 complete | Mark P1 as done, categorize P2/P3 work. | P1-09 | Planned | Move remaining work to P2 backlog. |

## Local-Model Prompts

### Shared Delegation Constraints

Apply these constraints to every delegated Post-MVP session prompt:

- Use only tools explicitly available in the current session/runtime.
- Do not assume external MCP namespaces exist.
- Prefer the session-native tools for reading, searching, and editing files.
- If a required tool is unavailable, stop and report the constraint.
- Do not implement code unless the specific session prompt explicitly asks for implementation.

### P1-00 — Define P1 scope

> Review `docs/project/MINFUNC_TRACKER.md` and the Post-MVP backlog in `docs/project/ROADMAP.md`. Separate UI/UX debt P1 items from P2/P3/future features. Return: (1) P1 checklist, (2) explicit exclusions, (3) open ambiguities.

### P1-01 — Audit inventory backend

> Inspect `lib/src/features/characters/application/character_inventory_service.dart` and related domain rules. Verify all inventory mutations are implemented. Do not modify code. Return: (1) backend summary, (2) what exists, (3) what's missing for P1.

### P1-02 — Add merge stack dialog

> Implement `MergeStackDialog` following the pattern of `SplitStackDialog`. Use `CharacterInventoryService.mergeStacks()` and `CharacterInventoryStackRules` for validation. Return: (1) files created, (2) integration points, (3) test coverage needed.

### P1-03 — Add transfer to container dialog

> Implement `TransferToContainerDialog` for transferring items between containers. Use `CharacterInventoryService.transferToContainer()`. Return: (1) files created, (2) container selection logic, (3) test coverage needed.

### P1-04 — Add container management dialog

> Implement `ContainerManagementDialog` to add/remove containers. Handle container CRUD via `CharacterInventoryService`. Return: (1) files created, (2) container types available, (3) test coverage needed.

### P1-05 — Audit spell backend

> Inspect `lib/src/features/characters/domain/character_spell_rules.dart` and `character_domain_model.dart`. Verify spellcasting backend is complete. Do not modify code. Return: (1) backend summary, (2) what exists, (3) what's missing for P1.

### P1-06 — Add spellbook management screen

> Implement `SpellbookManagementScreen` for wizard spellbook CRUD. Use `CharacterSpellRules` for validation. Return: (1) files created, (2) spellbook navigation, (3) test coverage needed.

### P1-07 — Add prepared spell selection screen

> Implement `PreparedSpellSelectionScreen` for cleric/paladin/druid prepared spell management. Use `CharacterSpellRules` for validation. Return: (1) files created, (2) prepared spell toggle, (3) test coverage needed.

### P1-08 — Test P1 UI interactions

> Add widget tests for all P1 dialogs/screens. Reuse existing test patterns from MinFunc. Return: (1) test files created, (2) covered cases, (3) any failures.

### P1-09 — Validate P1 flows end-to-end

> Test P1 items in the context of `CharacterSheetScreen`. Verify dialogs/screens integrate properly with the sheet. Return: (1) integration test results, (2) any issues found, (3) fixes applied.

### P1-10 — Declare P1 complete

> Mark P1 as complete and move remaining work to P2 backlog. Update canonical docs. Return: (1) P1 completion summary, (2) files touched, (3) next recommended step (P2).

## Progress Update Rules

When completing a session:

1. Update the **Status** column in the Session Tracker.
2. Add a short note describing the outcome or blocker.
3. If the project reality changed, update this tracker in the same session.
4. If you discover an unresolved bug, missing capability, or deferred improvement, add it to this session roadmap before closing.
5. Close the session explicitly: summarize the result, state the single next recommended session ID/instruction, and then stop.

Allowed status values:

- `Planned`
- `In progress`
- `Done`
- `Blocked`
- `N/A`

## Current Recommendation

Post-MVP P1 scope is defined (P1-00 complete). Backend audited (P1-01 complete). MergeStackDialog implemented (P1-02 complete). Next: **P1-03** to implement `TransferToContainerDialog`.

(End of file - total 170 lines)
