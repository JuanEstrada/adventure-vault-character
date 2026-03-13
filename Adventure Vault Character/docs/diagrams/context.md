# Context Diagram Description

## C4 Level 1 Context

### Primary Actor

- Player: uses Adventure Vault Character on an Android device before and during play.

### System

- Adventure Vault Character: the player-facing Android application.

### External Systems

- XML Content Source: provides importable rules content in XML format.
- Adventure Vault Master: future Dungeon Master application that may later exchange synchronized or session-time data.
- Android Platform Services: device-level operating environment used by the application.

### Relationships

- The Player interacts directly with Adventure Vault Character.
- Adventure Vault Character reads XML content from XML Content Source files selected on the device.
- Adventure Vault Character is designed to exchange data with Adventure Vault Master in future versions.
- Adventure Vault Character runs within Android Platform Services.
