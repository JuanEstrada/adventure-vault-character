# Character Sheet Screen Specification

## Status

Draft

## Summary

The character sheet screen is the main post-creation destination and the
primary in-session screen for the player. It presents the selected
character's core information and becomes the central navigation point for
later gameplay-support features.

## Goals

- Give the user a stable main screen after character creation or selection.
- Present core character information in a readable session-ready form.
- Establish the destination screen that later connects to dice, resources,
  inventory, spells, and editing.

## In Scope

- Read-only presentation of core character information
- Visible presentation of selected background details relevant to play
- Entry from character list and create character flow
- Refresh from local persisted data
- Navigation entry points for future related screens

## Out of Scope

- Full combat automation
- Inventory management details
- Spell management details
- Rich editing workflows

## Entry Conditions

- The user selects a character from the character list.
- The app creates a new character successfully.

## Exit Paths

- Return to character list
- Navigate to future related feature screens
- Enter edit flow when that feature exists

## Primary Actions

- Review core character information
- Navigate back to character list
- Open future related sections from the character context

## Required Data

- Character identity summary
- Selected background summary
- Background bonuses and social perks
- Final ability scores with per-ability modifiers
- Ability score generation method summary
- Core stats and derived summary fields
- Locally persisted character state for the selected record
- Optional local load error information

## UI States

- Loading: selected character data is being resolved
- Success: core character information is visible
- Empty or missing record: selected character no longer exists
- Error: local read failed and user needs a retry path

## User Flows

1. User opens a character from the character list.
2. App loads the selected character from local storage.
3. Character sheet renders the main summary of the character.
4. User reviews character information or continues to future tools.

### Post-Creation Flow

1. User creates a character successfully.
2. App routes directly to the new character sheet.
3. The user sees the created character as the active context.

## Acceptance Criteria

- The selected character can be loaded fully offline.
- The screen presents enough core information to serve as the main home for a
  selected character.
- The selected background, its bonuses, and its social perks are visible on
  the character sheet.
- The six final ability scores and their modifiers are visible on the
  character sheet.
- A missing or deleted character record is handled explicitly.
- The character sheet can serve as the hub for future in-session features.

## Architectural Notes

- The screen should consume mapped view data rather than raw persistence
  entities.
- Derived rule values should come from domain or application logic, not be
  computed ad hoc in widgets.
- This screen is the anchor for Phase 3 and later roadmap phases.
- Related roadmap phases: Phase 2 and Phase 3 in
  `docs/project/ROADMAP.md`.
