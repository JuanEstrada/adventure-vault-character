import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/transfer_to_container_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('transfer dialog exposes a semantics label', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (_) => TransferToContainerDialog(
                    sourceItemId: 'item-1',
                    sourceQuantity: 10,
                    sourceName: 'Torch',
                    onDismiss: () => Navigator.of(context).pop(),
                    onTransfer: (containerId, containerName, quantity) async {},
                    containers: _buildContainers(),
                  ),
                );
              },
              child: const Text('Open transfer dialog'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open transfer dialog'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    final handle = tester.ensureSemantics();
    try {
      expect(
        find.bySemanticsLabel('Transfer to container dialog'),
        findsWidgets,
      );
      expect(find.bySemanticsLabel('Transfer to Container'), findsWidgets);
      expect(
        find.bySemanticsLabel('Source item Torch, quantity 10'),
        findsWidgets,
      );
      expect(find.bySemanticsLabel('Select container'), findsWidgets);
      expect(find.bySemanticsLabel('Container Satchel'), findsWidgets);
      expect(find.bySemanticsLabel('Transfer quantity'), findsWidgets);
      expect(find.bySemanticsLabel('Cancel transfer'), findsWidgets);
      expect(find.bySemanticsLabel('Transfer to container'), findsWidgets);
    } finally {
      handle.dispose();
    }
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
