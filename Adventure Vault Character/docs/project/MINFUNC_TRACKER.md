# MinFunc Execution Tracker

## Purpose

This document is the durable execution tracker for the **MinFunc** plan: the
minimal functional offline player release where only UI polish, richer UX, and
non-blocking depth remain after completion.

Use this file to track:

- session-sized work slices,
- copy/paste prompts for local models,
- current progress and dependencies,
- explicit release-bar decisions.

Keep this document operational. Do not turn it into a second roadmap.

## Release Bar Rule

A task belongs to **MinFunc** only if at least one of these is true:

1. It removes a real blocker from the offline player session loop.
2. It fixes incorrect persistence or recovery in the minimal flow.
3. It is required to prove the minimal flow with targeted tests.

If a task only improves visual quality, comfort, discoverability, advanced
workflow depth, or optional edge-case breadth, it should stay outside this
tracker.

## Minimal Functional Release Checklist

| Capability | Required | Current Status | Notes |
| --- | --- | --- | --- |
| Create, save, reopen, edit, and continue using a character offline | Yes | To verify | Pass only if one offline character can complete `create -> save -> reopen from saved list -> open sheet -> edit -> save -> continue` with the same persisted state and no external workaround. |
| Character sheet exposes current combat MVP values | Yes | To verify | Pass only if the sheet itself exposes the already-supported combat MVP values needed for play: AC, initiative, death saves, and attack helpers when applicable. |
| Character sheet exposes current hit-point and class-resource state | Yes | To verify | Pass only if the sheet exposes the currently supported hit-point and class-resource state needed for live play without requiring a separate unfinished flow. |
| Supported spellcasters can inspect spell-state summaries during play | Yes | To verify | Pass only if supported caster classes can inspect their current spell-state summaries from the sheet during a live session. |
| Supported spellcasters can spend and restore spell slots during play | Yes | To verify | Pass only if supported caster classes can both spend and restore slots during a live session through existing app flows, and the state remains visible to the player. |
| Inventory and resource actions required for basic live play are usable | Yes | To verify | Pass only if the currently supported minimum inventory/resource actions needed for basic table use are available without a functional dead end; richer transfer UX is excluded unless proven blocking. |
| Rest flows update supported resources correctly | Yes | To verify | Pass only if short-rest and long-rest flows update the supported resources they already own in domain/application logic and the updated state is visible after the action. |
| Core mutations persist correctly after reopen | Yes | To verify | Pass only if minimum in-session mutations covered by this release bar survive save/reopen, including spell state, inventory/resource state, and rest-driven state changes. |
| Expected rejection and recoverable error states do not break the session loop | Yes | To verify | Pass only if expected mutation rejections and recoverable read/write issues surface functional feedback and do not crash or strand the primary offline session loop. |
| Targeted automated coverage exists for the release-bar flows | Yes | To verify | Pass only if targeted smoke/regression tests cover the release-bar flows above; exhaustive edge-case coverage is not required for MinFunc. |

## S1 Explicit Exclusions

The following remain outside the MinFunc release bar unless S2 proves they are
real blockers:

- visual polish, layout refinement, and micro-interactions,
- richer spell/inventory ergonomics beyond the minimum functional loop,
- advanced inventory transfer UX beyond basic live-play needs,
- broader non-critical spell edge-case breadth,
- compendium expansion beyond the implemented baseline,
- onboarding/help systems,
- backup/restore, online sync, and DM tooling.

## S1 Open Ambiguities

- `Supported spellcasters` must be verified in code against the actually
  implemented baseline classes/flows, not roadmap wording alone.
- `Basic live play` inventory/resource actions still need code-level proof in S2
  so comfort features are not mistaken for blockers.
- `Recoverable read/write interruption states` is still operationally ambiguous;
  S2 should confirm what concrete in-app states already exist and whether they
  satisfy MinFunc's minimum resilience bar.

## Session Tracker

