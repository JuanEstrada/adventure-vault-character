abstract interface class SystemSettingsRepository {
  Future<bool> getIncludeCoinWeightInEncumbrance();

  Future<void> setIncludeCoinWeightInEncumbrance(bool value);
}
