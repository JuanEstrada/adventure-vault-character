# P2 Executable Briefs

> **For Hermes:** Execute one microtask at a time. Do not expand scope across cards. Keep docs and tracker updates aligned with the active card only after implementation/validation passes.

**Goal:** Turn the remaining P2 inventory chain into execution-ready microtask briefs that a worker can take without inventing scope.

**Architecture:** The remaining work stays inside the existing Flutter feature-first flow: `presentation -> app controller -> repository/service -> domain validation`. Inventory rules must stay out of widgets. UI cards should reuse the existing inventory actions and dialog patterns already present in the character sheet and tests.

**Tech Stack:** Flutter, Dart, existing widget tests, `AppController`, `CharacterRepository`, `CharacterInventoryService`, in-memory repository tests.

## Canonical active P2 task names

Use these exact names across docs, kanban, and handoff notes:

1. `P2-08c — Hook delete-container action to the real mutation path`
2. `P2-09 — Add/repair widget tests for container management`
3. `P2-10a — Normalize where inventory actions appear in the sheet`
4. `P2-10b — Normalize labels and affordances for inventory actions`
5. `P2-10c — Normalize disabled and error states for inventory actions`
6. `P2-11a — Add transfer end-to-end regression coverage`
7. `P2-11b — Add container CRUD end-to-end regression coverage`
8. `P2-11c — Add reopen/persistence regression coverage for inventory actions`
9. `P2-12a — Reconcile roadmap/snapshot/resume/tracker after inventory closeout`
10. `P2-12b — Declare current player-app scope complete`

---

## Shared execution rules for every P2 card

- Work only on the named card.
- Reuse the existing mutation and refresh patterns already used by transfer/add-container.
- Keep rules logic in repository/service/domain layers, not widgets.
- Prefer adding or repairing targeted tests before broad refactors.
- If a card changes project-state facts, update:
  - `docs/project/POST_MVP_P1_TRACKER.md`
  - `docs/project/SESSION_RESUME.md`
  - `docs/project/PROJECT_SNAPSHOT.md`
- Required validation after code changes:
  - `dart format .`
  - `flutter analyze`
  - `flutter test`

---

## P2-08c — Hook delete-container action to the real mutation path

**Depends on:** P2-08b

**Objective:** Make the delete action in `ContainerManagementDialog` call the real container-removal flow and refresh the selected character sheet, while preserving existing validation/invariants.

**Grounded touchpoints:**
- `lib/src/features/characters/presentation/character_sheet_screen.dart`
  - `_openContainerManagementDialog()` currently wires `onDelete: (containerId) async {}`.
- `lib/src/features/characters/presentation/container_management_dialog.dart`
  - `_deleteContainer(...)` already shows the confirmation dialog and calls `widget.onDelete(containerId)`.
- `lib/src/app/adventure_vault_app.dart`
  - currently injects `onCreateContainer` and `onTransferToContainer`; likely needs a new delete callback once the controller supports it.
- `lib/src/app/app_controller.dart`
  - has `createContainer(...)` and transfer refresh patterns to mirror.
- `lib/src/features/characters/data/character_repository.dart`
  - currently exposes `createContainer(...)`; likely needs a delete/remove contract if one does not yet exist.
- Possible implementation layers:
  - `lib/src/features/characters/data/drift_character_repository.dart`
  - `lib/src/features/characters/data/in_memory_character_repository.dart`
  - `lib/src/features/characters/application/character_inventory_service.dart`

**Execution brief:**
1. Confirm whether a real delete/remove-container mutation already exists below the UI.
2. If missing, add the smallest repository/service/controller contract needed for delete only.
3. Wire `CharacterSheetScreen` delete callback through the controller path.
4. Reuse the same post-success refresh pattern used by `createContainer(...)` and transfer.
5. Preserve validation behavior for invalid deletes (for example, deleting a container that still violates invariants if such rules exist).

