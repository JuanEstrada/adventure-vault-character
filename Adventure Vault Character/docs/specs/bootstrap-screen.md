# Bootstrap Screen Specification

## Status

Draft

## Summary

The bootstrap screen is the first route shown when the app launches. It acts
as the splash screen for the MVP, performs the minimum startup work required
for local use, and only exits once initialization is complete and the minimum
display duration has elapsed.

## Goals

- Provide a deterministic startup path for every app launch.
- Initialize only the dependencies required to reach the first usable screen.
- Route the user to the access screen after startup completes.
- Surface recoverable startup failures clearly.

## In Scope

- First visual route displayed at app launch
- Initialization of app-level dependencies required for local use
- Local database availability check
- Local character summary preload
- XML index preload without loading full content
- Splash minimum-duration rule
- Loading and startup error states

## Out of Scope

- Full onboarding content
- Character creation flow
- Main menu interaction details
- Remote networking or account checks

## Entry Conditions

- The user launches the app from a terminated state.
- The user returns to the app after process recreation by the OS.

## Exit Paths

- Navigate to the access screen when startup succeeds.
- Navigate to a startup recovery state when initialization fails.

## Primary Actions

- Wait while initialization completes
- Retry initialization after a recoverable failure

## Required Data

- Result of local storage initialization
- Preloaded local character summaries
- XML content index metadata
- Optional startup error information

## UI States

- Loading: app branding plus startup progress indication
- Success: navigate to the access screen after startup completes
- Error: failure message plus retry action

## User Flows

1. User opens the app.
2. Bootstrap screen appears immediately.
3. App loads local configuration.
4. App loads saved character summaries.
5. App loads the XML content index, but not full content payloads.
6. The splash remains visible for at least 2 seconds.
7. If startup takes longer than 2 seconds, the splash remains visible until
   work completes.
8. App routes to the access screen.

### Error Recovery Flow

1. Initialization fails.
2. Bootstrap screen shows a recovery message.
3. User chooses retry.
4. App reruns startup initialization.

## Acceptance Criteria

- The bootstrap screen is always the first route on cold start.
- The app never shows a blank screen while startup work is happening.
- Startup completes without requiring network access.
- The splash stays visible for at least 2 seconds.
- The splash stays visible longer if startup work has not finished yet.
- Startup success always routes to the access screen.
- Recoverable startup failures present a retry option.

## Architectural Notes

- Must align with offline-first behavior from `ADR-002`.
- Must prepare for Drift-backed local persistence from `ADR-007`.
- Should keep startup orchestration outside the widget presentation layer.
- Related roadmap phases: Phase 0 and Phase 1 in
  `docs/project/ROADMAP.md`.
