import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/spellbook_management_screen.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_spellbook_domain.dart';

void main() {
  group('SpellbookManagementScreen', () {
    testWidgets('opens with empty spellbook', (WidgetTester tester) async {
      final screen = SpellbookManagementScreen(
        characterId: 'char-1',
        availableSpells: <CharacterSpellReferenceDomainModel>[],
        spellSelectionMode: WizardSpellSelectionMode.prepared,
        selectionLimit: 10,
        onDismiss: () {},
        onSave: (_) {},
      );

      await tester.pumpWidget(MaterialApp(home: screen));

      expect(find.text('Prepared Spells'), findsOneWidget);
    });
  });
}
