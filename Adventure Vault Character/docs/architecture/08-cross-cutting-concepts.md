# 08. Cross-Cutting Concepts

## Local-First Data Ownership

Character data is owned locally by the device. All major user flows must operate against local state first, with future synchronization treated as a secondary concern.

## Modularization

The codebase should be organized around stable capabilities such as character management, dice mechanics, spell handling, inventory, and import processing. This reduces coupling and improves testability.

## Rules Automation

D20 mechanics should be implemented as explicit domain logic rather than embedded inside user interface code. This supports correctness, reuse, and future extension.

## XML Content Import

Imported rules content requires validation, mapping, and separation from core application code. The import path must prevent malformed or incompatible content from corrupting the local model.

## Synchronization Readiness

Even without a backend, the internal data model should distinguish between local identifiers, imported content, and future synchronization metadata so later integration can be added incrementally.

## Android Application Architecture

Jetpack-aligned patterns should be used for lifecycle awareness, persistence integration, and clear separation between presentation and domain responsibilities.
