import 'package:adventure_vault_character/src/features/characters/presentation/container_management_dialog.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'ContainerManagementDialog focuses the new container field on open',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContainerManagementDialog(
              containers: _buildContainers(),
              onDismiss: () {},
              onRename: (containerId, containerName) {},
              onDelete: (containerId) async {},
              onAdd: (containerName) async => 'char-1-container-2',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Manage Containers'), findsOneWidget);
      expect(find.text('Add new container:'), findsOneWidget);
      expect(
        FocusManager.instance.primaryFocus?.debugLabel,
        'ContainerManagementNewContainer',
      );
    },
  );

  testWidgets('ContainerManagementDialog forwards the entered name to onAdd', (
    WidgetTester tester,
  ) async {
    String? addedContainerName;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ContainerManagementDialog(
            containers: _buildContainers(),
            onDismiss: () {},
            onRename: (containerId, containerName) {},
            onDelete: (containerId) async {},
            onAdd: (containerName) async {
              addedContainerName = containerName;
              return 'char-1-container-2';
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Spell Pouch');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(addedContainerName, 'Spell Pouch');
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
