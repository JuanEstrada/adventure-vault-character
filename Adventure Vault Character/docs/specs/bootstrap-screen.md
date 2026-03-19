# Bootstrap Screen Specification

## Status

Draft

## Summary

The bootstrap screen is the first route shown when the app launches. Its job
is to initialize local application services, verify that the local persistence
layer is available, and decide the next route without exposing startup
complexity to the user.

## Goals

- Provide a deterministic startup path for every app launch.
- Initialize only the dependencies required to reach the first usable screen.
- Route the user to the correct next screen based on local app state.
- Surface recoverable startup failures clearly.

## In Scope

- First visual route displayed at app launch
- Initialization of app-level dependencies required for local use
- Local database availability check
- Initial route decision
- Loading and startup error states

## Out of Scope

- Full onboarding content
- Character creation form logic
- Character list interaction details
- Remote networking or account checks

## Entry Conditions

- The user launches the app from a terminated state.
- The user returns to the app after process recreation by the OS.

## Exit Paths

- Navigate to the character list when character data exists.
- Navigate to the empty-state screen when no characters exist.
- Navigate to a startup recovery state when initialization fails.

## Primary Actions

- Wait while initialization completes
- Retry initialization after a recoverable failure

## Required Data

- Result of local storage initialization
- Whether at least one character exists locally
- Optional startup error information

## UI States

- Loading: app branding plus startup progress indication
- Success with existing data: immediate navigation to character list
- Success with no data: immediate navigation to empty-state screen
- Error: failure message plus retry action

## User Flows

1. User opens the app.
2. Bootstrap screen appears immediately.
3. App initializes local dependencies and local persistence.
4. App checks whether local character records exist.
5. App routes to character list or empty-state screen.

### Error Recovery Flow

1. Initialization fails.
2. Bootstrap screen shows a recovery message.
3. User chooses retry.
4. App reruns startup initialization.

## Acceptance Criteria

- The bootstrap screen is always the first route on cold start.
- The app never shows a blank screen while startup work is happening.
- Startup completes without requiring network access.
- A user with existing characters is routed to the character list.
- A user with no characters is routed to the empty-state screen.
- Recoverable startup failures present a retry option.

## Architectural Notes

- Must align with offline-first behavior from `ADR-002`.
- Must prepare for Drift-backed local persistence from `ADR-007`.
- Should keep startup orchestration outside the widget presentation layer.
- Related roadmap phases: Phase 0 and Phase 1 in
  `docs/project/ROADMAP.md`.
