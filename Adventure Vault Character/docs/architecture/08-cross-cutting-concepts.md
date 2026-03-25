# 08. Cross-Cutting Concepts

## Local-First Data Ownership

Character data is owned locally by the device. All major user flows must
operate against local state first, with future synchronization treated as a
secondary concern.

## Modularization

The codebase should be organized around stable capabilities such as character
management, dice mechanics, spell handling, inventory, and import processing.
This reduces coupling and improves testability.

## Rules Automation

D20 mechanics should be implemented as explicit domain logic rather than
embedded inside user interface code. This supports correctness, reuse, and
future extension.

## Compendium Import

Imported compendium content requires validation, mapping, and separation from
core application code. The `Compendium Import System` is the project term for
the subsystem that ingests XML sources, including future user-supplied
compendium packs that add or modify classes, races, backgrounds, spells,
equipment, and related rules data. The import path must prevent malformed or
incompatible content from corrupting the local model.

## Synchronization Readiness

Even without a backend, the internal data model should distinguish between
local identifiers, imported content, and future synchronization metadata so
later integration can be added incrementally.

## Flutter Application Architecture

Flutter-aligned patterns should be used for lifecycle awareness, persistence
integration, navigation, and clear separation between presentation and domain
responsibilities.

## Flutter UI Model

User interface development should follow Flutter patterns with state-driven
rendering, unidirectional data flow, and minimal business logic in widgets.
Screen state should be produced by application-layer components and rendered
declaratively by the UI layer.

## Decision Priority

When architectural or implementation concerns compete, the project should use
the following decision order:

1. Exactitud de reglas
2. Alineación con decisiones y lineamientos del proyecto
3. Escalabilidad futura
4. Simplicidad y mantenibilidad de implementación
5. Optimización avanzada
