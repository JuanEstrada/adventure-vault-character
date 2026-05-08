import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/transfer_to_container_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TransferToContainerDialog focuses the quantity field on open', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TransferToContainerDialog(
            sourceItemId: 'item-1',
            sourceQuantity: 10,
            sourceName: 'Potions',
            onDismiss: () {},
            onTransfer: (containerId, containerName, quantity) async {},
            containers: _buildContainers(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Transfer to Container'), findsOneWidget);
    expect(find.textContaining('Potions'), findsOneWidget);
    expect(find.text('Satchel'), findsOneWidget);
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
