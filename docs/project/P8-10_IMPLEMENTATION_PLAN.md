# P8-10: Add Session Persistence and Auto-Save
## Implementation Plan

**Last Updated:** 2026-05-05  
**Dependencies:** P8-09 (complete)  
**Status:** Complete — auto-save/change-tracking wiring and tests landed (2026-05-05)

---

## Summary

Current architecture already has robust Drift/SQLite persistence. P8-10 adds **change tracking** and **background auto-save** on top of existing infrastructure.

---

## Files to Create (3)

### 1. `lib/src/features/characters/application/character_change_tracker.dart`

**Purpose:** Track mutations with timestamps, queue auto-save jobs, handle rapid-edit race conditions.

**Key Methods:**
- `startTracking()` / `stopTracking()`
- `recordChange(String characterId)` - called after each mutation
- `getPendingChanges(String characterId)` - returns queued changes
- `flushChanges(String characterId)` - persist queued changes to DB

**Race Condition Handling:**
- Debounce queue (1-2 second delay)
- Group rapid edits before flush
- Last-write-wins for concurrent mutations

---

### 2. `lib/src/features/characters/application/auto_save_service.dart`

**Purpose:** Scheduled background save + manual save confirmation.

**Key Methods:**
- `startAutoSave(String characterId)` - start background save timer
- `stopAutoSave(String characterId)` - cancel timer
- `triggerManualSave(String characterId)` - show dialog, save if confirmed
- `isSaving(String characterId)` - returns boolean

**Background Save:**
- `Timer.periodic(Duration(seconds: 2))` - check for pending changes
- Skip if `isSaving()` returns true

**Manual Save Dialog:**
- Simple confirmation dialog ("Save character sheet?")
- Shows "Saving..." state during save
- Shows error if save fails

---

### 3. `test/character_change_tracker_test.dart`

**Tests:**
- `recordChange` adds timestamp to change queue
- `flushChanges` persists to DB and clears queue
- Rapid edits are grouped (concurrent writes handled)
- Timer fires after debounce period

---

## Files to Modify (4)

### 1. `lib/src/features/characters/application/character_sheet_service.dart`

**Additions:**
```dart
Future<void> startAutoSave(String id) async {
  await _autoSaveService.startAutoSave(id);
}

Future<void> stopAutoSave(String id) async {
  await _autoSaveService.stopAutoSave(id);
}
```

**Integration:**
- Call `startAutoSave()` when user opens character sheet
- Call `stopAutoSave()` when navigating away

---

### 2. `lib/src/features/characters/application/editable_character_service.dart`

**Additions:**
```dart
Future<void> markChanges(String id) async {
  await _changeTracker.recordChange(id);
}
```

**Integration:**
- Call `markChanges()` after all mutations complete
- This triggers change tracking and eventual auto-save

---

### 3. `lib/src/features/characters/data/drift_character_repository.dart`

**Additions:**
```dart
// Inject into constructor
final _autoSaveService = AutoSaveService(
  database: database,
  ...
);

// Delegate auto-save operations
Future<void> autoSaveCharacter(String id) async {
  return _autoSaveService.autoSave(id);
}
```

---

### 4. `lib/src/features/characters/data/local/character_write_dao.dart`

**Additions:**
```dart
// Add column to Characters table
IntColumn get lastSavedAt => integer()
    .named('last_saved_at')
    .nullable()();

// Add migration for existing characters
@Migration("add_last_saved_at")
void addLastSavedAt() {
  database.table(Characters).addColumn(
    IntColumn.get("last_saved_at"),
  );
}
```

---

## Files to Create (Tests)

| Test File | Scope |
|-----------|-------|
| `test/character_change_tracker_test.dart` | Change tracking, queue management |
| `test/auto_save_service_test.dart` | Background save, manual save dialog |
| `test/character_sheet_service_test.dart` | Auto-save lifecycle integration |

---

## Key Implementation Details

1. **Auto-save delay:** 1-2 second debounce after last mutation
2. **Manual save:** Button on character sheet → confirmation dialog
3. **Race condition handling:** Queue-based batching before DB write
4. **Data integrity:** Validate before save, rollback on error
5. **Last saved timestamp:** Track per-character in `Characters` table

---

## Verification Steps

```bash
# After implementation
flutter analyze
flutter test test/character_change_tracker_test.dart
flutter test test/auto_save_service_test.dart
flutter test test/character_sheet_service_test.dart
```

---

## Expected Outcome

- Character changes are auto-saved within 2 seconds of last edit
- Manual save button provides confirmation dialog
- No data loss during rapid editing
- Last save timestamp tracked per character
- No new domain models required
- Minimal code changes (5-6 files total)
