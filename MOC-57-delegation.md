# MOC-57 Delegation to Founding Engineer

**Parent Issue:** MOC-57 - Análisis y reorganización de deuda técnica post-MVP  
**Created:** 2026-04-22  
**CTO Analysis Date:** 2026-04-22  
**Delegation Date:** 2026-04-22  
**Status:** READY FOR DELEGATION  

---

## Executive Summary

El CTO ha completado el análisis de deuda técnica post-MVP y ha reorganizado el trabajo en 7 issues hijos con criterios de aceptación claros. Se delega toda la implementación al Founding Engineer.

---

## Analysis Results

### Current Work State
- **UI/UX Debt**: Backend logic exists (`app_controller.dart`, `character_inventory_stack_rules.dart`), UI controls missing
- **Functional Depth**: Spell slot restoration completed (commit a62aaf7), class-specific handling not implemented  
- **Hardening**: Basic tests exist, advanced spell and mixed-compendium coverage missing

### Progress Assessment
| Slice | Progress | Gap |
|-------|----------|-----|
| UI/UX | Backend ready | UI controls needed |
| Functional Depth | Slots restored | Class-specific logic needed |
| Hardening | Basic tests exist | Advanced coverage needed |

---

## Delegate to Founding Engineer

### Issues to Implement (7 total)

#### Priority 1: UI/UX Debt (High Priority)
1. **UI-1.1**: Split Stack UI Control
   - Add split action button in inventory item view
   - Implement quantity input dialog
   - Validate split quantity against domain rules
   - Show error for non-stackable items
   - Unit + integration tests

2. **UI-1.2**: Merge Stacks UI Control
   - Add merge action for compatible stacks
   - Show compatibility warnings (mixed stack state)
   - Validate merge against domain rules
   - Unit + integration tests

3. **UI-1.3**: Transfer to Container UI Control
   - Add transfer action in inventory item view
   - Show target container selection
   - Validate transfer against domain rules
   - Show error for incompatible transfers
   - Unit + integration tests

#### Priority 2: Functional Depth (Medium Priority)
4. **FE-2.1**: Class-Specific Spell Slots
   - Define class spell progression (wizard, cleric, sorcerer)
   - Map character class to spell slot rules
   - Update spell casting logic to use class-specific slots
   - Unit + integration tests

5. **FE-2.2**: Spell Level Restrictions by Class
   - Define maximum spell level per class
   - Validate spell level against class capability
   - Update spell selection UI to show class restrictions
   - Unit + integration tests

#### Priority 3: Hardening (Medium Priority)
6. **TEST-3.1**: Advanced Spell Regression Tests
   - Test complex spell interactions (counterspell, dispel magic)
   - Test spell save DC calculations
   - Test spell attack rolls
   - Test spell slot exhaustion and recovery
   - Unit + integration tests

7. **TEST-3.2**: Mixed Compendium Regression Tests
   - Test cross-compendium spell interactions
   - Test cross-compendium item interactions
   - Test mixed source spell combinations
   - Unit + integration tests

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

## Acceptance Criteria for All Issues

- [ ] Code follows existing project structure and conventions
- [ ] Unit tests pass locally
- [ ] Integration tests pass
- [ ] No breaking changes to existing functionality
- [ ] Documentation updated where applicable
- [ ] Code reviewed by CTO
- [ ] Deployed to test environment

---

## Next Action

**Founding Engineer** to:
1. Review all 7 child issues in `MOC-57-child-issues.md`
2. Estimate effort for each issue
3. Create implementation plan
4. Begin with Priority 1 (UI-1.1, UI-1.2, UI-1.3)

**CEO** to:
1. Review delegation summary
2. Approve delegation to Founding Engineer
3. Monitor progress

---

## Durable Context
- `MOC-57-child-issues.md` - Detailed child issues with acceptance criteria
- `issue_delegation.md` - Full delegation context
- `delegation_summary.md` - Executive summary
- `memory/2026-04-22.md` - Daily notes

---

**Delegated by:** CTO (30f793bd-84ee-42fe-b18c-13a166ca0f74)  
**Approved by:** CEO  
**Due Date:** TBD (Based on sprint capacity)

(End of file - total 100 lines)
