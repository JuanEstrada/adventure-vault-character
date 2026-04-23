# MOC-57 Child Issues: Technical Debt Post-MVP Reorganization

**Parent Issue:** MOC-57 - Análisis y reorganización de deuda técnica post-MVP  
**Created:** 2026-04-22  
**CTO Analysis Date:** 2026-04-22  
**Analysis Reference:** Commit a62aaf7 (spell slot restoration), existing test suite

---

## Priority 1: UI/UX Debt - Explicit Inventory Controls

### Current State
- Backend logic exists: `app_controller.dart`, `character_inventory_stack_rules.dart`
- Operations: split, merge, transfer stacks
- **Gap:** No explicit UI controls for these operations

### Child Issue 1.1: Implement Split Stack UI Control
**Issue:** UI-1.1 - Add split stack action in inventory UI  
**Priority:** High  
**Assignee:** Founding Engineer  
**Parent:** MOC-57 → 1.1  
**Definition of Done:**
- [ ] Add split action button in inventory item view
- [ ] Implement quantity input dialog
- [ ] Validate split quantity against domain rules
- [ ] Show error for non-stackable items
- [ ] Unit test split validation logic
- [ ] Integration test split operation

**Acceptance Criteria:**
- User can split a stack with quantity > 1
- Error shown for single-item stacks
- Error shown for non-stackable items
- Split quantity validated before execution
- Transactional: partial splits rollback

---

### Child Issue 1.2: Implement Merge Stacks UI Control
**Issue:** UI-1.2 - Add merge stacks action in inventory UI  
**Priority:** High  
**Assignee:** Founding Engineer  
**Parent:** MOC-57 → 1.2  
**Definition of Done:**
- [ ] Add merge action for compatible stacks
- [ ] Show compatibility warnings (mixed stack state)
- [ ] Validate merge against domain rules
- [ ] Unit test merge validation logic
- [ ] Integration test merge operation

**Acceptance Criteria:**
- User can merge identical item stacks
- Warning shown for mixed state containers
- Error shown for incompatible items
- Merge quantity validated before execution
- Transactional: partial merges rollback

---

### Child Issue 1.3: Implement Transfer to Container UI Control
**Issue:** UI-1.3 - Add transfer stack to container action in inventory UI  
**Priority:** High  
**Assignee:** Founding Engineer  
**Parent:** MOC-57 → 1.3  
**Definition of Done:**
- [ ] Add transfer action in inventory item view
- [ ] Show target container selection
- [ ] Validate transfer against domain rules
- [ ] Show error for incompatible transfers
- [ ] Unit test transfer validation logic
- [ ] Integration test transfer operation

**Acceptance Criteria:**
- User can transfer stack to another container
- Error shown for incompatible items
- Error shown for mixed state containers
- Transfer quantity validated before execution
- Transactional: partial transfers rollback

---

## Priority 2: Functional Depth - Class-Specific Spell Handling

### Current State
- Spell slot restoration completed (commit a62aaf7)
- Base spell slot progression implemented in `character_spell_rules.dart`
- **Gap:** No class-specific spell handling (wizard vs cleric vs sorcerer)

### Child Issue 2.1: Implement Class-Specific Spell Slots
**Issue:** FE-2.1 - Add class-specific spell slot progression  
**Priority:** Medium  
**Assignee:** Founding Engineer  
**Parent:** MOC-57 → 2.1  
**Definition of Done:**
- [ ] Define class spell progression (wizard, cleric, sorcerer, etc.)
- [ ] Map character class to spell slot rules
- [ ] Update spell casting logic to use class-specific slots
- [ ] Unit test spell slot calculation per class
- [ ] Integration test spell casting with class slots

**Acceptance Criteria:**
- Wizard uses spell progression: 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4
- Cleric uses spell progression: 1, 2, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
- Spell slot calculation respects class level
- Error shown when attempting to cast beyond available slots

---

