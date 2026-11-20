import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/container_management_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'delete confirmation says contents move to the main inventory and dismisses on success',
    (WidgetTester tester) async {
      final deletedContainerIds = <String>[];
      var dismissCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContainerManagementDialog(
              containers: _buildContainers(),
              onDismiss: () => dismissCount++,
              onRename: (containerId, containerName) {},
              onDelete: (containerId) async {
                deletedContainerIds.add(containerId);
              },
              onAdd: (containerName) async => 'char-1-container-2',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(
        find.text(
          'Delete container "Satchel"? Its contents move to the main '
          'inventory.',
        ),
        findsOneWidget,
      );

      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      expect(deletedContainerIds, <String>['satchel']);
      expect(dismissCount, 1);
    },
  );

  testWidgets('rejected deletion is not presented as success', (
    WidgetTester tester,
  ) async {
    var dismissCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ContainerManagementDialog(
            containers: _buildContainers(),
            onDismiss: () => dismissCount++,
            onRename: (containerId, containerName) {},
            onDelete: (containerId) async {
              throw StateError('Container not found for this character.');
            },
            onAdd: (containerName) async => 'char-1-container-2',
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('Select'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    // The management dialog stays open with a visible error instead of
    // silently dismissing as if the deletion had succeeded. The error text
    // appears both in the dialog banner and the field decoration.
    expect(find.text('Manage Containers'), findsOneWidget);
    expect(find.text('Failed to delete container.'), findsWidgets);
    expect(
      find.text(
        'Delete container "Satchel"? Its contents move to the main '
        'inventory.',
      ),
      findsNothing,
    );
    expect(dismissCount, 0);
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
