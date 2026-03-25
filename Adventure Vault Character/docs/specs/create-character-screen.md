# Create Character Screen Specification

## Status

Draft

## Summary

The create character screen is a guided flow, not a free-form form. It must
let the user create a valid initial character record using compendium-backed
choices for race, class, and background, plus a complete ability score
selection, then open the character sheet immediately after local persistence
succeeds.

The flow should begin from a builder overview screen that shows the major
creation sections and exposes entry actions for loading a character from XML
or advancing into the guided creation path.

## Goals

- Give first-time users a direct path from the main menu to a usable
  character.
- Define the minimum required data for a valid initial character record.
- Establish save and cancel behavior for future editing flows.

## In Scope

- Character creation entry flow
- Character builder overview screen
- Guided race and name step
- Guided background step
- Guided class, level, and experience step
- Guided ability score step
- Guided equipment step
- Guided finishing-details step
- Compendium-backed race list
- Compendium-backed background list
- Ability score method selection
- Generated score-set assignment
- Manual point allocation across the six abilities
- Starter equipment currency roll or equivalent starting-money setup
- Equipment category selection
- Item selection from compendium-backed equipment data
- Quantity and cost confirmation for equipment purchase
- Class progression display
- Final narrative and appearance details capture
- Load-character entry action from XML file
- Validation for required data
- Save and cancel actions
- Navigation to the created character after success

## Out of Scope

- Assisted preference-based character wizard
- Name generator
- Full advanced character builder logic
- Full XML import behavior for character creation
- Multi-step onboarding guidance beyond the essentials

## Entry Conditions

- The user selects create character from the main menu.

## Exit Paths

- Save successfully and navigate to the character sheet
- Cancel and return to the previous route
- Open the documented XML-load entry without requiring full MVP import
  completion

## Primary Actions

- Review the builder sections from the overview screen
- Load a character from XML
- Enter core character identity data
- Select race from compendium data
- Select background from compendium data
- Determine ability scores
- Select class
- Set level
- Enter experience
- Select starting equipment
- Add finishing details
- Confirm creation
- Cancel creation

## Required Data

- Builder section summaries or labels
- Character name
- Selected race from the compendium
- Selected background from the compendium
- Ability scores for Strength, Dexterity, Constitution, Intelligence, Wisdom,
  and Charisma
- Selected ability score generation method
- Method-specific ability score provenance
- Starting money summary for equipment purchasing
- Selected equipment entries
- Selected class
- Level
- Experience
- Optional portrait reference
- Optional appearance details
- Optional finishing narrative details
- Background bonuses and social perks summary
- Class progression data
- Experience thresholds by level
- Validation state for required fields

## UI States

- Overview ready: builder sections and entry actions are visible
- Ready: empty or partially completed form
- Validation error: missing or invalid required fields
- Finalize validation error: the app lists which required builder sections are
  still incomplete
- Rules preview: class progression and class features update as level changes
- Finishing details ready: optional final details can be added or skipped
- Saving: local persistence write in progress
- Success: character created and navigation continues to character sheet
- Save error: local persistence failure with retry path

## User Flows

1. User enters the create character flow.
2. App shows the character builder overview screen with the main creation
   sections and top actions.
3. The overview includes a visible action to load a character from XML.
4. The XML-load action is a documented builder entry point, but full XML
   import behavior is not required for MVP completion.
5. If the user chooses guided creation instead of XML loading, the app opens
   the first guided section.
6. The user chooses a race from compendium-backed options and enters a name.
7. App continues to background selection.
8. The user chooses a background from compendium-backed options.
9. App shows the background summary, including bonuses and social perks that
   must remain visible later in the character sheet.
10. App continues to class and progression selection.
11. The user chooses a class and level.
12. The screen shows the class progression table and class features for the
   current level.
13. The user enters experience, or changes level directly.
14. If experience changes, level recalculates from the progression thresholds.
15. If level changes, experience is reset to the minimum required for that
   level.
16. The screen shows the percentage of progress toward the next level.
17. App continues to ability score determination.
18. The user chooses an available ability score method.
19. The ability score screen shows all six abilities at once.
20. If the user selects generated set assignment, the app presents a visible
    score set and initializes it from the compendium's
    `Standard Array by Class` recommendation for the currently selected class.
21. If the selected class changes while generated set assignment is active,
    the visible recommended array updates to match the new class.
22. If the user selects manual point allocation, the app shows the remaining
    budget and lets the user adjust each ability within the allowed range.
23. The user accepts the final ability scores.
24. App continues to equipment selection.
25. The equipment screen shows a summary of available starting money and the
    current choice for major categories such as armor, weapons, gear, and
    equipment packs.
