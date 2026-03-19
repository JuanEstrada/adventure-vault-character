# Adventure Vault Project Guidelines

This document defines the baseline product and technical guidelines that every
proposal, specification, architectural decision, and implementation change must
follow.

## Product Guidelines

1. The app must prioritize rules accuracy over UI convenience or
   implementation speed.
2. The app must remain offline-first; no core player function should require a
   network connection.
3. The local device is the source of truth for character state.
4. The player app and the future DM app must remain separate products with
   explicit integration boundaries.
5. New features should scale toward future panels, compendium growth,
   contextual help, and future sync readiness.
6. UI references are used to infer flow and feature coverage, not to copy
   visual style literally.
7. Character functionality should stay organized around clear domains:
   character creation, combat, abilities and skills, equipment, features and
   notes, compendium, and rules reference.
8. Help for new players should be optional and should not slow down advanced
   users.

## Technical Guidelines

1. Accepted ADRs are active project constraints and should be followed unless a
   new ADR changes direction.
2. Jetpack Compose is the primary UI technology.
3. Rule logic must not live in composables or purely visual layers.
4. Local persistence must use Room over SQLite.
5. Design should support future growth without introducing premature
   complexity.
6. Favor maintainability and clarity before advanced optimization.
7. Documentation is part of the product and must stay aligned with changes in
   architecture, scope, and implementation planning.
8. New accepted features should be reflected in the appropriate project docs:
   ADRs, arc42 sections, specs, roadmap, and project snapshot as needed.
9. Simplicity is preferred only when it does not compromise rule correctness,
   architecture, or future extensibility.

## Decision Priority

When a tradeoff is required, evaluate options in this order:

1. Exactitud de reglas
2. Alineación con decisiones y lineamientos del proyecto
3. Escalabilidad futura
4. Simplicidad y mantenibilidad de implementación
5. Optimización avanzada

## How To Use This Document

- Use it to evaluate new feature proposals.
- Use it to resolve conflicts between implementation options.
- Use it as a review checklist for specs, architecture updates, and code
  changes.
