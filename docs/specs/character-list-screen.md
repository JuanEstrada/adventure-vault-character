# Character List Screen Specification

## Status

Draft

## Summary

The character list screen is the first durable home screen for returning
players. It presents locally stored characters, lets the player choose one to
open, and provides a clear entry point into character creation.

## Goals

- Give returning users a fast path to their existing characters.
- Establish the primary navigation hub for the early app.
- Keep list interactions simple, local, and offline-first.

## In Scope

- Display of locally stored characters
- Entry point to create a new character
- Entry point to open an existing character
- Empty-list transition handling
- Basic loading and error representation for local reads

## Out of Scope

- Full character editing
- Character deletion flows
- Search, filtering, or sorting beyond simple defaults
- Cloud sync or remote account state

## Entry Conditions

- Bootstrap routing determines that local character records exist.
- The user returns from a character detail or creation flow.

## Exit Paths

- Navigate to character detail or character sheet
- Navigate to create character flow
- Return to bootstrap only if the app restarts

## Primary Actions

- Open a character
- Create a character
- Refresh the local list if needed

## Required Data

- Local list of character summaries
- Minimal character metadata for list display
- Optional local read error information

## UI States

- Loading: local character summaries are being read
- Populated: one or more characters available
- Empty: redirect or hand off to the empty-state screen
- Error: failed local read with retry action

## User Flows

1. Bootstrap routes the user to the character list.
2. The app loads local character summaries.
3. The user sees available characters.
4. The user selects a character and opens its main screen.

### Creation Entry Flow

1. User opens the character list.
2. User taps the create action.
3. App navigates to the create character flow.

## Acceptance Criteria

- The screen can render a local list of character summaries without network
  access.
- Each list item exposes a clear action to open the selected character.
- A visible create-character action exists on the screen.
- If the local data source becomes empty, the app can transition to the
  empty-state experience.
- Local read failures are visible and retryable.

## Architectural Notes

- The screen must consume view state without embedding domain rules in the UI.
- Character summaries should come from an application boundary over local
  persistence, not directly from widget code.
- Related architecture areas: Flutter UI layer, Navigation Coordinator,
  Screen State Controllers, Character Manager.
- Related roadmap phases: Phase 1 and Phase 2 in
  `docs/project/ROADMAP.md`.
