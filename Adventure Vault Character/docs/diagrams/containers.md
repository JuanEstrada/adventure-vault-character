# Container Diagram Description

## C4 Level 2 Containers

### Android App

The main Android application container presents screens, coordinates user actions, invokes domain services, and exposes the player experience.

### Local Database

The Local Database stores characters, spells, inventory, imported content, and related metadata using Room over SQLite.

### Dice Engine

The Dice Engine performs D20 rolls and applies modifiers based on the current character state and game actions.

### XML Import Module

The XML Import Module validates and transforms XML content into internal representations that can be consumed by the Android App and stored in the Local Database.

## Relationships

- The Android App uses the Local Database for persistent local state.
- The Android App calls the Dice Engine to execute game mechanics.
- The Android App calls the XML Import Module to process imported content.
- The XML Import Module stores validated content in the Local Database.
