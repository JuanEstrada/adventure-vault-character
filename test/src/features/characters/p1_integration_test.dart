import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/merge_stack_dialog.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/transfer_to_container_dialog.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/container_management_dialog.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/spellbook_management_screen.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/prepared_spell_selection_screen.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart' as domain;

void main() {
  group('P1 Integration Tests', () {
    testWidgets('MergeStackDialog renders correctly',
        (WidgetTester tester) async {
      final dialog = MergeStackDialog(
        sourceStackId: 'stack-1',
        targetStackId: 'stack-2',
        sourceName: 'Potion',
        sourceQuantity: 5,
        targetQuantity: 3,
        availableStacks: [],
        onDismiss: () {},
        onMerge: (_, __) {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: dialog,
          ),
        ),
      );

      expect(find.text('Merge Stacks'), findsOneWidget);
      expect(find.text('Potion'), findsOneWidget);
    });

    testWidgets('TransferToContainerDialog renders correctly',
        (WidgetTester tester) async {
      final dialog = TransferToContainerDialog(
        sourceItemId: 'item-1',
        sourceQuantity: 10,
        sourceName: 'Potions',
        onDismiss: () {},
        onTransfer: (_, __, ___) {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: dialog,
          ),
        ),
      );

      expect(find.text('Transfer to Container'), findsOneWidget);
      expect(find.text('Potions'), findsOneWidget);
    });

    testWidgets('ContainerManagementDialog renders correctly',
        (WidgetTester tester) async {
      final dialog = ContainerManagementDialog(
        characterId: 'char-1',
        onDismiss: () {},
        onRename: (_, __) {},
        onDelete: (_) {},
        onAdd: (_, __) {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: dialog,
          ),
        ),
      );

      expect(find.text('Container'), findsOneWidget);
      expect(find.text('Add Container'), findsOneWidget);
    });

    testWidgets('SpellbookManagementScreen renders correctly',
        (WidgetTester tester) async {
      final screen = SpellbookManagementScreen(
        characterId: 'char-1',
        availableSpells: <domain.CharacterSpellReferenceDomainModel>[],
        spellSelectionMode: WizardSpellSelectionMode.prepared,
        selectionLimit: 10,
        onDismiss: () {},
        onSave: (_) {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: screen,
          ),
        ),
      );

      expect(find.text('Prepared Spells'), findsOneWidget);
    });

    testWidgets('PreparedSpellSelectionScreen renders correctly',
        (WidgetTester tester) async {
      final screen = PreparedSpellSelectionScreen(
        characterId: 'char-1',
        availableSpells: <domain.CharacterSpellReferenceDomainModel>[],
        selectionLimit: 10,
        onDismiss: () {},
        onSave: (_) {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: screen,
          ),
        ),
      );

      expect(find.text('Prepared Spells'), findsOneWidget);
    });
  });
}