| ID | Session | Objective | Dependencies | Status | Notes |
| --- | --- | --- | --- | --- | --- |
| S1 | Freeze release bar | Convert `MinFuncSpec` into a binary operational checklist. | — | Done | Frozen as pass/fail criteria, including HP/resource and spell-summary visibility; ambiguities logged for S2 verification. |
| S2 | Audit real gaps | Verify in code what already satisfies the release bar. | S1 | Planned | Avoid solving already-closed work. |
| S3 | Map spell-slot flow | Identify the minimal spellcasting gap from sheet to persistence. | S2 | Planned | Focus on spend/restore only. |
| S4 | Implement spend slot | Enable minimum slot spending from the sheet. | S3 | Planned | No rule logic in widgets. |
| S5 | Implement restore slot | Enable minimum slot restore from the sheet. | S4 | Planned | Close the minimum slot loop. |
| S6 | Test spell-slot release bar | Cover spend, restore, persist, and reopen for supported casters. | S5 | Planned | Keep coverage targeted. |
| S7 | Audit minimum inventory usability | Decide whether current inventory already supports real table use. | S2 | Planned | Distinguish blockers from comfort issues. |
| S8 | Implement one blocking inventory action | Add only the single inventory capability proven to block the loop. | S7 | Planned / N/A | Skip if audit says inventory is already sufficient. |
| S9 | Test minimum inventory flow | Add targeted smoke/regression coverage for basic inventory use. | S8 or S7 | Planned | Keep scope minimal. |
| S10 | Harden missing-data sheet states | Prevent breakage on optional or partial valid state. | S6, S9 | Planned | Stability, not redesign. |
| S11 | Surface mutation rejections | Keep expected failures visible and non-blocking. | S6, S9 | Planned | Functional feedback is enough. |
| S12 | Verify persistence and reopen | Confirm or fix reopen behavior for minimum session changes. | S6, S9 | Planned | Focus on spells, inventory, rests. |
| S13 | Validate full minimal loop | Re-audit the complete `MinFuncSpec` flow end-to-end. | S10, S11, S12 | Planned | Decide if MinFunc is achieved. |
| S14 | Declare post-MVP debt | Separate non-blocking UI/UX and future-depth work from release blockers. | S13 | Planned | Freeze what is out of scope. |
| S15 | Update canonical docs | Align continuity docs with real MinFunc status. | S14 | Planned | Update only source-of-truth docs. |

## Local-Model Prompts

### Shared Delegation Constraints

Apply these constraints to every delegated MinFunc session prompt:

- Use only tools explicitly available in the current session/runtime.
- Do not assume external MCP namespaces exist.
- Do not call `google:mcp:*` or any undeclared tool namespace unless it is explicitly available in the current environment.
- Prefer the session-native tools for reading, searching, and editing files; use shell only when the available toolset requires it.
- If a required tool is unavailable, stop and report the constraint instead of improvising with another namespace.
- Do not implement code unless the specific session prompt explicitly asks for implementation.

### S1 — Freeze release bar

> Review `docs/project/SESSION_RESUME.md`, `docs/project/PROJECT_SNAPSHOT.md`, `docs/project/ROADMAP.md`, and `MinFuncSpec`. Convert the spec into a binary minimal functional release checklist. Do not propose new features. Separate `required for release` from `allowed post-release debt`. Return: (1) release checklist, (2) explicit exclusions, (3) open ambiguities.

### S2 — Audit real gaps

> Use `MinFuncSpec` and the frozen checklist. Inspect only the code areas needed to determine what is already implemented and what is still missing. Verify in code instead of trusting roadmap wording. Return: (1) `met / not met / unclear` table, (2) real functional gaps, (3) smallest recommended resolution order.

### S3 — Map current spell-slot flow

> Investigate only the current spell-slot flow. Determine what already exists for viewing slots, spending slots, restoring slots, persisting changes, and reopening state. Do not modify code. Return: (1) short flow summary, (2) what already exists, (3) exact missing piece, (4) minimum files to touch.

### S4 — Implement minimum slot spending

> Implement the smallest change needed to let the player spend spell slots from the sheet using existing contracts whenever possible. Keep rule logic out of widgets. Do not expand advanced cases. Return: (1) change summary, (2) files touched, (3) what still remains for the minimum slot loop.

### S5 — Implement minimum slot restore

