# Asignación Formal - Founding Engineer

**Fecha:** 2026-04-23  
**Issue Padre:** MOC-57 — Análisis y reorganización de deuda técnica post-MVP  
**Asignado:** Founding Engineer  
**Prioridad:** Critical  
**Deadline:** 2026-04-25 (48 horas)  

---

## 📋 Instrucciones para el Founding Engineer

### Contexto
El CTO ha completado el análisis de deuda técnica y ha desglosado el trabajo en 7 issues hijos con criterios de aceptación claros. **Ahora debes comenzar la implementación.**

### Lo que debes hacer AHORA:

1. **Revisar los issues** en `MOC-57-child-issues.md` (7 issues listados)
2. **Estimar esfuerzo** para cada issue (horas/personas)
3. **Comenzar implementación** con Priority 1: UI-1.1, UI-1.2, UI-1.3

### Issues Asignados (7 total)

#### Priority 1: UI/UX Debt (High Priority) - Start Here!
1. **UI-1.1**: Split Stack UI Control
2. **UI-1.2**: Merge Stacks UI Control  
3. **UI-1.3**: Transfer to Container UI Control

#### Priority 2: Functional Depth (Medium Priority)
4. **FE-2.1**: Class-Specific Spell Slots
5. **FE-2.2**: Spell Level Restrictions by Class

#### Priority 3: Hardening (Medium Priority)
6. **TEST-3.1**: Advanced Spell Regression Tests
7. **TEST-3.2**: Mixed Compendium Regression Tests

---

## 🎯 Technical Direction

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

---

## ✅ Definition of Done

Para cada issue:
- [ ] Implementación completa del feature
- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] Code review approved
- [ ] Documentation updated

---

## 📞 Next Steps

1. **Revisa `MOC-57-child-issues.md`** - Entiende cada issue
2. **Estima los 7 issues** - Cuánto tiempo tomará cada uno
3. **Empieza con UI-1.1, UI-1.2, UI-1.3** - Priority 1 (High Priority)
4. **Reporta progreso** - Actualiza los checkboxes en `MOC-57-child-issues.md`
5. **Pide ayuda** - Si estás bloqueado, avísame

---

## 📁 Durable Context

- `MOC-57-child-issues.md` - Detailed child issues with acceptance criteria
- `MOC-57_delegated.md` - Executive delegation summary
- `issue_delegation.md` - Full delegation context
- `memory/2026-04-22.md` - Daily notes

---

**Delegado por:** CTO (30f793bd-84ee-42fe-b18c-13a166ca0f74)  
**Approved by:** CEO  
**Status:** ✅ READY TO START

---

(End of file - total 67 lines)
