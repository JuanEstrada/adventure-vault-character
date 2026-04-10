# 06. Runtime View

## Scenario 1: Character Creation

1. The player starts character creation inside the Flutter application.
2. The Character Manager collects the selected race, class, attributes, and
   initial equipment.
3. The Local Database persists the new character and related state.
4. The Character Sheet Renderer displays the created character with derived
   statistics.

## Scenario 2: Dice Roll with Modifiers

1. The player triggers a dice roll from a character action or dedicated roller
   screen.
2. The Dice Roller requests the relevant modifiers from the Character Manager
   or current character state.
3. The Dice Engine executes the D20 roll and applies the modifiers.
4. The result is returned immediately to the Flutter App.
5. The Character Sheet Renderer or roll result view presents the final value
   to the player.

## Scenario 3: Importing XML Content

1. The player selects an XML file from device storage.
2. The XML Import Module reads the file and performs schema and content
   validation.
3. The Import Processor transforms the XML content into internal entities.
4. The Local Database stores the imported content.
5. The Flutter App exposes the imported rules content to character creation
   and ongoing character management flows.
