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
| Create, save, reopen, edit, and continue using a character offline | Yes | Met | Verified by widget coverage for `create -> save -> open sheet -> edit -> save -> reopen`, backed by summary/sheet watch flows. |
| Character sheet exposes current combat MVP values | Yes | Met | `character_sheet_screen.dart` exposes HP, AC, initiative, attacks, and death-save controls directly from the sheet. |
| Character sheet exposes current hit-point and class-resource state | Yes | Met | Sheet exposes HP facts and class-resource controls/state; repository + controller support persisted manual adjustment. |
| Supported spellcasters can inspect spell-state summaries during play | Yes | Met | Sheet exposes spellcasting facts, selected/available spells, and slot summaries for supported casters. |
|| Supported spellcasters can spend and restore spell slots during play | Yes | Met | Spend + restore now complete end-to-end from the sheet UI with full persistence and reopen support. |
| Inventory and resource actions required for basic live play are usable | Yes | Met | Inventory quantity, charges, carry/equip, and container assignment flows are implemented with deterministic validation and persistence. |
| Rest flows update supported resources correctly | Yes | Met | Recovery service updates HP, slot usage, class resources, death saves, and tracked charges; repository tests verify persisted results. |
|| Core mutations persist correctly after reopen | Yes | Met | Spell-slot spend/restore mutations now persist and reopen correctly; inventory and rest mutations already persisted. |
| Expected rejection and recoverable error states do not break the session loop | Yes | Unclear | Inventory rejection feedback is implemented, and several missing-data defaults exist in mapping, but recoverable read/write interruption coverage is not yet proven end-to-end. |
|| Targeted automated coverage exists for the release-bar flows | Yes | Met | Coverage exists for create/edit/reopen, rests, combat, inventory, and spell-slot spend/restore with widget tests proving persistence and reopen. |

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
| S2 | Audit real gaps | Verify in code what already satisfies the release bar. | S1 | Done | Audit confirms the only hard functional blocker is direct in-session spell-slot spend/restore; inventory is already sufficient for minimum live play. |
| S3 | Audit sheet slot view path | Confirm how the sheet currently reads and renders spell-slot state. | S2 | Done | Verified the sheet reads derived slot progression plus persisted usage overlays and exposes read-only slot summaries/progress. |
| S4 | Audit slot mutation path | Confirm what already exists for spend/restore mutation and persistence. | S3 | Done | Confirmed slot usage persists through create/edit and rest flows, reopens correctly, and lacks any direct in-session spend/restore mutation contract. |
| S5 | Freeze minimum slot gap | State the exact missing piece and minimum files to touch. | S4 | Done | Frozen gap: add explicit repository/application spend + restore spell-slot mutations with Drift and in-memory parity before any UI wiring. |
| S6A | Add spend repository contract | Add explicit spend-slot repository and application contract signatures only. | S5 | Done | Added `spendSpellSlot(id, {required spellLevel})` to repository/application surfaces with placeholders only; behavior stays pending for `S6B`/`S6C`. |
| S6B | Persist spend in Drift | Implement the spend-slot mutation path in Drift/application/DAO layers. | S6A | Done | Drift path now validates character/slot availability, persists expended-slot increments, and rejects overspend behind `spendSpellSlot(...)`. |
| S6C1 | Add in-memory spend behavior | Implement `spendSpellSlot(...)` behavior in `InMemoryCharacterRepository`. | S6B | Done | In-memory spend path now validates character/slot availability, treats missing usage rows as zero, and rejects overspend to match Drift semantics. |
| S6C2 | Add spend parity tests | Add minimum non-widget tests proving in-memory spend-path parity. | S6C1 | Done | Added in-memory spend tests for zero-row increment and overspend rejection without state change. |
| S6C3 | Close spend parity slice | Verify docs/tracker state for spend-path parity and capture any deferred gaps before UI. | S6C2 | Done | Spend-slot mutation parity is closed for Drift + in-memory non-UI paths; next gap is exposing spend from the sheet and later restore symmetry. |
| S7 | Expose spend from sheet | Wire the existing spend contract into the character sheet UI. | S6C3 | Done | Added minimal spell-slot `Spend 1` controls in the sheet and routed them through the controller without widget-side rules logic. |
| S8 | Test spend persistence | Add targeted coverage for spend + persist + reopen. | S7 | Done | Added widget coverage proving sheet spend persists in state and remains visible after navigating back and reopening the character. |
| S9A | Add restore contract flow | Add explicit restore-slot repository/application/controller contract signatures only. | S8 | Done | Added `restoreSpellSlot(id, {required spellLevel})` to repository/controller/application surfaces with placeholders only; behavior stays pending for `S9B`/`S9C`. |
| S9B | Implement restore mutation behavior | Implement the minimum non-widget restore-slot behavior in persistence layers. | S9A | Done | Implemented in `CharacterRecoveryService.restoreSpellSlot(...)` with spend-parity validation and below-zero rejection. |
| S9C | Close restore non-UI slice | Verify parity/docs state for the restore mutation path before UI work. | S9B | Done | Non-UI restore slice closed; next step is sheet wiring only (`S10`). |
|| S10 | Expose restore from sheet | Wire the existing restore contract into the character sheet UI. | S9C | Done | Added "Restore" button in spell-slot panel (lines 1009-1020), routed through controller → repository → recovery service. Spend + restore now form a complete minimum functional loop. |
| S11 | Test restore persistence | Add targeted coverage for restore + persist + reopen. | S10 | Planned | Restore only. |
|| S12 | Audit minimum inventory usability | Decide whether current inventory already supports real table use. | S2 | Done | Audit confirmed the existing inventory flow is already sufficient for MinFunc; no code changes were needed. |
| S13 | Implement one blocking inventory action | Add only the single inventory capability proven to block the loop. | S12 | Planned / N/A | Skip if audit says inventory is already sufficient. |
|| S14 | Test minimum inventory flow | Add targeted smoke/regression coverage for the inventory path needed by MinFunc. | S13 or S12 | Done | Existing inventory regression/smoke coverage already proves the minimum flow; no new tests were needed. |
| S15 | Harden missing-data sheet states | Prevent breakage on optional or partial valid state. | S11, S14 | Planned | Stability, not redesign. |
| S16 | Surface mutation rejections | Keep expected failures visible and non-blocking. | S11, S14 | Planned | Functional feedback is enough. |
| S17 | Verify persistence and reopen | Confirm or fix reopen behavior for minimum session changes. | S15, S16 | Planned | Focus on spells, inventory, rests. |
| S18 | Validate full minimal loop | Re-audit the complete `MinFuncSpec` flow end-to-end. | S17 | Planned | Decide if MinFunc is achieved. |
| S19 | Declare post-MVP debt | Separate non-blocking UI/UX and future-depth work from release blockers. | S18 | Planned | Freeze what is out of scope. |
| S20 | Update canonical docs | Align continuity docs with real MinFunc status. | S19 | Planned | Update only source-of-truth docs. |

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

