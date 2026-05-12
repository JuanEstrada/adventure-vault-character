import 'dart:async';

import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/container_management_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Dialog shows "No containers found" when list is empty', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ContainerManagementDialog(
          containers: [],
          onDismiss: () {},
          onRename: (containerId, containerName) {},
          onDelete: (containerId) async {},
          onAdd: (containerName) async => 'char-1-container-$containerName',
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No containers found'), findsOneWidget);
  });

  testWidgets('Dialog displays container count preview on add', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ContainerManagementDialog(
          containers: _buildContainers(),
          onDismiss: () {},
          onRename: (containerId, containerName) {},
          onDelete: (containerId) async {},
          onAdd: (containerName) async => 'char-1-container-$containerName',
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('After: 2 container(s)'), findsOneWidget);
  });

  testWidgets('Container list updates when widget is replaced', (
    WidgetTester tester,
  ) async {
    List<CharacterEquipmentItemDomainModel> initialContainers =
        _buildContainers();

    await tester.pumpWidget(
      MaterialApp(
        home: ContainerManagementDialog(
          containers: initialContainers,
          onDismiss: () {},
          onRename: (containerId, containerName) {},
          onDelete: (containerId) async {},
          onAdd: (containerName) async => 'char-1-container-$containerName',
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Satchel'), findsOneWidget);

    List<CharacterEquipmentItemDomainModel> updatedContainers = [
      ...initialContainers,
      const CharacterEquipmentItemDomainModel(
        id: 'test-container',
        name: 'Test Container',
        quantity: 1,
        isEquipped: false,
        isCarried: true,
        isFavorite: false,
        weightPerUnit: 1,
        isContainer: true,
        chargesCurrent: null,
        chargesMax: null,
        containerInventoryItemId: null,
        containerDisplayName: null,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: ContainerManagementDialog(
          containers: updatedContainers,
          onDismiss: () {},
          onRename: (containerId, containerName) {},
          onDelete: (containerId) async {},
          onAdd: (containerName) async => 'char-1-container-$containerName',
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Test Container'), findsOneWidget);
  });

  testWidgets('Container selection changes dialog state', (
    WidgetTester tester,
  ) async {
    bool renameCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: ContainerManagementDialog(
          containers: _buildContainers(),
          onDismiss: () {},
          onRename: (containerId, containerName) {
            renameCalled = true;
          },
          onDelete: (containerId) async {},
          onAdd: (containerName) async => 'char-1-container-$containerName',
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Select the specific container via its explicit button.
    final selectButton = find.byKey(const Key('SelectContainer-satchel'));
    await tester.tap(selectButton);
    await tester.pumpAndSettle();

    expect(find.text('Selected container: Satchel'), findsOneWidget);

    // Tap the Rename button (should be enabled after selection)
    final renameButton = find.byKey(const Key('Rename container'));
    await tester.tap(renameButton);
    await tester.pumpAndSettle();

    expect(renameCalled, isTrue);
  });

  testWidgets('Rename container waits for callback before dismissing', (
    WidgetTester tester,
  ) async {
    final renameCompleter = Completer<void>();
    var dismissed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: ContainerManagementDialog(
          containers: _buildContainers(),
          onDismiss: () {
            dismissed = true;
          },
          onRename: (containerId, containerName) {
            return renameCompleter.future;
          },
          onDelete: (containerId) async {},
          onAdd: (containerName) async => 'char-1-container-$containerName',
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('SelectContainer-satchel')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('Rename container')));
    await tester.pump();

    expect(dismissed, isFalse);

    renameCompleter.complete();
    await tester.pumpAndSettle();

    expect(dismissed, isTrue);
  });

  testWidgets('Add container with empty name is skipped', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ContainerManagementDialog(
          containers: _buildContainers(),
          onDismiss: () {},
          onRename: (containerId, containerName) {},
          onDelete: (containerId) async {},
          onAdd: (containerName) async {
            throw Exception('Should not be called with empty name');
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('New container name')),
      'New Container',
    );
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(find.text('New Container'), findsOneWidget);
  });
}

List<CharacterEquipmentItemDomainModel> _buildContainers() {
  return const [
    CharacterEquipmentItemDomainModel(
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
