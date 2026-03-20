# Create Character Screen Specification

## Status

Draft

## Summary

The create character screen is a guided flow, not a free-form form. It must
let the user create a valid initial character record using compendium-backed
choices for race, class, and background, plus a complete ability score
selection, then open the character sheet immediately after local persistence
succeeds.

## Goals

- Give first-time users a direct path from the main menu to a usable
  character.
- Define the minimum required data for a valid initial character record.
- Establish save and cancel behavior for future editing flows.

## In Scope

- Character creation entry flow
- Guided race and name step
- Guided background step
- Guided ability score step
- Guided class, level, and experience step
- Compendium-backed race list
- Compendium-backed background list
- Ability score method selection
- Random ability score generation and assignment
- Point-buy ability score assignment
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
- Select background from compendium data
- Determine ability scores
- Select class
- Set level
- Enter experience
- Confirm creation
- Cancel creation

## Required Data

- Character name
- Selected race from the compendium
- Selected background from the compendium
- Ability scores for Strength, Dexterity, Constitution, Intelligence, Wisdom,
  and Charisma
- Selected ability score generation method
- Selected class
- Level
- Experience
- Background bonuses and social perks summary
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
4. App continues to background selection.
5. The user chooses a background from compendium-backed options.
6. App shows the background summary, including bonuses and social perks that
   must remain visible later in the character sheet.
7. App continues to ability score determination.
8. The user chooses an available ability score method.
9. If the user selects random generation, the app generates a visible score
   set and lets the user assign each value across the six abilities.
10. If the user selects point buy, the app shows the remaining budget and lets
   the user adjust each ability within the allowed range.
11. App continues to class and progression selection.
12. The user chooses a class and level.
13. The screen shows the class progression table and class features for the
   current level.
14. The user enters experience, or changes level directly.
15. If experience changes, level recalculates from the progression thresholds.
16. If level changes, experience is reset to the minimum required for that
   level.
17. The screen shows the percentage of progress toward the next level.
18. User saves the character.
19. App stores the record locally.
20. App navigates to the created character sheet.

### Cancel Flow

1. User enters the create character flow.
2. User decides not to continue.
3. User cancels.
4. App returns to the previous route without creating a record.

## Acceptance Criteria

- A valid character can be created fully offline.
- Required fields are clearly identified.
- Race choices come from the compendium data set.
- Background choices come from the compendium data set.
- Background bonuses and social perks are visible before save.
- The user must complete all six ability scores before save is enabled.
- The MVP supports at least two ability score methods: random generation with
  manual assignment and point buy with visible remaining points.
- The selected ability score method and final assigned values are persisted.
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
- Ability score method logic, point budget rules, and assignment validation
  must be owned outside widgets.
- Persistence must align with the local Drift-backed model from `ADR-007`.
- This flow depends on compendium-backed race, background, and class
  progression data.
- This flow becomes the basis for later edit-character behavior.
- Related roadmap phases: Phase 1 and Phase 2 in
  `docs/project/ROADMAP.md`.
