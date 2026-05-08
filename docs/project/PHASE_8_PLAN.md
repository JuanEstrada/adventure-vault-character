# Phase 8: Advanced Features & Accessibility
## Adventure Vault Character - Phase 8 Breakdown

**Last Updated:** 2026-05-06  
**Status:** In progress  
**Dependencies:** Phase 7 complete and verified

---

## Phase 8 Scope

Phase 8 focuses on **accessibility hardening** and **advanced feature depth** that enhance table usability beyond the minimum functional release. This phase targets:

- Screen reader compatibility and keyboard navigation
- Enhanced visual feedback and state clarity
- Advanced inventory management workflows
- Spellcasting workflow enhancements
- Quality assurance for accessibility

---

## Implementation-Ready Backlog (P8-01 Audit Complete)

### P8-02: Add semantics labels to character sheet widgets
**Dependencies:** P8-01 ✅  
**Priority:** CRITICAL  
**Lines:** ~50-100  
**Files:** `lib/src/features/characters/presentation/character_sheet_screen.dart`  
**Description:** Add `Semantics` labels to key widgets in the character sheet (header, combat values, spell slots, inventory rows) to enable screen reader navigation. Follow Flutter accessibility guidelines.

**Progress:** P8-02-1, P8-02-2a, P8-02-2c-a, P8-02-2c-b, P8-02-2c-c, P8-02-2c-d, P8-02-2c-e, P8-02-2c-f, P8-02-2c-g, P8-02-3-1, P8-02-3-2, P8-02-3-3, P8-02-3-4, and P8-02-4 are complete. No remaining semantics implementation slices are open.

1. **P8-02-2a** (Sheet chrome + primary actions) - AppBar/back, edit action, and the identity header controls
2. **P8-02-2b** (Combat + recovery controls) - death save buttons, rest actions, and class-resource controls
3. **P8-02-2c** (Spells + inventory controls) - spell slot chips, quantity controls, dropdowns, and stack actions
4. **P8-02-3** (Dialog semantics) - interrupted mutation dialog title, content, and actions

**P8-02-2c sub-slices:**
1. **P8-02-2c-a** - spell slot chips
2. **P8-02-2c-b** - available spells list items
3. **P8-02-2c-c** - inventory quantity controls
4. **P8-02-2c-d** - inventory action chips
5. **P8-02-2c-e** - inventory charges controls
6. **P8-02-2c-f** - inventory container dropdown
7. **P8-02-2c-g** - inventory stack operations

**Slice Order:**
1. **P8-02-1** (Panel Headers & Identity) - AppBar, panel headers, FactRow labels/values, Portrait preview
2. **P8-02-2** (Interactive Widgets) - All IconButton, OutlinedButton, ActionChip, FilterChip, DropdownButtonFormField
3. **P8-02-3** (Dialog Semantics) - Interrupted mutation dialog title, content, actions
4. **P8-02-4** (Focus Management) - Add FocusNode and FocusScope for keyboard focus tracking

**Verification:**
```bash
flutter analyze
flutter test test/character_sheet_accessibility_test.dart -r expanded
flutter test test/character_sheet_screen_keyboard_test.dart -r expanded
```

---

## Phase 8 Microtask Strategy

Keep every task small and sequential:
1. Audit the current gap or capability.
2. Implement one user-facing slice.
3. Verify with `flutter analyze` and targeted tests.
4. Only then move to the next microtask.

Do not expand scope beyond the current slice.

---

## Microtask Breakdown

### Microtask ID: P8-01
**Title:** Audit accessibility gaps in character sheet  
**Dependencies:** None  
**Status:** **COMPLETE** (2026-05-05)  
**Objective:** Review `lib/src/features/characters/presentation/character_sheet_screen.dart` and `AGENTS.md` to identify missing semantics labels, keyboard navigation gaps, and screen reader support issues. Document the exact slice order before implementation begins.  
**Files to Touch:**
- `lib/src/features/characters/presentation/character_sheet_screen.dart`
- `lib/src/features/characters/presentation/character_editor_controller.dart`
- `docs/project/PHASE_8_PLAN.md`
**Verification:** ✅ Complete. Audit documented in `docs/project/ACCESSIBILITY_AUDIT_P8-01.md`.

