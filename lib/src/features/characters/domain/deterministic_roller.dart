abstract interface class DeterministicRoller {
  int roll({
    required String seed,
    required int sides,
  });
}

class HashDeterministicRoller implements DeterministicRoller {
  const HashDeterministicRoller();

  @override
  int roll({
    required String seed,
    required int sides,
  }) {
    if (sides <= 1) {
      return 1;
    }

    var hash = 0;
    for (final codeUnit in seed.codeUnits) {
      hash = ((hash * 31) + codeUnit) & 0x7fffffff;
    }
    return (hash % sides) + 1;
  }
}
