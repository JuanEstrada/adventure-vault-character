class CharacterInventoryValidationError implements Exception {
  const CharacterInventoryValidationError(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => 'CharacterInventoryValidationError($code): $message';
}