---

### Microtask ID: P8-02
**Title:** Add semantics labels to character sheet widgets  
**Dependencies:** P8-01  
**Objective:** Add `Semantics` labels to key widgets in the character sheet (header, combat values, spell slots, inventory rows) to enable screen reader navigation. Follow Flutter accessibility guidelines.  
**Files to Touch:**
- `lib/src/features/characters/presentation/character_sheet_screen.dart`
- `test/character_sheet_screen_semantics_test.dart`
- `test/character_sheet_screen_combat_recovery_semantics_test.dart`
**Implementation slices:**
- **P8-02-2a:** AppBar/back, edit action, and identity header semantics
- **P8-02-2b:** Combat and recovery control semantics
- **P8-02-2c:** Spells and inventory control semantics
- **P8-02-3:** Dialog semantics for inventory mutation flows
**Progress:** P8-02-2a and P8-02-2b are complete. The remaining semantics work is P8-02-2c-a through P8-02-2g and P8-02-3.
**Verification:**
```bash
flutter analyze
flutter test test/character_sheet_screen_semantics_test.dart -r expanded
flutter test test/character_sheet_screen_combat_recovery_semantics_test.dart -r expanded
```

---

### Microtask ID: P8-03
**Title:** Verify keyboard navigation in character sheet  
**Dependencies:** P8-02  
**Objective:** Ensure all interactive elements in the character sheet are keyboard accessible (Tab order, Enter/Space activation, Escape to close dialogs). Add missing keyboard event handlers.  
**Files to Touch:**
- `lib/src/features/characters/presentation/character_sheet_screen.dart`
- `lib/src/features/characters/presentation/merge_stack_dialog.dart`
- `lib/src/features/characters/presentation/split_stack_dialog.dart`
- `lib/src/features/characters/presentation/transfer_to_container_dialog.dart`
- `lib/src/features/characters/presentation/container_management_dialog.dart`
**Verification:**
```bash
flutter analyze
flutter test test/character_sheet_screen_keyboard_test.dart (new)
```

---

### Microtask ID: P8-04
**Title:** Add visual feedback for focus states  
**Dependencies:** P8-03  
**Status:** **COMPLETE** (2026-05-05)  
**Objective:** Add focus indicator styling to all interactive widgets in the character sheet and dialogs. Ensure visible focus rings for keyboard users.  
**Files to Touch:**
- `lib/src/features/characters/presentation/character_sheet_screen.dart`
- All dialog widgets in `lib/src/features/characters/presentation/`
**Verification:**
```bash
flutter analyze
flutter test test/character_sheet_focus_test.dart (new)
```

---

### Microtask ID: P8-05
**Title:** Implement advanced inventory stack management  
**Dependencies:** P8-04  
**Status:** **COMPLETE** (2026-05-05)  
**Objective:** Add advanced inventory features: bulk quantity adjustments, stack sorting, and priority stacking. Extend `CharacterInventoryService` with new methods.  
**Files to Touch:**
- `lib/src/features/characters/application/character_inventory_service.dart`
- `lib/src/features/characters/domain/character_inventory_stack_rules.dart`
- `lib/src/features/characters/data/drift_character_repository.dart`
**Verification:**
```bash
flutter analyze
flutter test test/character_inventory_service_test.dart -r expanded
```

---

### Microtask ID: P8-06
**Title:** Add spell slot bulk operations  
**Status:** Complete  
**Dependencies:** P8-05  
**Objective:** Implement bulk spell slot operations: spend all slots of a level, restore all slots of a level, and bulk slot selection. Extend the spell slot usage domain model.  
**Files to Touch:**
- `lib/src/features/characters/domain/character_spell_slot_usage_rules.dart` (new)
- `lib/src/features/characters/application/character_recovery_service.dart`
- `lib/src/features/characters/presentation/character_sheet_screen.dart`
**Verification:**
```bash
flutter analyze
flutter test test/character_spell_slot_usage_test.dart -r expanded
```

