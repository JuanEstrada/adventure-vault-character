# Create Character Screen Specification

## Status

Draft

## Summary

The create character screen is the first content-creation flow in the app. It
must let the user create a minimally valid character record that can be stored
locally and opened immediately in the character sheet flow.

## Goals

- Give first-time users a direct path from empty state to usable character.
- Define the minimum required data for a valid initial character record.
- Establish save and cancel behavior for future editing flows.

## In Scope

- Character creation entry flow
- Minimum initial form fields
- Validation for required data
- Save and cancel actions
- Navigation to the created character after success

## Out of Scope

- Full advanced character builder logic
- Detailed rules automation for every field
- Import-driven character creation
- Multi-step onboarding guidance beyond the essentials

## Entry Conditions

- The user selects create character from the empty-state screen.
- The user selects create character from the character list screen.

## Exit Paths

- Save successfully and navigate to the character sheet
- Cancel and return to the previous route

## Primary Actions

- Enter core character identity data
- Confirm creation
- Cancel creation

## Required Data

- Character name
- Minimum identity or rules baseline required for a valid record
- Validation state for required fields

## UI States

- Ready: empty or partially completed form
- Validation error: missing or invalid required fields
- Saving: local persistence write in progress
- Success: character created and navigation continues to character sheet
- Save error: local persistence failure with retry path

## User Flows

1. User enters the create character flow.
2. App shows the minimum required fields for initial character creation.
3. User fills the required data.
4. User saves the character.
5. App stores the record locally.
6. App navigates to the created character sheet.

### Cancel Flow

1. User enters the create character flow.
2. User decides not to continue.
3. User cancels.
4. App returns to the previous route without creating a record.

## Acceptance Criteria

- A valid character can be created fully offline.
- Required fields are clearly identified.
- Invalid submissions are blocked with visible feedback.
- Successful creation persists locally and opens the character sheet.
- Canceling does not create a partial persisted character unless explicitly
  designed later.

## Architectural Notes

- Creation rules should be owned by application or domain boundaries, not
  widgets.
- Persistence must align with the local Drift-backed model from `ADR-007`.
- This flow becomes the basis for later edit-character behavior.
- Related roadmap phases: Phase 1 and Phase 2 in
  `docs/project/ROADMAP.md`.
