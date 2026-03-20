# Create Character Screen Specification

## Status

Draft

## Summary

The create character screen is a guided flow, not a free-form form. It must
let the user create a valid initial character record using compendium-backed
choices for race and class, then open the character sheet immediately after
local persistence succeeds.

## Goals

- Give first-time users a direct path from the main menu to a usable
  character.
- Define the minimum required data for a valid initial character record.
- Establish save and cancel behavior for future editing flows.

## In Scope

- Character creation entry flow
- Guided race and name step
- Guided class, level, and experience step
- Compendium-backed race list
- Class progression display
- Validation for required data
- Save and cancel actions
- Navigation to the created character after success

## Out of Scope

- Assisted preference-based character wizard
- Name generator
- Full advanced character builder logic
- Import-driven character creation
- Multi-step onboarding guidance beyond the essentials

## Entry Conditions

- The user selects create character from the main menu.

## Exit Paths

- Save successfully and navigate to the character sheet
- Cancel and return to the previous route

## Primary Actions

- Enter core character identity data
- Select race from compendium data
- Select class
- Set level
- Enter experience
- Confirm creation
- Cancel creation

## Required Data

- Character name
- Selected race from the compendium
- Selected class
- Level
- Experience
- Class progression data
- Experience thresholds by level
- Validation state for required fields

## UI States

- Ready: empty or partially completed form
- Validation error: missing or invalid required fields
- Rules preview: class progression and class features update as level changes
- Saving: local persistence write in progress
- Success: character created and navigation continues to character sheet
- Save error: local persistence failure with retry path

## User Flows

1. User enters the create character flow.
2. App shows the guided step for race and name.
3. The user chooses a race from compendium-backed options and enters a name.
4. App continues to class and progression selection.
5. The user chooses a class and level.
6. The screen shows the class progression table and class features for the
   current level.
7. The user enters experience, or changes level directly.
8. If experience changes, level recalculates from the progression thresholds.
9. If level changes, experience is reset to the minimum required for that
   level.
10. The screen shows the percentage of progress toward the next level.
11. User saves the character.
12. App stores the record locally.
13. App navigates to the created character sheet.

### Cancel Flow

1. User enters the create character flow.
2. User decides not to continue.
3. User cancels.
4. App returns to the previous route without creating a record.

## Acceptance Criteria

- A valid character can be created fully offline.
- Required fields are clearly identified.
- Race choices come from the compendium data set.
- Class progression and level-appropriate class features are visible during
  creation.
- Changing experience recalculates level automatically.
- Changing level resets experience to the minimum required for that level.
- Progress toward the next level is visible.
- Invalid submissions are blocked with visible feedback.
- Successful creation persists locally and opens the character sheet.
- Canceling does not create a partial persisted character unless explicitly
  designed later.

## Architectural Notes

- Creation rules should be owned by application or domain boundaries, not
  widgets.
- Persistence must align with the local Drift-backed model from `ADR-007`.
- This flow depends on compendium-backed race and class progression data.
- This flow becomes the basis for later edit-character behavior.
- Related roadmap phases: Phase 1 and Phase 2 in
  `docs/project/ROADMAP.md`.
