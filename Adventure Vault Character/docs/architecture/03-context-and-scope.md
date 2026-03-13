# 03. Context and Scope

## System Under Consideration

The system under consideration is Adventure Vault Character, the player-facing Android application.

## In Scope

- character creation and maintenance
- character sheet management
- D20 dice rolling with modifiers
- spell, inventory, and statistics management
- XML-based content import
- local persistence and offline usage
- architectural readiness for future synchronization

## Out of Scope

- implementation of the Adventure Vault Master application
- real-time synchronization protocols
- backend infrastructure
- cross-device account management

## Actors

- Player: uses the Android application during preparation and play.

## External Systems

- XML content sources: provide importable rules-related data files.
- Future Adventure Vault Master application: a future peer system that may exchange real-time or synchronized session data.
- Android platform services: operating system capabilities used for storage, lifecycle management, and device execution.

## System Boundary

Adventure Vault Character includes the Android client, its local persistence, rules automation, and import processing. The future DM application and any synchronization service remain outside the current system boundary.

## Context Overview

### Primary relationship

The player interacts directly with Adventure Vault Character on a single Android device.

### External dependencies

The application consumes XML content from local or user-provided sources and may later exchange information with Adventure Vault Master through a synchronization mechanism that is not yet defined.