**Out of scope:**
- Rename flow
- Broader inventory action layout cleanup
- New dialog UX beyond what delete needs

**Validation target:**
- Delete button reaches the real mutation path.
- Visible sheet state refreshes after success.
- Expected invalid delete path surfaces an error instead of silently mutating.

**Recommended tests:**
- `test/src/features/characters/container_management_dialog_test.dart`
- `test/src/features/characters/character_sheet_add_container_test.dart` or a sibling delete-specific sheet test
- `test/app_controller_test.dart` for controller refresh/error behavior

**Done when:**
- The placeholder delete callback is gone.
- The selected sheet reflects container removal immediately after success.
- Tests prove the flow through UI/controller/repository boundaries.

---

## P2-09 — Add/repair widget tests for container management

**Depends on:** P2-08c

**Objective:** Add stable widget coverage for add, delete, cancel, and error behavior in the container-management flow.

**Grounded touchpoints:**
- `test/src/features/characters/container_management_dialog_test.dart`
  - currently covers focus and add-name forwarding only.
- `test/character_sheet_container_management_test.dart`
  - currently covers opening the dialog only.
- `test/src/features/characters/character_sheet_add_container_test.dart`
  - already proves add-container wiring through the real path.
- `lib/src/features/characters/presentation/container_management_dialog.dart`
  - current delete confirmation behavior is already present and should be exercised.

**Execution brief:**
1. Keep the dialog-level tests focused on widget behavior only.
2. Cover delete confirmation open/cancel/confirm behavior.
3. Cover add failure behavior if the real delete/add flow now surfaces an error or returns an empty ID.
4. Add or repair sheet-level widget coverage only where the dialog-level tests are insufficient.

**Out of scope:**
- Repository parity tests
- Full reopen/persistence regressions
- Inventory action layout refactors

**Validation target:**
- Dialog tests pass without relying on unrelated app state.
- Sheet-level entry-point coverage remains green.

**Recommended tests:**
- Expand `test/src/features/characters/container_management_dialog_test.dart`
- Add a delete-specific sheet test near `test/src/features/characters/character_sheet_add_container_test.dart`

**Done when:**
- Add, delete-confirm, delete-cancel, and failure/guard behavior are covered by widget tests.
- Tests fail on regressions in dialog wiring, not only on rendering.

---

## P2-10a — Normalize where inventory actions appear in the sheet

**Depends on:** P2-09

**Objective:** Make merge, split, transfer, and manage-container actions appear in a coherent, discoverable place in the sheet UI.

**Grounded touchpoints:**
- `lib/src/features/characters/presentation/character_sheet_screen.dart`
  - `_EquipmentPanel`
  - `_InventoryItemRow`
  - manage-containers button near the equipment panel header
  - stack action buttons currently rendered for non-container items with quantity > 1
- Existing action dialogs already live in:
  - `merge_stack_dialog.dart`
  - `split_stack_dialog.dart`
  - `transfer_to_container_dialog.dart`
  - `container_management_dialog.dart`

**Execution brief:**
1. Audit the current action locations in `_EquipmentPanel` and `_InventoryItemRow`.
2. Move only enough UI structure to make the action placement coherent.
3. Keep existing callbacks and semantics intact while adjusting placement.
4. Prefer re-grouping existing controls over inventing new flows.

**Out of scope:**
- Final wording polish
- Disabled-state normalization
- New actions not already in scope

**Validation target:**
- A user can predict where stack and container actions live.
- Existing dialog entry points still work after repositioning.

**Recommended tests:**
- Existing sheet widget tests that open/manage/transfer dialogs
- Add one focused widget assertion if placement changes break discoverability

**Done when:**
- Inventory actions are grouped consistently.
- No action is hidden in an unrelated area of the sheet.
- Existing transfer/manage dialog flows still open from the real sheet.

---

## P2-10b — Normalize labels and affordances for inventory actions

