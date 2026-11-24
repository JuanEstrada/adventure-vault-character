# Inventory Container Lifecycle

**Scope:** AVC inventory behavior, not a D&D rules change. These rules do not migrate or restore legacy containers.

| Action | Expected result |
| --- | --- |
| Rename a current custom container | Save a non-blank, trimmed name on that inventory instance only. Its ID, contents, and location stay the same. The new name appears on the container and on its contents' location labels after reopening. Shared catalog containers are not renamed. |
| Delete a container | Move its direct contents to the owning character's inventory root and delete only the selected container. Preserve item identities, quantities, and stored carried state. If one of the contents is itself a container, its contents stay inside it. If an item owned by another character references the container, reject deletion without modifying either inventory. |
| Retire zero-quantity rows | Keep a row as long as another inventory item references it. Unreferenced zero-quantity rows can still be removed. This guard does not make a legacy Qty0 row usable as a container or repair an existing dangling reference. |

## Verification and remaining limits

- Independent checks passed for zero-quantity reference protection and for deletion. SQLite checks covered persistence on reopen.
- Independent verification of committed rename slice `9bad5a5` passed eight tests. It covered the sheet action and creating, renaming, and reopening a custom container with its identity, name, and contents preserved.
- Moving a whole item to the inventory root clears its container reference in both Drift and the in-memory repository, without changing the item's identity, quantity, or carried state.
- Deletion rejects a stored cross-character reference before writing: `Cannot delete a container referenced by another character.` This prevents a new dangling link; it does not repair any existing ones. No real database was opened, and no migration was run.

See the [work log](../../odd/tasks/inventory-containers.md) for the exact scope, checks, and commit boundaries.
