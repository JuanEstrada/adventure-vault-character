# Access Screen Specification

## Status

Draft

## Summary

The access screen is shown immediately after the splash or bootstrap flow. It
acts as an intermediate entry point that presents a future-facing online login
placeholder while preserving the supported MVP path: local offline access.

## Goals

- Provide a stable post-splash entry screen.
- Reserve visible space for future online login behavior.
- Keep the MVP fully usable through a clear offline continuation path.

## In Scope

- Dummy online login fields or controls
- A visible `Continue offline` action
- Navigation from access screen to the main menu

## Out of Scope

- Real remote authentication
- Account creation
- Password recovery
- Network-dependent login validation

## Entry Conditions

- Splash or bootstrap initialization completes successfully.

## Exit Paths

- Continue offline to the main menu
- Future online login behavior, once specified in a later version

## Primary Actions

- View online login placeholder
- Choose `Continue offline`

## Required Data

- None beyond successful completion of startup initialization

## UI States

- Default: online login placeholder plus offline continuation action
- Future online states are intentionally deferred

## Acceptance Criteria

- The screen appears after splash for the MVP startup path.
- A visible `Continue offline` action is always present.
- Offline continuation does not require network access.
- The online login area is clearly a placeholder and does not block MVP use.

## Architectural Notes

- This screen preserves the offline-first rules from `ADR-002`.
- Real online login belongs to a future spec, not the current MVP.
- Related roadmap phases: Phase 0 and Phase 1 in
  `docs/project/ROADMAP.md`.