**Depends on:** P2-10a

**Objective:** Align wording, icons/buttons/chips, and affordance style so inventory actions read as one system.

**Grounded touchpoints:**
- `lib/src/features/characters/presentation/character_sheet_screen.dart`
  - labels/tooltips such as `Manage containers` and `Transfer to container`
  - split/merge/transfer controls in `_InventoryItemRow`
- Dialog titles and action labels:
  - `Merge Stack`
  - `Transfer to Container`
  - `Manage Containers`
  - delete confirmation text in `container_management_dialog.dart`

**Execution brief:**
1. Audit current visible action labels and tooltips.
2. Normalize casing, verb style, and button intent without changing behavior.
3. Keep the vocabulary consistent between sheet actions and opened dialogs.
4. Avoid changing semantic meaning while polishing labels.

**Out of scope:**
- New validation logic
- Broad accessibility scope beyond labels already required by the action cleanup

**Validation target:**
- Users see predictable verbs and matching dialog titles.
- Affordances for similar actions look intentionally related.

**Recommended tests:**
- Existing widget tests that assert text labels in sheet/dialogs
- Adjust/add assertions only where strings intentionally change

**Done when:**
- Inventory actions use consistent wording and button treatment.
- Sheet labels and dialog labels no longer conflict or surprise.

---

## P2-10c — Normalize disabled and error states for inventory actions

**Depends on:** P2-10b

**Objective:** Make unavailable inventory actions and validation feedback behave consistently across split, merge, transfer, and container management.

**Grounded touchpoints:**
- `lib/src/features/characters/presentation/character_sheet_screen.dart`
  - action enable/disable logic in `_InventoryItemRow`
  - top-level `errorMessage` display plumbing already used elsewhere in the sheet
- Dialog-level guards:
  - `transfer_to_container_dialog.dart`
  - `container_management_dialog.dart`
  - `merge_stack_dialog.dart`
  - `split_stack_dialog.dart`
- Controller error handling pattern:
  - `lib/src/app/app_controller.dart`
  - `_inventoryValidationMessage(...)`

**Execution brief:**
1. Audit where each inventory action becomes disabled today.
2. Normalize the conditions and visible feedback without moving rules into widgets.
3. Reuse controller/service validation messages when a user attempts an invalid action.
4. Keep dialog guard behavior aligned with sheet-level disabled states where possible.

**Out of scope:**
- New domain rules
- New inventory features

**Validation target:**
- Similar invalid states look and behave similarly.
- Errors are visible and non-destructive.

**Recommended tests:**
- Targeted widget tests for disabled buttons and surfaced error text
- Controller tests if behavior depends on `_inventoryValidationMessage(...)`

**Done when:**
- Disabled-state behavior is consistent across the remaining inventory actions.
- Invalid attempts surface clear feedback without partial mutation.

---

## P2-11a — Add transfer end-to-end regression coverage

**Depends on:** P2-10c

**Objective:** Prove the real sheet context still supports open-dialog -> mutate -> visible-update for transfer after the inventory action cleanup.

**Grounded touchpoints:**
- `test/src/features/characters/character_sheet_add_container_test.dart`
  - existing real-path sheet test pattern
- `test/app_controller_test.dart`
  - existing transfer refresh/reopen assertions
- `test/src/features/characters/transfer_to_container_dialog_test.dart`
  - dialog-only coverage exists
- `lib/src/features/characters/presentation/character_sheet_screen.dart`
  - real transfer dialog entry point is already wired

**Execution brief:**
1. Reuse the existing in-memory repo + `AppController` sheet harness pattern.
2. Exercise the real sheet path, not a direct repository shortcut.
3. Assert visible state after transfer from the rendered sheet context.
4. Keep the regression narrowly scoped to transfer.

**Out of scope:**
- Container CRUD
- Reopen persistence for multiple actions together

