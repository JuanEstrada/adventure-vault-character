import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_spellbook_domain.dart'
    as domain;
import 'package:adventure_vault_character/src/features/characters/presentation/merge_stack_dialog.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/transfer_to_container_dialog.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/container_management_dialog.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/spellbook_management_screen.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/prepared_spell_selection_screen.dart';

void main() {
  group('P1 Integration Tests', () {
    testWidgets('MergeStackDialog renders correctly', (
      WidgetTester tester,
    ) async {
      final dialog = MergeStackDialog(
        sourceItemId: 'item-1',
        sourceQuantity: 10,
        targetItemId: 'item-2',
        targetQuantity: 5,
        onDismiss: () {},
        onMerge: (targetItemId, mergeQuantity) {},
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: dialog)));

      expect(find.text('Merge Stack'), findsOneWidget);
    });

    testWidgets('TransferToContainerDialog renders correctly', (
      WidgetTester tester,
    ) async {
      final dialog = TransferToContainerDialog(
        sourceItemId: 'item-1',
        sourceQuantity: 10,
        sourceName: 'Potions',
        onDismiss: () {},
        onTransfer: (containerId, containerName, quantity) async {},
        containers: _buildContainers(),
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: dialog)));

      expect(find.text('Transfer to Container'), findsOneWidget);
      expect(find.textContaining('Potions'), findsOneWidget);
    });

    testWidgets('ContainerManagementDialog renders correctly', (
      WidgetTester tester,
    ) async {
      final dialog = ContainerManagementDialog(
        containers: _buildContainers(),
        onDismiss: () {},
        onRename: (containerId, containerName) => {},
        onDelete: (containerId) async {},
        onAdd: (containerName) async => 'char-1-container-2',
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: dialog)));

      expect(find.text('Manage Containers'), findsOneWidget);
      expect(find.text('Add new container:'), findsOneWidget);
    });

    testWidgets('SpellbookManagementScreen renders correctly', (
      WidgetTester tester,
    ) async {
      final screen = SpellbookManagementScreen(
        characterId: 'char-1',
        availableSpells: <domain.CharacterSpellReferenceDomainModel>[],
        spellSelectionMode: domain.WizardSpellSelectionMode.prepared,
        selectionLimit: 10,
        onDismiss: () {},
        onSave: (_) {},
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: screen)));

      expect(find.text('Prepared Spells'), findsOneWidget);
    });

    testWidgets('PreparedSpellSelectionScreen renders correctly', (
      WidgetTester tester,
    ) async {
      final screen = PreparedSpellSelectionScreen(
        characterId: 'char-1',
        availableSpells: <CharacterSpellReferenceDomainModel>[],
        selectionLimit: 10,
        onDismiss: () {},
        onSave: (_) {},
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: screen)));

      expect(find.text('Prepared Spells'), findsOneWidget);
    });
  });
}

List<CharacterEquipmentItemDomainModel> _buildContainers() {
  return <CharacterEquipmentItemDomainModel>[
    const CharacterEquipmentItemDomainModel(
      id: 'satchel',
      name: 'Satchel',
      quantity: 1,
      isEquipped: false,
      isCarried: true,
      isFavorite: false,
      weightPerUnit: 2,
      isContainer: true,
      chargesCurrent: null,
      chargesMax: null,
      containerInventoryItemId: null,
      containerDisplayName: null,
    ),
  ];
}
