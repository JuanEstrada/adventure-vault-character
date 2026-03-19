# Empty State Screen Specification

## Status

Draft

## Summary

The empty-state screen is shown when the app has no locally stored characters.
Its job is to explain the current situation, reduce ambiguity for first-time
users, and drive the user toward creating the first character.

## Goals

- Make the no-data state understandable and intentional.
- Provide a single clear next step for new users.
- Prevent the app from feeling broken when local storage is empty.

## In Scope

- First-run or no-character explanatory UI
- Primary create-character call to action
- Optional secondary explanatory copy for offline-first behavior
- Navigation into the create character flow

## Out of Scope

- Multi-step onboarding tutorial
- Rules education content
- Import flow details
- Advanced account setup or sync messaging

## Entry Conditions

- Bootstrap determines that no local character records exist.
- Character list resolves to zero stored characters.

## Exit Paths

- Navigate to create character flow
- Return to bootstrap only if the app restarts

## Primary Actions

- Start character creation

## Required Data

- Confirmation that the local character set is empty
- Optional first-run or introductory copy

## UI States

- Default empty state: explanation plus create action
- Error-adjacent empty state: only if the app must distinguish empty data from
  failed initialization

## User Flows

1. User opens the app with no stored characters.
2. Bootstrap routes to the empty-state screen.
3. The screen explains that no characters exist yet.
4. The user taps the create action.
5. The app navigates to the character creation flow.

## Acceptance Criteria

- The screen clearly communicates that no characters exist yet.
- The primary call to action is to create a character.
- The create action is visible without additional navigation.
- The screen works fully offline.
- The empty state is distinct from startup failure and data-load failure.

## Architectural Notes

- This screen is part of the initial route decision defined by the bootstrap
  flow.
- The empty state should remain a navigation destination, not just an inline
  fallback, so startup behavior stays explicit.
- Related roadmap phases: Phase 0 and Phase 1 in
  `docs/project/ROADMAP.md`.