### S3 — Audit sheet slot view path

> Inspect only how the character sheet currently reads and renders spell-slot state. Do not inspect mutation code yet and do not modify anything. Return: (1) short view-path summary, (2) files involved, (3) what is already exposed on the sheet.

### S4 — Audit slot mutation path

> Inspect only the existing mutation and persistence path related to spell slots. Determine what already exists for spend, restore, save, and reopen. Do not modify code. Return: (1) mutation-path summary, (2) what already exists, (3) confirmed gaps.

### S5 — Freeze minimum slot gap

> Based on the previous two audit sessions, define the exact minimum spell-slot gap and the smallest fileset needed to close it. Do not modify code. Return: (1) short flow summary, (2) what already exists, (3) exact missing piece, (4) minimum files to touch.

### S6A — Add spend repository contract

> Add only the explicit repository/application contract signatures needed to spend a spell slot. Freeze method naming, parameters, and validation entry point. Do not implement Drift writes, in-memory behavior, tests, or UI yet. Return: (1) contract summary, (2) files touched, (3) next implementation step.

### S6B — Persist spend in Drift

> Implement the spend-slot mutation path in the Drift/application/DAO layers using the frozen contract. Validate character existence, valid spell level, and derived slot maximums. Do not wire UI and do not implement restore yet. Return: (1) Drift-path summary, (2) files touched, (3) remaining parity/test work.