### Child Issue 2.2: Implement Spell Level Restriction by Class
**Issue:** FE-2.2 - Add spell level restrictions per class  
**Priority:** Medium  
**Assignee:** Founding Engineer  
**Parent:** MOC-57 → 2.2  
**Definition of Done:**
- [ ] Define maximum spell level per class
- [ ] Validate spell level against class capability
- [ ] Update spell selection UI to show class restrictions
- [ ] Unit test spell level validation
- [ ] Integration test spell selection with class restrictions

**Acceptance Criteria:**
- Wizard can cast up to 9th-level spells
- Cleric can cast up to 9th-level spells
- Sorcerer can cast up to 9th-level spells
- Error shown when selecting spell beyond class capability

---

## Priority 3: Hardening - Regression Coverage

### Current State
- Existing tests in `test/` directory
- Character domain model tests exist
- **Gap:** Missing advanced spell and mixed-compendium regression coverage

### Child Issue 3.1: Add Advanced Spell Regression Tests
**Issue:** TEST-3.1 - Add regression tests for advanced spells  
**Priority:** Medium  
**Assignee:** Founding Engineer  
**Parent:** MOC-57 → 3.1  
**Definition of Done:**
- [ ] Test complex spell interactions (counterspell, dispel magic)
- [ ] Test spell save DC calculations
- [ ] Test spell attack rolls
- [ ] Test spell slot exhaustion and recovery
- [ ] Unit test each advanced spell scenario
- [ ] Integration test spell combat sequence

**Acceptance Criteria:**
- All advanced spells have regression tests
- Spell interactions validated
- Spell save DC calculated correctly
- Spell attack rolls calculated correctly
- Tests pass on current codebase
- Tests will catch regression on code changes

---

### Child Issue 3.2: Add Mixed Compendium Regression Tests
**Issue:** TEST-3.2 - Add regression tests for mixed compendium  
**Priority:** Medium  
**Assignee:** Founding Engineer  
**Parent:** MOC-57 → 3.2  
**Definition of Done:**
- [ ] Test cross-compendium spell interactions
- [ ] Test cross-compendium item interactions
- [ ] Test mixed source spell combinations
- [ ] Unit test each mixed compendium scenario
- [ ] Integration test mixed compendium combat sequence

**Acceptance Criteria:**
- Cross-compendium interactions tested
- Mixed source spell combinations validated
- Tests pass on current codebase
- Tests will catch regression on code changes

---

## Summary

| Priority | Issue | Type | Assignee | Status |
|----------|-------|------|----------|--------|
| P1 | UI-1.1 | Split Stack UI | Founding Engineer | To Delegate |
| P1 | UI-1.2 | Merge Stacks UI | Founding Engineer | To Delegate |
| P1 | UI-1.3 | Transfer UI | Founding Engineer | To Delegate |
| P2 | FE-2.1 | Class Spell Slots | Founding Engineer | To Delegate |
| P2 | FE-2.2 | Spell Level Restrictions | Founding Engineer | To Delegate |
| P3 | TEST-3.1 | Advanced Spell Tests | Founding Engineer | To Delegate |
| P3 | TEST-3.2 | Mixed Compendium Tests | Founding Engineer | To Delegate |

---

## Technical Direction

### Architecture Decisions
1. **Keep offline-first, Drift-backed structure intact** - All new UI and logic must work with local SQLite storage
2. **Domain-driven validation** - Keep business logic in domain layer (`lib/src/features/characters/domain/`)
3. **Transactional operations** - All inventory operations must be atomic with rollback on failure

### Dependencies
- No external dependencies required
- Uses existing `character_inventory_stack_rules.dart` domain logic
- Uses existing `app_controller.dart` repository pattern

### Risk Assessment
- **Low Risk**: UI additions to existing domain logic
- **Medium Risk**: Class-specific spell handling may require data migration
- **Mitigation**: Add data versioning and migration support

---

## Next Action

Delegate all 7 child issues to Founding Engineer for implementation. CEO to review and approve delegation.