> Implement the smallest change needed to let the player restore spell slots from the sheet using existing rules and contracts. Keep scope limited to minimum functionality. Return: (1) change summary, (2) files touched, (3) confirmation that spend + restore now form a minimum functional loop.

### S6 — Test spell-slot release bar

> Add the minimum automated coverage for spell-slot release-bar behavior: spend, restore, persistence, and reopen. Reuse existing test patterns. Do not broaden into non-blocking edge cases. Return: (1) covered cases, (2) test files touched, (3) deliberately deferred gaps.

### S7 — Audit minimum inventory usability

> Evaluate whether the current inventory behavior is already sufficient for a real minimum table session under `MinFuncSpec`. Be strict: if it is sufficient, say so clearly; if not, identify only the single blocking capability. Do not modify code. Return: (1) `sufficient / insufficient`, (2) justification, (3) one minimum gap if any, (4) minimum affected files.

### S8 — Implement one blocking inventory action

> Implement only the single inventory action proven by the audit to block the minimum player loop. Reuse existing services, repositories, and validations. Do not add rich UX or adjacent improvements. Return: (1) action added, (2) why it was blocking, (3) files touched, (4) what remains deliberately out of scope.

### S9 — Test minimum inventory flow

> Add minimum smoke/regression coverage for the inventory behavior needed by `MinFunc`. Cover the already-existing basic session path and the single blocking action if one was added. Do not chase full exhaustiveness. Return: (1) covered cases, (2) files touched, (3) explicit coverage limits.

### S10 — Harden missing-data sheet states

> Make the minimum changes required so the sheet stays functional with missing optional fields or partial valid state. Do not redesign UI. Focus on stability and simple fallbacks. Return: (1) scenarios covered, (2) files touched, (3) what remains out of scope.

### S11 — Surface mutation rejections

> Improve only the minimum handling of expected mutation rejections or recoverable errors so the main flow is not silent or broken. Prioritize spells, inventory, and supported resources if applicable. Return: (1) visible rejection/error cases, (2) how the flow remains operable, (3) files touched.

### S12 — Verify persistence and reopen

> Verify and fix only if needed the persistence/reopen behavior for minimum session changes: spell slots, basic inventory, rests/resources, and character reopen. If something already works, do not touch it. Return: (1) what was verified, (2) any failure found, (3) fix summary if needed, (4) evidence that reopen now works.

### S13 — Validate the full minimum loop

> Audit the entire `MinFuncSpec` flow. Check whether a player can create, save, reopen, edit, use the sheet, manage combat MVP, manage minimum spells, manage basic inventory, apply rests, and continue offline without functional blockers. Return: (1) final `met / not met / unclear` table, (2) remaining blockers, (3) release verdict.

### S14 — Declare post-MVP debt

> Based on `MinFuncSpec` and the final audit, separate all remaining work into: `UI/UX debt`, `future functional depth`, `non-critical hardening`, and `future features`. Do not mix blockers with improvements. Return: (1) prioritized deferred-work list, (2) short justification per item.

### S15 — Update canonical docs

> Update the canonical project docs to reflect the real MinFunc status. Target `docs/project/SESSION_RESUME.md`, `docs/project/PROJECT_SNAPSHOT.md`, and `docs/project/ROADMAP.md` only if the real focus changed. Keep everything in English and avoid duplicate status text. Return: (1) summary of doc changes, (2) files touched, (3) next recommended step after MinFunc.

## Progress Update Rules

When completing a session:

1. Update the **Status** column in the Session Tracker.
2. Add a short note describing the outcome or blocker.
3. Update the **Current Status** column in the Minimal Functional Release
   Checklist if verification changed.
4. If the project reality changed, update `SESSION_RESUME.md` and
   `PROJECT_SNAPSHOT.md` in the same session.

Allowed status values:

- `Planned`
- `In progress`
- `Done`
- `Blocked`
- `N/A`

## Current Recommendation

Start with **S2** before writing code. The release bar is now frozen, and the
current docs still suggest the main functional gap is spell-slot in-session
control, but that must be confirmed against the code before implementation work
starts.
