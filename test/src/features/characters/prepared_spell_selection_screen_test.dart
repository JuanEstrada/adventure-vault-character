import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/prepared_spell_selection_screen.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart'
    as domain;

void main() {
  group('PreparedSpellSelectionScreen', () {
    testWidgets('opens successfully', (WidgetTester tester) async {
      final screen = PreparedSpellSelectionScreen(
        characterId: 'char-1',
        availableSpells: <domain.CharacterSpellReferenceDomainModel>[],
        selectionLimit: 10,
        onDismiss: () {},
        onSave: (_) {},
      );

      await tester.pumpWidget(MaterialApp(home: screen));
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Text), findsWidgets);
    });
  });
}
