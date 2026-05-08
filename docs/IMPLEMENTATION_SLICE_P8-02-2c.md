# P8-02-2c: Spells + Inventory Controls Semantics

**Status:** In progress  
**Target:** Add `Semantics` labels to spell slot controls and inventory item controls  
**Files to modify:** `lib/src/features/characters/presentation/character_sheet_screen.dart`

---

## 1. Smallest Viable Sub-Slices

### Slice P8-02-2c-a: Spell Slot Control Semantics
**Lines:** ~25-35  
**Description:** Add `Semantics` labels to spell slot "Spend" and "Restore" chips

**Widgets to add:**
- Line 1299: "Spend $index" ActionChip → `label: 'Spend slot $index'`
- Line 1313: "Restore" ActionChip → `label: 'Restore slot $index'`

---

### Slice P8-02-2c-b: Available Spells Semantics
**Lines:** ~15-20  
**Description:** Add `Semantics` labels to available spell list items

**Widgets to add:**
- Line 1412: Spell list text → `Semantics(label: '${spell.name} (${spell.school}, ${spell.castingTime})')`

---

### Slice P8-02-2c-c: Inventory Quantity Controls Semantics
**Lines:** ~20-25  
**Description:** Add `Semantics` labels to quantity buttons in `_InventoryItemRow`

**Widgets to add:**
- Line 1657: Decrease IconButton → `label: 'Decrease quantity'`
- Line 1664: Increase IconButton → `label: 'Increase quantity'`

---

### Slice P8-02-2c-d: Inventory Action Chip Semantics
**Lines:** ~15-20  
**Description:** Add `Semantics` labels to inventory action chips

**Widgets to add:**
- Line 1671: "Spend 1" ActionChip → `label: 'Spend 1'`
- Line 1686: "Equipped" FilterChip → `label: 'Toggle equipped'`
- Line 1691: "Carried" FilterChip → `label: 'Toggle carried'`
- Line 1698: "Clear charges" ActionChip → `label: 'Clear charges'`
- Line 1706: "Track charges" ActionChip → `label: 'Track charges'`

---

### Slice P8-02-2c-e: Inventory Charges Controls Semantics
**Lines:** ~15-20  
**Description:** Add `Semantics` labels to charges buttons

**Widgets to add:**
- Line 1721: Charges decrease IconButton → `label: 'Decrease charges'`
- Line 1732: Charges increase IconButton → `label: 'Increase charges'`

---

### Slice P8-02-2c-f: Inventory Container Semantics
**Lines:** ~10-15  
**Description:** Add `Semantics` label to container dropdown

**Widgets to add:**
- Line 1758: Container DropdownButtonFormField → `Semantics(label: 'Select container')`

---

### Slice P8-02-2c-g: Inventory Stack Operations Semantics
**Lines:** ~10-15  
**Description:** Add `Semantics` labels to stack manipulation buttons

**Widgets to add:**
- Line 1789: Split stack IconButton → `label: 'Split stack'`
- Line 1797: Transfer to container IconButton → `label: 'Transfer to container'`
- Line 1804: Merge stacks IconButton → `label: 'Merge with containers'`

---

## 2. Exact Widgets/Controls Lacking Semantics Labels

### SpellsPanel (_SpellsPanel class, lines 1165-1424)

| Line | Widget | Current | Needed Semantics |
|------|--------|---------|------------------|
| 1299 | ActionChip | `label: 'Spend $index'` | `label: 'Spend slot $index'` |
| 1313 | ActionChip | `label: 'Restore'` | `label: 'Restore slot $index'` |
| 1412-1415 | Text (spell list) | No semantics | `Semantics(label: '${spell.name}')` |

### EquipmentPanel / _InventoryItemRow class (lines 1596-1849)

| Line | Widget | Current | Needed Semantics |
|------|--------|---------|------------------|
| 1657 | IconButton | No semantics | `label: 'Decrease quantity'` |
| 1664 | IconButton | No semantics | `label: 'Increase quantity'` |
| 1671 | ActionChip | `label: 'Spend 1'` | `label: 'Spend 1'` |
| 1686 | FilterChip | `label: 'Equipped'` | `label: 'Toggle equipped'` |
| 1691 | FilterChip | `label: 'Carried'` | `label: 'Toggle carried'` |
| 1698 | ActionChip | `label: 'Clear charges'` | `label: 'Clear charges'` |
| 1706 | ActionChip | `label: 'Track charges'` | `label: 'Track charges'` |
| 1721 | IconButton | No semantics | `label: 'Decrease charges'` |
| 1732 | IconButton | No semantics | `label: 'Increase charges'` |
| 1758 | DropdownButtonFormField | No semantics | `Semantics(label: 'Select container')` |
| 1789 | IconButton | `tooltip: 'Split stack'` | `label: 'Split stack'` |
| 1797 | IconButton | `tooltip: 'Transfer to container'` | `label: 'Transfer to container'` |
| 1804 | IconButton | `tooltip: 'Merge with containers'` | `label: 'Merge with containers'` |

---

## 3. Recommendation for Next Implementation Step

### Step 1: Implement P8-02-2c-a (Spell Slot Semantics)
**Why first:** Spell slots are the most straightforward to implement; no nested widgets.  
**Impact:** ~25 lines, 2 widgets.  
**Verification:** `flutter test test/character_sheet_screen_combat_recovery_semantics_test.dart`

### Step 2: Implement P8-02-2c-b (Available Spells Semantics)
**Why second:** Simple Text widget replacement; minimal risk.  
**Impact:** ~15 lines, 1 widget.  
**Verification:** `flutter test test/character_sheet_screen_combat_recovery_semantics_test.dart`

### Step 3: Implement P8-02-2c-c through P8-02-2c-g (Inventory Semantics)
**Why third:** Requires careful placement within `_InventoryItemRow` structure.  
**Impact:** ~80 lines, 12 widgets.  
**Verification:** `flutter test test/character_sheet_screen_combat_recovery_semantics_test.dart`

### Final Verification
After completing all slices:
```bash
flutter analyze
flutter test test/character_sheet_screen_semantics_test.dart
flutter test test/character_sheet_screen_combat_recovery_semantics_test.dart
```

---

## 4. Test Update Needed

A new semantics test should be created to verify spells and inventory controls:

**File:** `test/character_sheet_screen_spell_inventory_semantics_test.dart`

**Test should verify:**
- Spell slot "Spend" and "Restore" chips have correct labels
- Available spells list items have semantics labels
- All inventory item row controls have semantics labels
- Container dropdown has semantics label

---

## 5. Notes

- All existing Semantics widgets use `container: true` and `button: true` for interactive elements
- Labels should be descriptive but concise (under 50 characters ideal)
- Tooltip is NOT sufficient for screen reader accessibility; `Semantics(label:)` is required
- The `tooltip` attribute is already present on some buttons but should be replaced with proper `Semantics` labels
