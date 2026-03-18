# Component Diagram Description

This file is a lightweight component view of the Android app. The source of
truth for component responsibilities remains
[../architecture/05-building-block-view.md](../architecture/05-building-block-view.md).

## C4 Level 3 Components Inside the Android App

```mermaid
flowchart TD
    Compose[Compose UI Layer]
    Nav[Navigation Coordinator]
    Vm[Screen ViewModels]
    Character[Character Manager]
    DiceRoller[Dice Roller]
    Spell[Spell Manager]
    Inventory[Inventory Manager]
    Import[Import Processor]
    Dice[Dice Engine]
    Xml[XML Import Module]
    Db[(Local Database)]

    Compose --> Nav
    Compose --> Vm
    Vm --> Character
    Vm --> DiceRoller
    Vm --> Spell
    Vm --> Inventory
    Vm --> Import
    DiceRoller --> Dice
    Character --> Db
    Spell --> Db
    Inventory --> Db
    Import --> Xml
    Import --> Db
```

## Responsibilities

- Compose UI Layer: declarative screen rendering and reusable UI components.
- Navigation Coordinator: route definitions and screen transitions.
- Screen ViewModels: lifecycle-aware screen state and user intent handling.
- Character Manager: character lifecycle and derived character data access.
- Dice Roller: prepares roll requests and uses the Dice Engine.
- Spell Manager: spell-related state and queries.
- Inventory Manager: item state and equipment effects.
- Import Processor: imported content orchestration, validation, and persistence.
