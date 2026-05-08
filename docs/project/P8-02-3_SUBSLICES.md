# P8-02-3: Dialog Semantics - Smallest Implementation Sub-slices

**Status:** In progress  
**Last Updated:** 2026-05-06  
**Priority:** CRITICAL

---

## Summary

This document identifies the minimal implementation slices for P8-02-3 (Dialog Semantics), grounded in the current dialog widgets and accessibility gaps found during inspection.

---

## Issues Found

### merge_stack_dialog.dart
- ✅ Has Semantics wrapper with `container: true`, `explicitChildNodes: true`, `namesRoute: true`, `label: 'Merge stack dialog'`
- ❌ Missing semantics labels on:
  - Title text "Merge Stack"
  - Content text elements (source/target labels, after calculation)
  - Action buttons (Cancel, Merge)

### split_stack_dialog.dart
- ❌ **CRITICAL**: No Semantics wrapper at all
- ❌ AlertDialog is NOT wrapped in FocusScope
- ❌ Missing semantics labels on:
  - Title text "Split Stack"
  - Content text elements (split quantity, source, new, remaining)
  - Action buttons (Cancel, Split)

### transfer_to_container_dialog.dart
- ❌ Missing Semantics wrapper
- ❌ Missing semantics labels on:
  - Title text "Transfer to Container"
  - Content text elements (source info, container selection, after calculation)
  - Action buttons (Cancel, Transfer)
  - Container ChoiceChips

### container_management_dialog.dart
- ❌ Missing Semantics wrapper
- ❌ Missing semantics labels on:
  - Title text "Manage Containers"
  - Content text elements (containers list, add new container, count)
  - Action buttons (Cancel, Rename, Add)
  - Container list items
  - Delete confirmation dialog (inline AlertDialog - also lacks semantics)

---

## Recommended Sub-slices (Smallest Possible)

### Slice 1: P8-02-3-1 (Split Stack Dialog - Semantics Wrapper)
**Status:** complete
**File:** `lib/src/features/characters/presentation/split_stack_dialog.dart`  
**Lines:** ~3  
**Objective:** Add Semantics wrapper to split_stack_dialog.dart and wrap AlertDialog in FocusScope  
**Risk:** High (dialog is completely missing semantics)  
**Verification:** `flutter analyze`

---

### Slice 2: P8-02-3-2 (Merge Stack Dialog - Content Semantics)
**Status:** complete
**File:** `lib/src/features/characters/presentation/merge_stack_dialog.dart`  
**Lines:** ~10  
**Objective:** Add Semantics labels to content widgets (source/target labels, error text, after calculation)  
**Risk:** Low  
**Verification:** `flutter analyze`

---

### Slice 3: P8-02-3-3 (Transfer Dialog - Semantics Wrapper)
**Status:** complete
**File:** `lib/src/features/characters/presentation/transfer_to_container_dialog.dart`  
**Lines:** ~3  
**Objective:** Add Semantics wrapper with appropriate label  
**Risk:** Low  
**Verification:** `flutter analyze`

---

### Slice 4: P8-02-3-4 (Transfer Dialog - Content Semantics)
**Status:** complete
**File:** `lib/src/features/characters/presentation/transfer_to_container_dialog.dart`  
**Lines:** ~12  
**Objective:** Add Semantics labels to content widgets (source info, container selection, after calculation, error text)  
**Risk:** Low  
**Verification:** `flutter analyze`

---

### Slice 5: P8-02-3-5 (Container Management Dialog - Semantics Wrapper)
**File:** `lib/src/features/characters/presentation/container_management_dialog.dart`  
**Lines:** ~3  
**Objective:** Add Semantics wrapper with appropriate label  
**Risk:** Low  
**Verification:** `flutter analyze`

---

### Slice 6: P8-02-3-6 (Container Management Dialog - Content Semantics)
**File:** `lib/src/features/characters/presentation/container_management_dialog.dart`  
**Lines:** ~15  
**Objective:** Add Semantics labels to content widgets (containers list, add new container, count, error text if any)  
**Risk:** Low  
**Verification:** `flutter analyze`

---

### Slice 7: P8-02-3-7 (Delete Confirmation Dialog - Semantics)
**File:** `lib/src/features/characters/presentation/container_management_dialog.dart` (lines 93-116)  
**Lines:** ~3  
**Objective:** Add Semantics wrapper to the inline delete confirmation AlertDialog  
**Risk:** Low  
**Verification:** `flutter analyze`

---

## Implementation Order (Recommended)

1. **P8-02-3-1** - Split Stack Dialog (critical gap - no semantics at all)
2. **P8-02-3-2** - Merge Stack Dialog content (build on existing wrapper)
3. **P8-02-3-3** - Transfer Dialog wrapper
4. **P8-02-3-4** - Transfer Dialog content
5. **P8-02-3-5** - Container Management wrapper
6. **P8-02-3-6** - Container Management content
7. **P8-02-3-7** - Delete confirmation dialog

---

## Expected Semantics Pattern

Following Flutter accessibility guidelines, each dialog should have:

```dart
Semantics(
  container: true,
  explicitChildNodes: true,
  namesRoute: true,
  label: 'Dialog description',
  child: AlertDialog(
    title: Semantics(label: 'Dialog Title'),
    content: Semantics(
      child: Column(
        // content widgets
      ),
    ),
    actions: [
      TextButton(
        Semantics(label: 'Cancel button'),
        child: const Text('Cancel'),
      ),
      ElevatedButton(
        Semantics(label: 'Confirm action'),
        child: const Text('Confirm'),
      ),
    ],
  ),
);
```

---

## Verification Commands

```bash
flutter analyze
flutter test test/character_sheet_screen_semantics_test.dart -r expanded
```

---

## Notes

- All dialogs already have `FocusScope` wrappers with `autofocus: true` - this is correct for modals
- The `debugLabel` on FocusNode instances is already in place - no changes needed
- Semantics labels should use natural language descriptions, not technical terms
- Error messages should have Semantics labels for screen reader users
