import 'dart:async';

import 'package:adventure_vault_character/src/features/characters/application/character_change_tracker.dart';

class AutoSaveService {
  AutoSaveService({
    required CharacterChangeTracker changeTracker,
    Duration interval = const Duration(seconds: 2),
  }) : _changeTracker = changeTracker,
       _interval = interval {
    _timer = Timer.periodic(_interval, (_) => _flushPendingChanges());
  }

  final CharacterChangeTracker _changeTracker;
  final Duration _interval;
  Timer? _timer;

  void recordChange(String characterId) {
    _changeTracker.recordChange(characterId);
  }

  Future<int> flushPendingChanges() async {
    return _changeTracker.flushAllChanges();
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _flushPendingChanges() async {
    await flushPendingChanges();
  }
}