### S6C1 — Add in-memory spend behavior

> Implement only the `spendSpellSlot(...)` behavior in `InMemoryCharacterRepository` to match Drift semantics: character must exist, slot level must be valid, missing usage rows behave as zero, and overspend is rejected. Do not add tests or UI yet. Return: (1) behavior summary, (2) files touched, (3) next parity step.

### S6C2 — Add spend parity tests

> Add the minimum non-widget tests needed to prove in-memory spend-path parity with the Drift behavior. Keep scope to spend only and do not wire UI. Return: (1) coverage summary, (2) files touched, (3) exact remaining closeout step.

### S6C3 — Close spend parity slice

> Close the spend-parity slice by updating the tracker/docs for the verified in-memory spend path, recording any unresolved bug, missing capability, or deferred improvement before UI work. Do not implement UI or restore behavior. Return: (1) closeout summary, (2) files touched, (3) next UI step.

### S7 — Expose spend from sheet

> Wire the existing spend-slot contract into the character sheet with the smallest possible UI change. Keep widgets thin and reuse existing patterns. Return: (1) change summary, (2) files touched, (3) confirmation of what is still missing before the minimum slot loop is complete.

### S8 — Test spend persistence

> Add the minimum automated coverage for spell-slot spending only: spend action, persistence, and reopen. Reuse existing test patterns. Do not cover restore yet. Return: (1) covered cases, (2) test files touched, (3) deliberately deferred gaps.

### S9A — Add restore contract flow

> Add only the explicit repository/application/controller contract signatures needed to restore a spell slot. Freeze method naming, parameters, and validation entry point. Do not implement Drift writes, in-memory behavior, tests, or UI yet. Return: (1) contract summary, (2) files touched, (3) next implementation step.

### S9B — Implement restore mutation behavior

> Implement the minimum non-widget restore-slot mutation behavior using the frozen contract. Mirror spend-path validation, keep rules logic in the existing service/repository layers, and reject restore below zero usage. Do not wire UI yet. Return: (1) change summary, (2) files touched, (3) exact closeout step that remains.

### S9C — Close restore non-UI slice

> Close the restore non-UI slice by verifying tracker/docs state, recording any unresolved bug, missing capability, or deferred improvement, and leaving the next recommended step as the sheet UI wiring. Do not implement UI or broaden into extra edge cases. Return: (1) closeout summary, (2) files touched, (3) next UI step.

### S10 — Expose restore from sheet

> Wire the existing restore-slot contract into the character sheet with the smallest possible UI change. Keep widgets thin and reuse existing patterns. Return: (1) change summary, (2) files touched, (3) confirmation that spend + restore now form a minimum functional loop.

### S11 — Test restore persistence

> Add the minimum automated coverage for spell-slot restore only: restore action, persistence, and reopen. Reuse existing test patterns. Do not broaden into non-blocking edge cases. Return: (1) covered cases, (2) test files touched, (3) deliberately deferred gaps.

### S12 — Audit minimum inventory usability

> Evaluate whether the current inventory behavior is already sufficient for a real minimum table session under `MinFuncSpec`. Be strict: if it is sufficient, say so clearly; if not, identify only the single blocking capability. Do not modify code. Return: (1) `sufficient / insufficient`, (2) justification, (3) one minimum gap if any, (4) minimum affected files.

