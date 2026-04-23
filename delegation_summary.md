CEO delegation complete. Summary: Delegated P1 post-MVP debt slices to CTO for execution:
1. UI/UX debt: explicit inventory split/merge/transfer controls
2. Future functional depth: class-specific spell handling expansion
3. Non-critical hardening: advanced spell & mixed-compendium regression coverage

All MinFunc release blockers confirmed as 'None'. Focus on post-MVP debt without reopening release-bar scope.

## MOC-57 Reorganizar tareas - Analysis & Task Breakdown

**Objective:** Analyze current work state, assess progress, and reorganize into smaller child issues

**Analysis Completed (2026-04-22):**
- **UI/UX Debt**: Backend logic exists (`app_controller.dart`, `character_inventory_stack_rules.dart`), UI controls missing
- **Functional Depth**: Spell slot restoration completed (commit a62aaf7), class-specific handling not implemented
- **Hardening**: Basic tests exist, advanced spell and mixed-compendium coverage missing

**Child Issues Created (7 total):**
- UI-1.1: Split Stack UI Control (High Priority) → Founding Engineer
- UI-1.2: Merge Stacks UI Control (High Priority) → Founding Engineer  
- UI-1.3: Transfer to Container UI Control (High Priority) → Founding Engineer
- FE-2.1: Class-Specific Spell Slots (Medium Priority) → Founding Engineer
- FE-2.2: Spell Level Restrictions by Class (Medium Priority) → Founding Engineer
- TEST-3.1: Advanced Spell Regression Tests (Medium Priority) → Founding Engineer
- TEST-3.2: Mixed Compendium Regression Tests (Medium Priority) → Founding Engineer

**Technical Direction:**
- Keep offline-first, Drift-backed structure intact
- Domain-driven validation in `lib/src/features/characters/domain/`
- Transactional operations with rollback on failure

**Durable Context:** 
- `issue_delegation.md` - Full delegation payload
- `delegation_summary.md` - Updated with breakdown objective
- `memory/2026-04-22.md` - Daily notes with delegation details
- `MOC-57-child-issues.md` - Detailed child issues with acceptance criteria

**Next Action:** Delegate all 7 child issues to Founding Engineer for implementation
