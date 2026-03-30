import 'package:adventure_vault_character/src/features/settings/data/system_settings_repository.dart';

class InMemorySystemSettingsRepository implements SystemSettingsRepository {
  InMemorySystemSettingsRepository({
    bool includeCoinWeightInEncumbrance = false,
  }) : _includeCoinWeightInEncumbrance = includeCoinWeightInEncumbrance;

  bool _includeCoinWeightInEncumbrance;

  @override
  Future<bool> getIncludeCoinWeightInEncumbrance() async {
    return _includeCoinWeightInEncumbrance;
  }

  @override
  Future<void> setIncludeCoinWeightInEncumbrance(bool value) async {
    _includeCoinWeightInEncumbrance = value;
  }
}