26. The user opens a category and sees a selectable item list.
27. The user can review item summaries such as type, rule-relevant value, and
    cost before selecting.
28. If the user selects a purchasable item, the app allows quantity
    adjustment and shows total cost against available money before confirm.
29. App updates the chosen equipment summary after confirmation.
30. App continues to finishing details.
31. The finishing details screen allows optional portrait, appearance, and
    narrative-character fields before save.
32. The user can add or skip fields such as age, height, weight, eyes, skin,
    hair, alignment, faction, personality traits, ideals, bonds, and flaws.
33. The finishing-details screen exposes a visible finalize action based on
    the builder reference.
34. When the user taps finalize, the app validates these required builder
    sections: `Race + name`, `Background`, `Ability scores`, and
    `Class / level / experience`.
35. If any required section is incomplete, the app blocks finalization and
    shows a message explaining exactly which sections are still missing.
36. Only when the required points pass validation does the app persist the
    character locally.
37. The saved character appears in the main-menu character cards.
38. App navigates to the created character sheet.

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
- The MVP supports at least two ability score methods: generated set
  assignment and manual point allocation with visible remaining points.
- Generated set assignment is driven by the selected class and uses the
  compendium `Standard Array by Class` recommendation for that class.
- Changing class updates the generated recommended array before save.
- The selected ability score method and final assigned values are persisted.
- Method-specific provenance for the chosen ability score mode is preserved.
- The builder overview screen exposes a visible XML load action.
- The XML load action is treated as a documented builder entry point, not as
  a fully implemented MVP import requirement.
- Class, level, and experience are established before ability scores,
  before equipment selection, and before final save.
- The equipment step shows available money and current selections by category.
- Equipment choices are made from compendium-backed item data.
- Item purchase confirmation shows quantity, total cost, and remaining or
  available money context before confirmation.
- The selected equipment entries are persisted with the created character.
- Class progression and level-appropriate class features are visible during
  creation.
- Changing experience recalculates level automatically.
- Changing level resets experience to the minimum required for that level.
- Progress toward the next level is visible.
- After class, level, experience, and equipment are set, the flow continues
  to a final finishing-details step before save.
- Finishing details can be completed or skipped without invalidating the
  minimum MVP character record.
- `Alignment` is captured in finishing details rather than in a separate
  standalone MVP step.
- If entered, finishing details are persisted with the created character.
- The finalize action validates `Race + name`, `Background`,
  `Ability scores`, and `Class / level / experience` before save.
- If validation fails, the user sees a message that states what is missing.
- Finalizing from the finishing-details screen persists the character and adds
  it to the main-menu character cards.
- Invalid submissions are blocked with visible feedback.
- Successful creation persists locally and opens the character sheet.
- Canceling does not create a partial persisted character unless explicitly
  designed later.

## Architectural Notes

- Creation rules should be owned by application or domain boundaries, not
  widgets.
- Ability score method logic, point budget rules, and assignment validation
  must be owned outside widgets.
- Finalize validation must resolve required-point failures into user-facing
  section names or equivalent clear missing-item messages, not raw internal
  errors only.
- Persistence must align with the local Drift-backed model from `ADR-007`.
- Compendium parsing for creation must read the active FightClub SRD 5.5e XML
  files under
  `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/`
  and normalize them into creation-friendly domain outputs.
- The visual interaction for the ability score step should use
  `local-ui-assets/character-builder/10_builder_ability_scores.jpg` as a
  flow reference, especially the always-visible six-ability layout and the
  split between generated-set assignment and manual allocation.
- The builder overview screen should use
  `local-ui-assets/character-builder/00_builder_main_menu.jpg` as a flow
  reference, especially the visible section list plus top-level `LOAD` action
  for XML character loading.
- The `LOAD` action should remain visible in MVP even if full XML-import
  behavior is deferred.
- The visual interaction for the equipment step should use
  `local-ui-assets/character-builder/11_builder_equipment.jpg`,
  `local-ui-assets/character-builder/12_builder_equipment_chain_mail_owned.jpg`,
  and
  `local-ui-assets/character-builder/13_builder_equipment_chain_mail_detail.jpg`
  as flow references for summary, category item selection, and quantity-cost
  confirmation.
- The visual interaction for the finishing-details step should use
  `local-ui-assets/character-builder/14_builder_finishing_details.jpg` as a
  flow reference for the final optional character-enrichment screen and its
  finalize action.
- This flow depends on compendium-backed race, background, and class
  progression data, plus compendium-backed equipment data.
- This flow becomes the basis for later edit-character behavior.
- Related roadmap phases: Phase 1 and Phase 2 in
  `docs/project/ROADMAP.md`.
