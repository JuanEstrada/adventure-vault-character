# App Discovery Snapshot

Resumen operativo del proyecto para dar contexto rapido a herramientas de IA y
retomar sesiones sin volver a inferir el estado de la app desde cero.

## Fecha de verificacion

- 2026-03-27, actualizada tras la normalizacion `v10`

## Fuentes de verdad

- `docs/project/SESSION_RESUME.md`
- `docs/project/PROJECT_SNAPSHOT.md`
- `docs/project/PROJECT_GUIDELINES.md`

## Como usar este archivo

- Usalo como briefing corto del estado actual del producto.
- Usalo para resolver rapidamente alcance, stack, arquitectura y restricciones.
- No lo uses como reemplazo de ADRs, specs o documentacion de arquitectura.

## Estado actual de la app

- Estado: En desarrollo
- Madurez actual: MVP funcional parcial sobre una base ya implementada
- Que ya funciona:
  - Flujo offline `bootstrap -> access -> main menu`
  - Creacion guiada de personaje
  - Guardado local de personajes con Drift sobre SQLite
  - Lista de personajes guardados
  - Apertura de hoja de personaje
  - Reapertura y edicion de personajes existentes
  - Carga local de compendio SRD y soporte base para XML como fuente

## Stack

- Frontend: Flutter + Dart
- Backend: No hay backend productivo activo en la app actual
- Base de datos: Drift sobre SQLite local
- Modelo de producto: offline-first, con el dispositivo local como fuente de
  verdad

## Que ya esta hecho

- Shell de aplicacion con organizacion feature-first
- Separacion de capas entre `presentation`, `application`, `domain` y `data`
- Persistencia normalizada de personajes y compendio local en Drift
- Flujo MVP `crear -> guardar -> tarjeta -> abrir hoja -> editar -> guardar`
- Reglas compartidas para modificadores, proficiency bonus, progreso e hit
  points iniciales
- Reglas base de compendio normalizadas en Drift para
  `character advancement` y `standard array by class`
- Catalogos narrativos oficiales normalizados en Drift para
  `alignment`, `personality traits`, `ideals`, `bonds`, `flaws` y una base
  inicial de `faction`
- Cobertura base de migraciones y de flujos principales

## Que quiere tener la app final

- Personajes: Si
- Tiradas: Probable a futuro, pero no definidas como capacidad cerrada del MVP
- Hechizos: Si
- Inventario: Si
- DM online: No en esta app
- Otras capacidades esperadas:
  - Compendio local
  - Importacion de `compendium packs` por XML
  - Referencia de reglas SRD offline
  - Hoja de personaje con calculos deterministas

## Nivel de fidelidad a D&D

- Seleccion: Exacto SRD
- Nota: el proyecto prioriza exactitud de reglas, comportamiento
  determinista y trazabilidad de calculos sobre simplificaciones de UI o de
  implementacion.

## Diseno

- Seleccion: Minimalista funcional
- Estado del diseno:
  - Hay decisiones funcionales ya tomadas, como hoja por paneles y tarjetas
    de personaje tipo biblioteca
  - No existe todavia un sistema visual final completamente cerrado

## Arquitectura

- Seleccion: Ya definida
- Arquitectura vigente:
  - Offline-first
  - Flutter + Dart
  - Drift sobre SQLite
  - Estructura feature-first
  - Separacion estricta entre `presentation`, `application`, `domain` y `data`
  - Reglas del personaje fuera de widgets y fuera de la persistencia

## Margen para cambios en el codigo

- Seleccion: Mejorar
- Que significa en este proyecto:
  - Se puede refactorizar para mejorar claridad, extensibilidad y separacion de
    responsabilidades
  - No se debe rehacer la base sin necesidad ni romper decisiones ya aceptadas
- Restricciones:
  - Respetar la arquitectura actual y los ADRs aceptados
  - Mantener separacion de capas
  - No mover logica de reglas a widgets
  - No acoplar reglas de dominio a Drift ni a Flutter UI

## Documentacion y tests

- Seleccion: Si
- Expectativa actual:
  - Mantener actualizados `SESSION_RESUME.md` y `PROJECT_SNAPSHOT.md`
  - Actualizar specs, arquitectura o ADRs cuando cambie el comportamiento o la
    estructura del sistema
  - Agregar o actualizar tests cuando cambien reglas, persistencia o flujos
    significativos

## Donde se usara el prompt

- Seleccion: Codex
- Audiencia principal de este documento: contexto rapido para IA

## Restricciones clave que no deben romperse

- La exactitud de reglas tiene prioridad sobre la conveniencia de UI
- Las funciones centrales del jugador deben funcionar offline
- El dispositivo local es la fuente de verdad del estado del personaje
- La app del jugador y la futura app de DM son productos separados
- La logica de dominio debe seguir siendo determinista y testeable

## Proximos focos esperados

- Extender el flujo de edicion mas alla del MVP guiado actual
- Profundizar la fidelidad del compendio cargado desde XML
- Formalizar mas reglas de personaje a traves de contratos de dominio y
  servicios deterministas
- Conectar los catalogos narrativos ya normalizados con el flujo real de
  `finishing details` para soportar modos `empty / rolled / manual`
- Poblar con mas contenido real las areas de sheet que hoy siguen en estado
  MVP o parcial

## Limites de este documento

- No reemplaza `docs/specs/`
- No reemplaza `docs/adr/`
- No define contratos detallados de implementacion
- Sirve como snapshot corto y verificado, no como especificacion completa