**Validation target:**
- A user action in the sheet still opens the transfer dialog and mutates through the real flow.
- The updated sheet state is visible after the mutation.

**Recommended tests:**
- Add or expand a real sheet transfer regression under `test/src/features/characters/`
- Keep controller-level transfer persistence coverage in `test/app_controller_test.dart`

**Done when:**
- Transfer remains proven from the real sheet context after the UI normalization cards.

---

## P2-11b — Add container CRUD end-to-end regression coverage

**Depends on:** P2-11a

**Objective:** Prove add/delete container flows work from the real sheet context and visibly refresh after each mutation.

**Grounded touchpoints:**
- `test/src/features/characters/character_sheet_add_container_test.dart`
  - already covers add-container through the real path
- Delete path should extend the same harness once P2-08c exists
- `test/character_sheet_container_management_test.dart`
  - entry-point/open-dialog baseline
- `test/src/features/characters/container_management_dialog_test.dart`
  - dialog-level interactions

**Execution brief:**
1. Keep add coverage if still valid; extend rather than duplicate where possible.
2. Add delete coverage through the same sheet-driven workflow.
3. Assert visible container list changes after each mutation.
4. If delete has invariant guards, cover one expected rejection path.

**Out of scope:**
- Transfer persistence after reopen
- Broader inventory state combinations

**Validation target:**
- Real sheet add/delete flows refresh visible state correctly.
- The regression fails if wiring breaks again.

**Recommended tests:**
- Expand `test/src/features/characters/character_sheet_add_container_test.dart`
  - or split into add/delete-specific files if clarity improves

**Done when:**
- Real sheet CRUD coverage exists for both add and delete.

---

## P2-11c — Add reopen/persistence regression coverage for inventory actions

**Depends on:** P2-11b

**Objective:** Prove transfer and container CRUD state survive reopen after the full P2 inventory chain.

**Grounded touchpoints:**
- `test/app_controller_test.dart`
  - already contains transfer visible-state + reopen assertions
- Existing add-container sheet test pattern under `test/src/features/characters/`
- Repository-backed state reload behavior through:
  - `InMemoryCharacterRepository`
  - whichever repository path is already used by the current tests

**Execution brief:**
1. Reuse the controller/reopen pattern already present for transfer.
2. Add the smallest additional assertions needed for add/delete container persistence.
3. Avoid mixing too many inventory mutations into one brittle test unless the reopen scenario requires it.

**Out of scope:**
- UI wording/layout concerns
- New feature depth beyond persistence verification

**Validation target:**
- After reopen, transfer state still exists.
- After reopen, created/deleted containers reflect persisted reality.

**Recommended tests:**
- Extend `test/app_controller_test.dart`
- Add a focused persistence test under `test/src/features/characters/` only if widget-level reopen behavior is specifically required

**Done when:**
- Persistence across reopen is proven for the remaining inventory actions, not assumed.

---

## P2-12a — Reconcile roadmap/snapshot/resume/tracker after inventory closeout

**Depends on:** P2-11c

**Objective:** Remove stale in-progress wording and make the canonical docs agree on the final inventory-chain status.

**Grounded touchpoints:**
- `docs/project/POST_MVP_P1_TRACKER.md`
- `docs/project/SESSION_RESUME.md`
- `docs/project/PROJECT_SNAPSHOT.md`
- `docs/project/ROADMAP.md`

**Execution brief:**
1. Update statuses and notes only after the implementation/testing cards are actually complete.
2. Remove references that still imply placeholder data or missing delete wiring.
3. Keep one source of truth for next-step guidance instead of duplicating stale operational checklists.
4. Re-read edited sections after patching to verify consistency.

**Out of scope:**
- New backlog creation beyond clarifying the next real scope
- Rewriting finished historical sections unnecessarily

**Validation target:**
- The four canonical docs agree on what is finished and what remains.
- No doc still claims delete wiring or inventory closeout is pending if it is done.

