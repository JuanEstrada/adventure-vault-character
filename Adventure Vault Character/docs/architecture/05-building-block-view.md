# 05. Building Block View

## Level 1: System

### Adventure Vault Character

Adventure Vault Character is the complete player-facing Android system. It stores and manages character state locally, automates D20 mechanics, and imports rules content through XML.

## Level 2: Containers

### Android App

The Android App contains the Jetpack Compose presentation layer, navigation,
ViewModel-driven screen state, domain orchestration, and integration with local
services.

### Local Database

The Local Database stores characters, inventory, spells, imported content, and supporting metadata using Room over SQLite.

### Dice Engine

The Dice Engine encapsulates D20 roll execution, modifier application, and deterministic business rules related to rolling outcomes.

### XML Import Module

The XML Import Module validates, parses, maps, and stores imported rules content.

## Level 3: Components

### Compose UI Layer

Responsible for rendering screens and reusable UI components with Jetpack
Compose. It consumes screen state and emits user intents without owning domain
rules directly.

### Navigation Coordinator

Responsible for screen transitions and route definitions across character,
dice, spells, inventory, and future onboarding/help flows.

### Screen ViewModels

Responsible for exposing state and actions for Compose screens, coordinating
use cases, and keeping UI state lifecycle-aware.

### Character Manager

Responsible for creating, updating, and retrieving character data, including base attributes and progression-related state.

### Dice Roller

Responsible for invoking dice calculations, applying modifiers, and returning roll results suitable for session-time interaction.

### Spell Manager

Responsible for spell slot tracking, prepared spells, and spell-related state attached to characters.

### Inventory Manager

Responsible for items, quantities, equipment state, and inventory effects on the character.

### Character Sheet Renderer

Responsible for presenting character state consistently to the player, including derived values and rule-driven summaries.

### Import Processor

Responsible for validating XML input, transforming source content into internal models, and storing imported entities safely.

## Decomposition Notes

The Level 3 components are logical components inside the Android application.
They do not imply separate deployable units. The modular codebase should still
preserve these responsibilities explicitly so later synchronization or DM
integration can attach to stable domain boundaries. In particular, Compose UI,
navigation, and ViewModels should remain distinct from domain and persistence
responsibilities.
