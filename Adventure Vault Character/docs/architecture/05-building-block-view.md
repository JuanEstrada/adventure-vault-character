# 05. Building Block View

## Level 1: System

### Adventure Vault Character

Adventure Vault Character is the complete player-facing Flutter system. It
stores and manages character state locally, automates D20 mechanics, and
imports compendium content through XML.

## Level 2: Containers

### Flutter App

The Flutter App contains the widget presentation layer, navigation, screen
state controllers, domain orchestration, and integration with local services.

### Local Database

The Local Database stores characters, inventory, spells, imported content, and
supporting metadata using Drift over SQLite.

### Dice Engine

The Dice Engine encapsulates D20 roll execution, modifier application, and
deterministic business rules related to rolling outcomes.

### Compendium Import System

The Compendium Import System validates, parses, maps, and stores imported
compendium content from XML sources, including future user-uploaded packs that
add or modify classes, races, spells, equipment, and related rules data.

## Level 3: Components

### Flutter UI Layer

Responsible for rendering screens and reusable widgets. It consumes screen
state and emits user intents without owning domain rules directly.

### Navigation Coordinator

Responsible for screen transitions and route definitions across character,
dice, spells, inventory, and future onboarding or help flows.

### Screen State Controllers

Responsible for exposing state and actions for Flutter screens, coordinating
use cases, and keeping UI state lifecycle-aware.

### Character Manager

Responsible for creating, updating, and retrieving character data, including
base attributes and progression-related state.

### Dice Roller

Responsible for invoking dice calculations, applying modifiers, and returning
roll results suitable for session-time interaction.

### Spell Manager

Responsible for spell slot tracking, prepared spells, and spell-related state
attached to characters.

### Inventory Manager

Responsible for items, quantities, equipment state, and inventory effects on
the character.

### Character Sheet Renderer

Responsible for presenting character state consistently to the player,
including derived values and rule-driven summaries.

### Import Processor

Responsible for validating XML input, transforming source compendium content
into internal models, and storing imported entities safely.

## Decomposition Notes

The Level 3 components are logical components inside the Flutter application.
They do not imply separate deployable units. The modular codebase should still
preserve these responsibilities explicitly so later synchronization or DM
integration can attach to stable domain boundaries. In particular, the UI
layer, navigation, and screen state controllers should remain distinct from
domain and persistence responsibilities.
