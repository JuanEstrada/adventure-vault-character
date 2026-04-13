---
plan name: MinRelease
plan description: Cerrar MVP funcional offline
plan status: nonactive
---

#

## Idea

Objetivo: llevar Adventure Vault Character a una versión mínima liberable donde ya no falten capacidades funcionales clave del jugador y lo único pendiente sea profundidad/pulido de UI/UX visual. El plan se basa en los docs de proyecto: fases 1 y 2 están completas; los huecos reales están en spellcasting en sesión, transferencias de inventario, cobertura de edge cases, resiliencia ante estados parciales/interrupciones y una verificación final de alcance. El trabajo se divide en sesiones pequeñas, de poco contexto, aptas para modelos locales como gemma4:26b. Cada sesión debe tocar una sola zona funcional, con objetivo verificable y dependencia mínima.

## Implementation

- Auditar y congelar el criterio de salida de la versión mínima usando ROADMAP, PROJECT_SNAPSHOT y SESSION_RESUME para convertir 'solo falta UI' en un checklist funcional explícito.
- Completar la última brecha funcional de spellcasting en sesión: exponer gasto/restauración directa por slot reutilizando reglas existentes sin mover lógica a widgets.
- Cerrar la última brecha funcional de inventario en sesión: definir y exponer transfer/split/merge mínimos sobre contratos ya existentes o extenderlos solo donde falte soporte real.
- Cubrir con tests los edge cases de spellcasting todavía abiertos, especialmente límites, recortes deterministas y recuperación en rests para clases soportadas.
- Cubrir con tests los edge cases de inventario y transferencias same-item/container/stack para garantizar paridad entre dominio, repositorios in-memory y Drift.
- Hacer una pasada de resiliencia mínima en hoja de personaje para datos faltantes, estados parciales y errores de mutación o lectura/escritura recuperables.
- Revisar que los flujos núcleo offline del jugador queden completos de punta a punta: create, edit, open sheet, combat helpers, spells, inventory y rests sin depender de pantallas auxiliares.
- Actualizar documentación canónica de estado y handoff para reflejar el nuevo criterio de 'release mínima funcional' y dejar explícito qué queda como deuda solo de UI/polish.

## Required Specs
<!-- SPECS_START -->
<!-- SPECS_END -->