---
plan name: MinFunc
plan description: Cerrar funcionalidad minima real
plan status: active
---
#

## Idea

Objetivo: redefinir el cierre como funcionalidad mínima estricta, no como 'completar todo lo pendiente'. La release mínima debe permitir usar la app offline durante una sesión real de juego con un personaje existente o recién creado, manteniendo reglas deterministas y sin huecos funcionales bloqueantes; todo lo que sea profundidad extra, comodidad, variantes avanzadas o mejoras visuales queda fuera. Bajo ese criterio, el alcance se reduce a cerrar solo el loop central del jugador: crear/editar personaje, abrir la sheet, consultar combate base, gestionar slots de conjuro de forma directa, aplicar mutaciones de inventario ya soportadas, descansar y recuperarse, y sobrevivir a errores/estados parciales sin romperse. El plan se divide en sesiones pequeñas y de bajo contexto para modelos locales.

## Implementation

- Definir el release bar funcional mínimo y convertirlo en un checklist binario de capacidades obligatorias del jugador, separando explícitamente lo esencial de lo que puede quedar como deuda de UI o profundidad.
- Validar el loop central ya implementado contra ese checklist para descartar trabajo innecesario y dejar identificados solo los huecos que realmente bloquean una sesión offline completa.
- Cerrar la brecha funcional imprescindible de spellcasting en sesión: gasto y restauración directa de slots desde la sheet usando reglas existentes, sin expandir casos avanzados fuera del scope mínimo.
- Asegurar que el inventario mínimo en sesión sea suficiente con las mutaciones ya disponibles; solo añadir una acción faltante si la auditoría demuestra que hoy bloquea un uso real en mesa.
- Hacer una pasada corta de resiliencia funcional en sheet y mutaciones: estados parciales, rechazos esperables y errores recuperables deben quedar visibles y no romper el flujo.
- Agregar tests y smoke coverage únicamente para el release bar mínimo, priorizando spells, inventario básico, rests y reapertura/persistencia offline.
- Actualizar la documentación canónica para declarar qué entra en la versión mínima funcional y qué se difiere conscientemente como deuda de UI/UX o profundidad futura.

## Required Specs
<!-- SPECS_START -->
- MinFuncSpec
<!-- SPECS_END -->