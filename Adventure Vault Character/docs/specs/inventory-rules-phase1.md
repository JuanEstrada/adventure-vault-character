# Inventory Rules Phase 1

## Status

Accepted (policy freeze for implementation ticket T1)

## Purpose

Freeze deterministic inventory behavior for the first depth slice beyond the
starter-equipment MVP baseline. This spec defines canonical rules for
containers, carried-load evaluation, tracked charges, and consumable/ammo usage
contracts.

## Scope

In scope:

- Container assignment validity and capacity policy
- Effective carried-load policy for nested containers
- Tracked-charge mutation contract
- Consumable/ammo mutation contract
- Deterministic success/failure outcomes

Out of scope for this phase:

- UI layout and interaction details
- Rich item archetype automation from all compendium sources
- Market/economy logic
- Full tactical combat automation

## Canonical Terms

- `Container item`: inventory item flagged as container-capable by definition
  metadata.
- `Content weight`: total weight of all items directly or indirectly stored
  inside a container.
- `Container capacity`: maximum allowed `content weight` for a container.
- `Effective carried item`: item that contributes to encumbrance because it is
  carried and every ancestor container in its chain is also carried.
- `Container chain`: parent-container links from an item to the top-level item.

## Container Policy (Frozen)

### Capacity Model

- Capacity model is `weight-cap only`.
- Slot-count capacity is not used in Phase 1.
- Overflow behavior is reject-only: invalid mutations are not partially applied.

### Capacity Rule

- For a container `C`, assignment is valid only when:
  `newContentWeight(C) <= containerMaxWeight(C)`.
- `newContentWeight` includes direct and nested descendants.
- If container capacity is missing or unknown, the assignment is treated as
  unlimited for this phase.

### Structural Validity

- Self-container assignment is invalid.
- Cycles are invalid.
- Cross-character container assignment is invalid.
- Parent target must be container-capable.

### Nesting Limit

- Maximum nesting depth is `5`.
- Any assignment creating depth `> 5` is invalid.

## Effective Carried-Load Policy (Frozen)

- An item contributes to encumbrance only when it is effectively carried.
- An item is effectively carried when:
  - the item itself is marked carried, and
  - each ancestor container in its chain is marked carried.
- If a container in the chain is not carried, descendants contribute `0` to
  carried-load totals.

## Tracked Charges Policy (Frozen)

- Charge tracking is optional per inventory item.
- Valid tracked state:
  - `chargesMax` is non-null and `>= 0`
  - `chargesCurrent` is clamped to `[0, chargesMax]`
- Clearing tracking sets both `chargesCurrent` and `chargesMax` to null.
- Long-rest recovery behavior for tracked items:
  - if `chargesMax` is set, `chargesCurrent` resets to `chargesMax`.

## Consumable and Ammo Contract (Frozen)

- Usage mutation decrements quantity by deterministic step.
- Mutation is invalid when quantity is insufficient.
- Invalid usage does not mutate any state.
- Quantity is clamped to non-negative values.
- Stack lifecycle mutations for stackable items are deterministic:
  - `split`: creates a new stack row and reduces the source stack by the same
    amount.
  - `merge`: moves quantity from source stack to target stack.
  - `retire-zero`: removes stack rows with quantity `<= 0` when explicitly
    requested by lifecycle cleanup operations.
- `split` and `merge` are valid only for stackable and compatible stacks.
- Compatibility requires matching stack identity and state fields (definition,
  tracking state, carry/equip/container state, and notes) so merges are not
  lossy.
- Any invalid stack mutation is reject-only and does not mutate state.

## Error Contract

Services must expose structured failure reasons for these categories:

- `invalid_target` (non-container parent, missing parent)
- `invalid_structure` (self-parent, cycle, depth overflow)
- `capacity_exceeded` (weight-cap overflow)
- `insufficient_quantity` (consumable/ammo usage)
- `invalid_charge_state` (inconsistent charge mutation request)
- `invalid_stack_state` (non-stackable or incompatible stack lifecycle request)

## Deterministic Examples

- Assign `Torch (1 lb)` into `Backpack` with remaining capacity `2 lb`:
  valid; remaining capacity becomes `1 lb`.
- Assign `Anvil (50 lb)` into `Backpack` with capacity `30 lb`:
  invalid; no state change.
- Place item into its own descendant chain:
  invalid due to cycle; no state change.
- Mark top-level container as not carried:
  all descendants stop contributing to carried-load.
- Spend charge from `1/3`:
  next state `0/3`.
- Spend consumable when quantity `0`:
  invalid; quantity stays `0`.

## Layering Rules

- Rule evaluation belongs to `domain` and `application`.
- Repositories enforce persistence integrity but do not own business rules.
- Widgets/presentation consume outputs and must not re-derive these rules.

## Implementation Mapping

- T2: domain model and invariant extensions
- T3: container validation engine (capacity/depth/cycle)
- T4: tracked-charge lifecycle behavior
- T5: consumable/ammo deterministic usage behavior
- T6: application orchestration for advanced mutations