**Done when:**
- Canonical continuity docs are internally consistent after the P2 inventory chain implementation work.

---

## P2-12b — Declare current player-app scope complete

**Status:** Done — the current player-app scope is explicitly marked complete in the canonical docs.

**Depends on:** P2-12a

**Objective:** Close the currently scoped player-app work and leave any future work clearly in backlog form rather than hidden debt.

**Grounded touchpoints:**
- `docs/project/POST_MVP_P1_TRACKER.md`
- `docs/project/SESSION_RESUME.md`
- `docs/project/PROJECT_SNAPSHOT.md`
- `docs/project/ROADMAP.md`
- Any remaining phase/backlog docs that name the active slice

**Execution brief:**
1. Confirm all P2 cards are actually complete before declaring scope closure.
2. Change “next slice” language from execution instructions to backlog posture if no scoped work remains.
3. Keep future work explicit and separated from “current scope complete”.
4. Do not silently roll new work into the finished scope.

**Out of scope:**
- Starting the next backlog stream
- New implementation work

**Validation target:**
- A fresh session can read the docs and immediately understand that the current scoped player-app chain is closed.
- Future work appears as backlog, not disguised unfinished scope.

**Done when:**
- Current player-app scope is explicitly marked complete in the canonical docs.
- Remaining work, if any, is clearly framed as future backlog.

---

## Recommended execution order

1. `P2-08c — Hook delete-container action to the real mutation path`
2. `P2-09 — Add/repair widget tests for container management`
3. `P2-10a — Normalize where inventory actions appear in the sheet`
4. `P2-10b — Normalize labels and affordances for inventory actions`
5. `P2-10c — Normalize disabled and error states for inventory actions`
6. `P2-11a — Add transfer end-to-end regression coverage`
7. `P2-11b — Add container CRUD end-to-end regression coverage`
8. `P2-11c — Add reopen/persistence regression coverage for inventory actions`
9. `P2-12a — Reconcile roadmap/snapshot/resume/tracker after inventory closeout`
10. `P2-12b — Declare current player-app scope complete`

---

## Validation Recovery Briefs

These briefs cover the small recovery backlog that surfaced in the latest validation run. Keep them isolated from the closed P2 inventory chain.

### VR-01 — Fix spell-slot overspend validation parity

**Depends on:** none

**Objective:** Make spell-slot overspend rejection behave consistently across the Drift and in-memory repository paths so the overspend test fails for the right reason and the current maximum-slot guard is enforced.

**Grounded touchpoints:**
- `lib/src/features/characters/application/character_recovery_service.dart`
  - `spendSpellSlot(...)` and `restoreSpellSlot(...)` share the spell-slot validation path.
- `lib/src/features/characters/data/drift_character_repository.dart`
  - repository-facing spend/restore delegation.
- `lib/src/features/characters/data/in_memory_character_repository.dart`
  - in-memory parity implementation for spell-slot mutation.
- `test/drift_character_repository_test.dart`
  - failing overspend rejection assertion.
- `test/character_sheet_screen_spell_slot_restore_test.dart`
  - useful parity guard if the fix touches slot-index handling.

**Execution brief:**
1. Inspect the current overspend guard and confirm whether the failing assertion is hitting the intended branch.
2. Align any off-by-one or slot-count handling between Drift and in-memory implementations.
3. Keep the fix in repository/service layers; do not introduce widget-side validation.
4. Add or adjust a narrow regression test if the existing one no longer captures the intended failure mode.

**Out of scope:**
- Spell UI polish
- Broader recovery flow changes

**Validation target:**
- `test/drift_character_repository_test.dart` passes for the overspend rejection case.
- In-memory and Drift behavior stay aligned.

**Recommended tests:**
- `flutter test test/drift_character_repository_test.dart`
- `flutter test test/character_sheet_screen_spell_slot_restore_test.dart`

**Done when:**
- Overspend rejection is deterministic and the repository parity stays green.