---

### Microtask ID: P8-07
**Title:** Add spell selection mode enhancements  
**Status:** Complete  
**Dependencies:** P8-06  
**Objective:** Enhance prepared spell selection with quick-access lists (daily, weekly, monthly rotation). Add spell category filtering and smart sorting.  
**Files to Touch:**
- `lib/src/features/characters/domain/prepared_spell_selection_domain.dart`
- `lib/src/features/characters/presentation/prepared_spell_selection_screen.dart`
**Verification:**
```bash
flutter analyze
flutter test test/prepared_spell_selection_test.dart -r expanded
```

---

### Microtask ID: P8-08
**Title:** Add advanced combat automation helpers  
**Dependencies:** P8-07  
**Status:** **COMPLETE** (2026-05-05)  
**Objective:** Implement combat automation: auto-attack on turn, auto-resolve death saves, and quick-rest shortcuts. Extend `CharacterCombatRules` with automation support.  
**Files to Touch:**
- `lib/src/features/characters/domain/character_combat_rules.dart`
- `lib/src/features/characters/application/character_death_save_service.dart`
**Verification:**
```bash
flutter analyze
flutter test test/character_combat_rules_test.dart -r expanded
```

---

### Microtask ID: P8-09
**Title:** Add advanced compendium search and filtering  
**Dependencies:** P8-08  
**Status:** COMPLETE (2026-05-05)  
**Objective:** Implement compendium search with filters (category, source, pack, rarity). Add quick-access compendium results panel.  
**Files to Touch:**
- `lib/src/features/compendium/domain/compendium_catalog.dart`
- `lib/src/features/compendium/domain/compendium_search_service.dart`
- `lib/src/features/compendium/presentation/compendium_screen.dart`
- `test/compendium_search_service_test.dart`
- `test/compendium_screen_test.dart`
**Verification:**
```bash
flutter analyze
flutter test test/compendium_search_service_test.dart test/src/features/compendium/compendium_search_service_test.dart test/compendium_screen_test.dart -r expanded
```

---

### Microtask ID: P8-10
**Title:** Add session persistence and auto-save  
**Dependencies:** P8-09  
**Objective:** Implement background auto-save for character changes and session state. Add manual save confirmation dialogs. Ensure data integrity during rapid edits.  
**Current progress:** schema foundation complete (`last_saved_at` added to `characters`, schema v21); remaining work is auto-save/change-tracking wiring and tests.
**Files to Touch:**
- `lib/src/features/characters/application/character_sheet_service.dart`
- `lib/src/features/characters/data/local/app_database.dart`
**Verification:**
```bash
flutter analyze
flutter test test/character_sheet_service_test.dart -r expanded
flutter test test/app_database_test.dart -r expanded
```

---

## Phase 8 Exit Criteria

1. All character sheet widgets have semantics labels and keyboard navigation.
2. All dialogs are fully keyboard accessible with visible focus indicators.
3. Advanced inventory operations are implemented and tested.
4. Spell slot bulk operations are functional and persist correctly.
5. Compendium search and filtering work with imported content.
6. Auto-save mechanism preserves session state during rapid edits.
7. `flutter analyze` passes after every microtask.
8. `PHASE_8_PLAN.md` records completion status clearly.
9. `SESSION_RESUME.md` and `PROJECT_SNAPSHOT.md` reflect the Phase 8 result.

---

## Assumptions & Risks

### Assumptions
- Semantics labels should follow Flutter's accessibility guidelines.
- Advanced inventory features should reuse existing domain rules.
- Compendium search should leverage existing repository patterns.

### Risks
- Accessibility testing requires manual verification beyond automated tests.
- Auto-save may introduce race conditions during rapid edits.
- Some advanced features may require new domain models.

---

## Next Step After Phase 8

After Phase 8 completion, proceed to Phase 9: "Future Features & Expansion" which will include network sync, DM tooling, and additional quality-of-life improvements.
