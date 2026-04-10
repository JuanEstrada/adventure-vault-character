# Spec: MinFuncSpec

Scope: feature

# Minimal Functional Release Spec

## Goal
Deliver a minimally functional offline player release of Adventure Vault Character where a real table session can be completed without functional blockers. Remaining post-release work may include UI polish, richer ergonomics, visual consistency, deeper edge-case handling, and non-essential workflow convenience.

## In Scope

### 1. Core offline player loop must work end-to-end
The app must support this loop without requiring external tools or unfinished flows:
- create character
- save character
- reopen character from saved list
- open character sheet
- edit and save again
- continue using the same persisted state offline

### 2. Core in-session sheet usage must be functionally complete
From the sheet, the player must be able to:
- inspect current combat baseline values already in MVP scope (such as AC, initiative, death saves, and available attack helpers when applicable)
- inspect current hit-point and class-resource state already supported by the app
- inspect spell-state summaries for supported caster classes
- spend and restore spell slots for supported caster classes using existing rule/application contracts
- perform currently supported inventory/resource mutations needed for basic live play
- apply short-rest and long-rest recovery flows already supported by the domain/application layers

### 3. Persistence and reopen behavior must remain correct
State changes made during play must survive:
- save/reopen
- app restart assumptions within the existing offline-first model
- transitions between create, edit, and sheet flows

### 4. Minimal resilience must exist
The app must not break the core session flow when encountering:
- missing optional data
- partial but valid persisted state
- expected mutation rejection cases
- recoverable read/write interruption states that can be surfaced to the user

The minimal requirement is clear functional feedback and continued operability, not polished recovery UX.

## Explicitly Out of Scope
The following are intentionally NOT required for the minimal functional release unless they are proven to block the core session loop:
- visual polish or final UI system
- richer layout refinement and micro-interactions
- advanced inventory transfer UX beyond what is strictly needed for basic live play
- broad completion of non-critical spell edge cases outside supported baseline classes/flows
- deeper compendium-management expansion beyond the already implemented baseline
- onboarding/help systems
- backup/restore
- online sync or DM tooling

## Release Bar Checklist
A minimal functional release is achieved when all items below are true:

1. A player can create, save, reopen, edit, and continue using a character offline.
2. The character sheet exposes the currently supported combat MVP values without requiring unfinished screens.
3. For supported spellcasters, spell-slot spend and restore actions are possible during a session.
4. Inventory/resource actions required for basic session play are possible without functional dead ends.
5. Rest flows update supported resources correctly and remain visible to the player.
6. Core mutations persist correctly after reopen.
7. Expected rejection/error states do not crash or block the primary session flow.
8. Automated coverage exists for the release-bar flows at least at targeted regression/smoke level.

## Acceptance Guidance
A change belongs in this plan only if at least one of the following is true:
- it removes a real blocker from the offline player session loop
- it fixes incorrect persistence/recovery in the minimal flow
- it is required to prove the minimal flow with tests

If a task only improves clarity, comfort, discoverability, visual quality, or optional depth, it should be deferred outside this plan.

## Session Slicing Guidance
Implementation sessions for this plan should be small enough for local models:
- one narrow functional gap per session
- one subsystem at a time (spells, inventory, resilience, tests, docs)
- avoid mixed domain + broad UI + docs sessions
- prefer verification sessions that confirm no work is needed before adding new code