### S13 — Implement one blocking inventory action

> Implement only the single inventory action proven by the audit to block the minimum player loop. Reuse existing services, repositories, and validations. Do not add rich UX or adjacent improvements. Return: (1) action added, (2) why it was blocking, (3) files touched, (4) what remains deliberately out of scope.

### S14 — Test minimum inventory flow

> Add minimum smoke/regression coverage for the inventory behavior needed by `MinFunc`. Cover the already-existing basic session path and the single blocking action if one was added. Do not chase full exhaustiveness. Return: (1) covered cases, (2) files touched, (3) explicit coverage limits.

### S15 — Harden missing-data sheet states

> Make the minimum changes required so the sheet stays functional with missing optional fields or partial valid state. Do not redesign UI. Focus on stability and simple fallbacks. Return: (1) scenarios covered, (2) files touched, (3) what remains out of scope.

### S16 — Surface mutation rejections

> Improve only the minimum handling of expected mutation rejections or recoverable errors so the main flow is not silent or broken. Prioritize spells, inventory, and supported resources if applicable. Return: (1) visible rejection/error cases, (2) how the flow remains operable, (3) files touched.

### S17 — Verify persistence and reopen

> Verify and fix only if needed the persistence/reopen behavior for minimum session changes: spell slots, basic inventory, rests/resources, and character reopen. If something already works, do not touch it. Return: (1) what was verified, (2) any failure found, (3) fix summary if needed, (4) evidence that reopen now works.

### S18 — Validate the full minimum loop

> Audit the entire `MinFuncSpec` flow. Check whether a player can create, save, reopen, edit, use the sheet, manage combat MVP, manage minimum spells, manage basic inventory, apply rests, and continue offline without functional blockers. Return: (1) final `met / not met / unclear` table, (2) remaining blockers, (3) release verdict.

### S19 — Declare post-MVP debt

> Based on `MinFuncSpec` and the final audit, separate all remaining work into: `UI/UX debt`, `future functional depth`, `non-critical hardening`, and `future features`. Do not mix blockers with improvements. Return: (1) prioritized deferred-work list, (2) short justification per item.

### S20 — Update canonical docs

> Update the canonical project docs to reflect the real MinFunc status. Target `docs/project/SESSION_RESUME.md`, `docs/project/PROJECT_SNAPSHOT.md`, and `docs/project/ROADMAP.md` only if the real focus changed. Keep everything in English and avoid duplicate status text. Return: (1) summary of doc changes, (2) files touched, (3) next recommended step after MinFunc.

## Progress Update Rules

When completing a session:

1. Update the **Status** column in the Session Tracker.
2. Add a short note describing the outcome or blocker.
3. Update the **Current Status** column in the Minimal Functional Release
   Checklist if verification changed.
4. If the project reality changed, update `SESSION_RESUME.md` and
   `PROJECT_SNAPSHOT.md` in the same session.
5. If you discover an unresolved bug, missing capability, or intentionally
   deferred improvement, add it to this session roadmap/tracker before closing
   the session.
6. Close the session explicitly: summarize the result, state the single next
   recommended session ID/instruction, and then stop.
7. After that closure, wait for a new session to begin before doing any further
   MinFunc work.

Allowed status values:

- `Planned`
- `In progress`
- `Done`
- `Blocked`
- `N/A`

## Session Closure Rule

Every MinFunc session is self-contained.

At the end of each session, always:

1. perform the session-specific closeout updates,
2. provide the next single recommended session instruction,
3. stop and wait for the next session kickoff.

Do not chain multiple MinFunc sessions in one continuous run, even if the next
step is obvious.

## Current Recommendation

Proceed to **S11**. Add restore persistence coverage next; S12 is complete and
S14 already has enough inventory coverage for MinFunc.
