# Component Diagram Description

## C4 Level 3 Components Inside the Android App

### Character Manager

Handles character lifecycle operations and coordinates access to character-related state.

### Dice Roller

Collects roll parameters, requests rule data, and delegates computation to the Dice Engine.

### Spell Manager

Maintains spell-related state and exposes spell information for gameplay and display.

### Inventory Manager

Maintains items, equipment state, and inventory-driven character changes.

### Character Sheet Renderer

Builds a consistent player-facing representation of character information, including derived values.

### Import Processor

Coordinates XML validation, transformation, and persistence of imported content.

## Key Relationships

- Character Manager reads and writes character state through the Local Database.
- Dice Roller obtains relevant character modifiers from Character Manager and executes rolls through the Dice Engine.
- Spell Manager and Inventory Manager update character-adjacent state stored in the Local Database.
- Character Sheet Renderer reads consolidated state from the character-related components.
- Import Processor uses the XML Import Module to add rules content to the Local Database.
