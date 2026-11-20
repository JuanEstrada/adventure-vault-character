# Inventory Container Lifecycle

**Scope:** AVC inventory behavior, not a D&D rules change. These rules do not migrate or restore legacy containers.

| Action | Expected result |
| --- | --- |
| Rename a current custom container | Save a non-blank, trimmed name on that inventory instance only. Its ID, contents, and location stay the same. The new name appears on the container and on its contents' location labels after reopening. Shared catalog containers are not renamed. |
| Delete a container | Move its direct contents to the owning character's inventory root and delete only the selected container. Preserve item identities, quantities, and stored carried state. If one of the contents is itself a container, its contents stay inside it. |
| Retire zero-quantity rows | Keep a row as long as another inventory item references it. Unreferenced zero-quantity rows can still be removed. This guard does not make a legacy Qty0 row usable as a container or repair an existing dangling reference. |

## Verification and remaining limits

- Independent checks passed for zero-quantity reference protection and for deletion. SQLite checks covered persistence on reopen.
- Automated rename tests cover opening the sheet action, changing the name without losing contents, and reopening SQLite. The independent rename check did not run to completion because of a network timeout.
- General move-to-root via a nullable reference is still a separate in-memory issue. Explicit deletion clears the reference through its own path.
- Historical cross-character inventory links are unsupported. No cleanup or repair of links already dangling was authorized. No real database was opened, and no migration was run.

See the [work log](../../odd/tasks/inventory-containers.md) for the exact scope, checks, and commit boundaries.
