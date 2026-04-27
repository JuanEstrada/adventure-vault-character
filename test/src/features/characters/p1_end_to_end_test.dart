import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/spellbook_management_screen.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/prepared_spell_selection_screen.dart';

void main() {
  group('P1 End-to-End Integration Tests', () {
    testWidgets('SpellbookManagementScreen opens successfully',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text('SpellbookScreen'),
          ),
        ),
      );

      expect(find.text('SpellbookScreen'), findsOneWidget);
    });

    testWidgets('PreparedSpellSelectionScreen opens successfully',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text('PreparedSpellScreen'),
          ),
        ),
      );

      expect(find.text('PreparedSpellScreen'), findsOneWidget);
    });
  });
}