**Coder microtasks:**
1. `VR-01a — Reproduce the overspend failure and pin the exact guard branch`
2. `VR-01b — Align Drift and in-memory spell-slot overspend checks`
3. `VR-01c — Tighten the overspend regression test`
4. `VR-01d — Run targeted validation for spell-slot parity`

### VR-02 — Stabilize container-management dialog interactions

**Depends on:** none

**Objective:** Fix the container-management dialog so add/rename/selection behavior is stable, focus-safe, and testable without build-scope or text-controller side effects.

**Grounded touchpoints:**
- `lib/src/features/characters/presentation/container_management_dialog.dart`
  - `_selectContainer(...)`
  - `_renameContainer()`
  - `_addContainer()`
  - the `TextField` `onChanged` handler and focus node setup.
- `test/src/features/characters/container_management_dialog_test.dart`
  - failing add-forwarding and selection assertions.
- `test/src/features/characters/container_management_dialog_widget_test.dart`
  - failing selection and empty-name widget interactions.
- `test/character_sheet_container_management_test.dart`
  - sheet entry-point coverage to keep green after dialog cleanup.

**Execution brief:**
1. Remove any `TextField` state mutation that feeds text back into the controller during `onChanged`.
2. Make row selection and rename/add actions explicit so tests can interact with the dialog predictably.
3. Keep focus behavior intact, but avoid triggering build-scope issues during widget tests.
4. Preserve existing semantics labels and error display behavior.

**Out of scope:**
- Repository mutation implementation
- New inventory features

**Validation target:**
- The dialog widget tests pass without focus or build-scope exceptions.
- Add/selection behavior matches the intended UI contract.

**Recommended tests:**
- `flutter test test/src/features/characters/container_management_dialog_test.dart`
- `flutter test test/src/features/characters/container_management_dialog_widget_test.dart`
- `flutter test test/character_sheet_container_management_test.dart`

**Done when:**
- The dialog no longer throws focus/build-scope errors and forwards the entered container name correctly.

**Coder microtasks:**
1. `VR-02a — Remove controller feedback loops from the container name field`
2. `VR-02b — Make container selection explicit and predictable`
3. `VR-02c — Stabilize add/rename action callbacks`
4. `VR-02d — Repair and rerun the dialog widget tests`

### VR-03 — Re-run validation and reconcile docs

**Depends on:** VR-01, VR-02

**Objective:** Re-run the project validation, confirm the recovery backlog is closed, and synchronize the canonical docs with the new state.

**Status:** VR-03a through VR-03c are complete; VR-03d is the only remaining closeout step.

**Grounded touchpoints:**
- `docs/project/SESSION_RESUME.md`
- `docs/project/PROJECT_SNAPSHOT.md`
- `docs/project/ROADMAP.md`
- `docs/project/POST_MVP_P1_TRACKER.md`
- `docs/project/P2_EXECUTABLE_BRIEFS.md`

**Execution brief:**
1. Run `dart format .` if any code changed.
2. Run `flutter analyze`.
3. Run `flutter test`.
4. Update the continuity docs to reflect the new green state or any remaining blocker.
5. Commit the recovery closeout once the docs and validation agree.

**Out of scope:**
- New feature work
- Further scope expansion

**Validation target:**
- The repo is green again or the remaining blocker is explicitly documented.
- The canonical docs and tracker agree on the remaining state.

**Recommended tests:**
- Full `flutter analyze`
- Full `flutter test`

**Done when:**
- The recovery queue is fully reflected in docs and the project state is consistent.

**Coder microtasks:**
1. `VR-03a — Run format/analyze/test after the code fixes`
2. `VR-03b — Reconcile SESSION_RESUME and PROJECT_SNAPSHOT`
3. `VR-03c — Sync ROADMAP, tracker, and briefs`
4. `VR-03d — Commit and push the recovery closeout`