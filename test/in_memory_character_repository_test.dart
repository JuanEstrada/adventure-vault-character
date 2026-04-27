import 'package:adventure_vault_character/src/features/characters/data/in_memory_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_inventory_validation_error.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/data/in_memory_compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'spendSpellSlot increments slot usage from zero when no row exists',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Spend from zero',
          items: <String>['Torch'],
        ),
      );

      await repository.spendSpellSlot(summary.id, spellLevel: 1);

      final sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      expect(sheet!.spellcasting, isNotNull);
      final slot = sheet.spellcasting!.slotProgression.firstWhere(
        (entry) => entry.spellLevel == 1,
      );
      expect(slot.slotsExpended, 1);
    },
  );

  test(
    'spendSpellSlot rejects overspend without changing in-memory state',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Overspend in-memory',
          items: <String>['Torch'],
          spellState: const CharacterSpellStateInput(
            selectionMode: CharacterSpellSelectionMode.spellbook,
            selectedSpells: <CharacterSpellSelectionInput>[],
            slotUsages: <CharacterSpellSlotUsageInput>[
              CharacterSpellSlotUsageInput(spellLevel: 1, slotsExpended: 3),
            ],
          ),
        ),
      );

      final sheetBefore = await repository.getCharacterSheetById(summary.id);
      expect(sheetBefore, isNotNull);

      await expectLater(
        repository.spendSpellSlot(summary.id, spellLevel: 1),
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            'Spell slot usage exceeds the derived slot maximum.',
          ),
        ),
      );

      final sheetAfter = await repository.getCharacterSheetById(summary.id);
      expect(sheetAfter, isNotNull);
      final slotBefore = sheetBefore!.spellcasting!.slotProgression.firstWhere(
        (entry) => entry.spellLevel == 1,
      );
      final slotAfter = sheetAfter!.spellcasting!.slotProgression.firstWhere(
        (entry) => entry.spellLevel == 1,
      );
      expect(slotAfter.slotsExpended, slotBefore.slotsExpended);
    },
  );

  test(
    'spendInventoryItemQuantity rejects non-positive amount without state change',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Invalid quantity',
          items: <String>['3 Torch'],
        ),
      );
      final torchBefore = await _torchFor(repository, summary.id);

      await expectLater(
        repository.spendInventoryItemQuantity(
          summary.id,
          torchBefore.id,
          amount: 0,
        ),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'invalid_quantity',
          ),
        ),
      );

      final torchAfter = await _torchFor(repository, summary.id);
      expect(torchAfter.quantity, torchBefore.quantity);
    },
  );

  test(
    'spendInventoryItemQuantity rejects insufficient quantity without state change',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Insufficient quantity',
          items: <String>['Torch'],
        ),
      );
      final torchBefore = await _torchFor(repository, summary.id);

      await expectLater(
        repository.spendInventoryItemQuantity(
          summary.id,
          torchBefore.id,
          amount: 2,
        ),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'insufficient_quantity',
          ),
        ),
      );

      final torchAfter = await _torchFor(repository, summary.id);
      expect(torchAfter.quantity, torchBefore.quantity);
    },
  );

  test(
    'splitInventoryItemStack creates a deterministic second stack',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(name: 'Split stack', items: <String>['4 Torch']),
      );
      final sourceBefore = await _torchFor(repository, summary.id);

      final splitId = await repository.splitInventoryItemStack(
        summary.id,
        sourceBefore.id,
        quantity: 1,
      );

      final sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      final torchStacks = sheet!.equipment.items
          .where((item) => item.name == 'Torch')
          .toList(growable: false);
      expect(torchStacks.length, 2);
      expect(
        torchStacks.fold<int>(0, (total, item) => total + item.quantity),
        4,
      );
      expect(
        torchStacks.any((item) => item.id == splitId && item.quantity == 1),
        isTrue,
      );
    },
  );

  test(
    'splitInventoryItemStack rejects invalid splits without state change',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Invalid split in-memory',
          items: <String>['4 Torch', 'Quarterstaff'],
        ),
      );

      final sheetBefore = await repository.getCharacterSheetById(summary.id);
      expect(sheetBefore, isNotNull);
      final torch = sheetBefore!.equipment.items.firstWhere(
        (item) => item.name == 'Torch',
      );
      final quarterstaff = sheetBefore.equipment.items.firstWhere(
        (item) => item.name == 'Quarterstaff',
      );
      final inventorySnapshotBefore = <String, int>{
        for (final item in sheetBefore.equipment.items) item.id: item.quantity,
      };

      await expectLater(
        repository.splitInventoryItemStack(summary.id, torch.id, quantity: 0),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'invalid_quantity',
          ),
        ),
      );
      await expectLater(
        repository.splitInventoryItemStack(summary.id, torch.id, quantity: 4),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'insufficient_quantity',
          ),
        ),
      );
      await expectLater(
        repository.splitInventoryItemStack(
          summary.id,
          quarterstaff.id,
          quantity: 1,
        ),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'invalid_stack_state',
          ),
        ),
      );

      final sheetAfter = await repository.getCharacterSheetById(summary.id);
      expect(sheetAfter, isNotNull);
      final inventorySnapshotAfter = <String, int>{
        for (final item in sheetAfter!.equipment.items) item.id: item.quantity,
      };
      expect(inventorySnapshotAfter, inventorySnapshotBefore);
    },
  );

  test('mergeInventoryItemStacks retires fully merged source stack', () async {
    final repository = InMemoryCharacterRepository.empty(
      compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
    );
    final summary = await repository.createCharacter(
      _createCharacterInput(
        name: 'Merge stack',
        items: <String>['Torch', '2 Torch'],
      ),
    );

    final sheetBefore = await repository.getCharacterSheetById(summary.id);
    expect(sheetBefore, isNotNull);
    final torchStacks = sheetBefore!.equipment.items
        .where((item) => item.name == 'Torch')
        .toList(growable: false);
    final source = torchStacks.firstWhere((item) => item.quantity == 1);
    final target = torchStacks.firstWhere((item) => item.quantity == 2);

    await repository.mergeInventoryItemStacks(summary.id, source.id, target.id);

    final sheetAfter = await repository.getCharacterSheetById(summary.id);
    expect(sheetAfter, isNotNull);
    final remainingTorchStacks = sheetAfter!.equipment.items
        .where((item) => item.name == 'Torch')
        .toList(growable: false);
    expect(remainingTorchStacks.length, 1);
    expect(remainingTorchStacks.single.quantity, 3);
  });

  test(
    'mergeInventoryItemStacks rejects incompatible stacks without state change',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Invalid merge in-memory',
          items: <String>['Torch', 'Quarterstaff'],
        ),
      );

      final sheetBefore = await repository.getCharacterSheetById(summary.id);
      expect(sheetBefore, isNotNull);
      final torch = sheetBefore!.equipment.items.firstWhere(
        (item) => item.name == 'Torch',
      );
      final quarterstaff = sheetBefore.equipment.items.firstWhere(
        (item) => item.name == 'Quarterstaff',
      );

      await expectLater(
        repository.mergeInventoryItemStacks(
          summary.id,
          torch.id,
          quarterstaff.id,
        ),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'invalid_stack_state',
          ),
        ),
      );

      final sheetAfter = await repository.getCharacterSheetById(summary.id);
      expect(sheetAfter, isNotNull);
      expect(
        sheetAfter!.equipment.items
            .firstWhere((item) => item.id == torch.id)
            .quantity,
        torch.quantity,
      );
      expect(
        sheetAfter.equipment.items
            .firstWhere((item) => item.id == quarterstaff.id)
            .quantity,
        quarterstaff.quantity,
      );
    },
  );

  test(
    'transferInventoryItemStackToContainer moves whole stack into valid container',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Transfer whole stack in-memory',
          items: <String>['Backpack', 'Torch'],
        ),
      );

      var sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      final backpack = sheet!.equipment.items.firstWhere(
        (item) => item.name == 'Backpack',
      );
      final torch = sheet.equipment.items.firstWhere(
        (item) => item.name == 'Torch',
      );

      final transferredId = await repository
          .transferInventoryItemStackToContainer(
            summary.id,
            torch.id,
            targetContainerInventoryItemId: backpack.id,
          );

      expect(transferredId, torch.id);

      sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      final torchStacks = sheet!.equipment.items
          .where((item) => item.name == 'Torch')
          .toList(growable: false);
      expect(torchStacks.length, 1);
      expect(torchStacks.single.id, torch.id);
      expect(torchStacks.single.quantity, 1);
      expect(torchStacks.single.containerInventoryItemId, backpack.id);
    },
  );

  test(
    'transferInventoryItemStackToContainer splits source when no merge target exists',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Transfer split in-memory',
          items: <String>['Backpack', '4 Torch'],
        ),
      );

      var sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      final backpack = sheet!.equipment.items.firstWhere(
        (item) => item.name == 'Backpack',
      );
      final source = sheet.equipment.items.firstWhere(
        (item) => item.name == 'Torch',
      );

      final transferredId = await repository
          .transferInventoryItemStackToContainer(
            summary.id,
            source.id,
            targetContainerInventoryItemId: backpack.id,
            quantity: 2,
          );

      expect(transferredId, isNot(source.id));

      sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      final torchStacks = sheet!.equipment.items
          .where((item) => item.name == 'Torch')
          .toList(growable: false);
      expect(torchStacks.length, 2);

      final updatedSource = torchStacks.firstWhere(
        (item) => item.id == source.id,
      );
      final createdTarget = torchStacks.firstWhere(
        (item) => item.id == transferredId,
      );
      expect(updatedSource.quantity, 2);
      expect(updatedSource.containerInventoryItemId, isNull);
      expect(createdTarget.quantity, 2);
      expect(createdTarget.containerInventoryItemId, backpack.id);
    },
  );

  test(
    'transferInventoryItemStackToContainer rejects non-container target without state change',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Transfer invalid target in-memory',
          items: <String>['Torch', 'Quarterstaff'],
        ),
      );

      var sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      final torch = sheet!.equipment.items.firstWhere(
        (item) => item.name == 'Torch',
      );
      final quarterstaff = sheet.equipment.items.firstWhere(
        (item) => item.name == 'Quarterstaff',
      );
      final snapshotBefore = <String, (int, String?, bool)>{
        for (final item in sheet.equipment.items)
          item.id: (
            item.quantity,
            item.containerInventoryItemId,
            item.isCarried,
          ),
      };

      await expectLater(
        repository.transferInventoryItemStackToContainer(
          summary.id,
          torch.id,
          targetContainerInventoryItemId: quarterstaff.id,
        ),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'invalid_target',
          ),
        ),
      );

      final sheetAfter = await repository.getCharacterSheetById(summary.id);
      expect(sheetAfter, isNotNull);
      final snapshotAfter = <String, (int, String?, bool)>{
        for (final item in sheetAfter!.equipment.items)
          item.id: (
            item.quantity,
            item.containerInventoryItemId,
            item.isCarried,
          ),
      };
      expect(snapshotAfter, snapshotBefore);
    },
  );

  test(
    'transferInventoryItemStackToContainer merges compatible partial transfer',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Transfer partial in-memory',
          items: <String>['Backpack', '4 Torch', 'Torch'],
        ),
      );

      var sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      final backpack = sheet!.equipment.items.firstWhere(
        (item) => item.name == 'Backpack',
      );
      final torchStacks =
          sheet.equipment.items
              .where((item) => item.name == 'Torch')
              .toList(growable: false)
            ..sort((left, right) => right.quantity.compareTo(left.quantity));
      final source = torchStacks.first;
      final target = torchStacks.last;

      await repository.setInventoryItemContainer(
        summary.id,
        target.id,
        backpack.id,
      );
      final transferredId = await repository
          .transferInventoryItemStackToContainer(
            summary.id,
            source.id,
            targetContainerInventoryItemId: backpack.id,
            quantity: 2,
          );

      expect(transferredId, target.id);
      sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      final updatedSource = sheet!.equipment.items.firstWhere(
        (item) => item.id == source.id,
      );
      final updatedTarget = sheet.equipment.items.firstWhere(
        (item) => item.id == target.id,
      );
      expect(updatedSource.quantity, 2);
      expect(updatedSource.containerInventoryItemId, isNull);
      expect(updatedTarget.quantity, 3);
      expect(updatedTarget.containerInventoryItemId, backpack.id);
    },
  );

  test(
    'transferInventoryItemStackToContainer rejects incompatible target stack without state change',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Transfer reject in-memory',
          items: <String>['Backpack', '4 Torch', 'Torch'],
        ),
      );

      var sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      final backpack = sheet!.equipment.items.firstWhere(
        (item) => item.name == 'Backpack',
      );
      final torchStacks =
          sheet.equipment.items
              .where((item) => item.name == 'Torch')
              .toList(growable: false)
            ..sort((left, right) => right.quantity.compareTo(left.quantity));
      final source = torchStacks.first;
      final target = torchStacks.last;

      await repository.setInventoryItemContainer(
        summary.id,
        target.id,
        backpack.id,
      );
      await repository.setInventoryItemCarried(summary.id, target.id, false);

      sheet = await repository.getCharacterSheetById(summary.id);
      final snapshotBefore = <String, (int, String?, bool)>{
        for (final item in sheet!.equipment.items)
          item.id: (
            item.quantity,
            item.containerInventoryItemId,
            item.isCarried,
          ),
      };

      await expectLater(
        repository.transferInventoryItemStackToContainer(
          summary.id,
          source.id,
          targetContainerInventoryItemId: backpack.id,
          quantity: 2,
        ),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'invalid_stack_state',
          ),
        ),
      );

      final sheetAfter = await repository.getCharacterSheetById(summary.id);
      expect(sheetAfter, isNotNull);
      final snapshotAfter = <String, (int, String?, bool)>{
        for (final item in sheetAfter!.equipment.items)
          item.id: (
            item.quantity,
            item.containerInventoryItemId,
            item.isCarried,
          ),
      };
      expect(snapshotAfter, snapshotBefore);
    },
  );

  test(
    'transferInventoryItemStackToContainer rejects mixed same-item target stack states without state change',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Transfer mixed stack state in-memory',
          items: <String>['Backpack', '4 Torch', 'Torch', 'Torch'],
        ),
      );

      var sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      final backpack = sheet!.equipment.items.firstWhere(
        (item) => item.name == 'Backpack',
      );
      final torchStacks =
          sheet.equipment.items
              .where((item) => item.name == 'Torch')
              .toList(growable: false)
            ..sort((left, right) => right.quantity.compareTo(left.quantity));
      final source = torchStacks.first;
      final compatibleTarget = torchStacks[1];
      final incompatibleTarget = torchStacks[2];

      await repository.setInventoryItemContainer(
        summary.id,
        compatibleTarget.id,
        backpack.id,
      );
      await repository.setInventoryItemContainer(
        summary.id,
        incompatibleTarget.id,
        backpack.id,
      );
      await repository.setInventoryItemCarried(
        summary.id,
        incompatibleTarget.id,
        false,
      );

      sheet = await repository.getCharacterSheetById(summary.id);
      final snapshotBefore = <String, (int, String?, bool)>{
        for (final item in sheet!.equipment.items)
          item.id: (
            item.quantity,
            item.containerInventoryItemId,
            item.isCarried,
          ),
      };

      await expectLater(
        repository.transferInventoryItemStackToContainer(
          summary.id,
          source.id,
          targetContainerInventoryItemId: backpack.id,
          quantity: 2,
        ),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'invalid_stack_state',
          ),
        ),
      );

      final sheetAfter = await repository.getCharacterSheetById(summary.id);
      expect(sheetAfter, isNotNull);
      final snapshotAfter = <String, (int, String?, bool)>{
        for (final item in sheetAfter!.equipment.items)
          item.id: (
            item.quantity,
            item.containerInventoryItemId,
            item.isCarried,
          ),
      };
      expect(snapshotAfter, snapshotBefore);
    },
  );

  test(
    'transferInventoryItemStackToContainer rejects capacity overflow without state change',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Transfer overflow in-memory',
          items: <String>['Backpack', '31 Torch'],
        ),
      );

      final sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      final backpack = sheet!.equipment.items.firstWhere(
        (item) => item.name == 'Backpack',
      );
      final torch = sheet.equipment.items.firstWhere(
        (item) => item.name == 'Torch',
      );
      final snapshotBefore = <String, (int, String?, bool)>{
        for (final item in sheet.equipment.items)
          item.id: (
            item.quantity,
            item.containerInventoryItemId,
            item.isCarried,
          ),
      };

      await expectLater(
        repository.transferInventoryItemStackToContainer(
          summary.id,
          torch.id,
          targetContainerInventoryItemId: backpack.id,
        ),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'capacity_exceeded',
          ),
        ),
      );

      final sheetAfter = await repository.getCharacterSheetById(summary.id);
      expect(sheetAfter, isNotNull);
      final snapshotAfter = <String, (int, String?, bool)>{
        for (final item in sheetAfter!.equipment.items)
          item.id: (
            item.quantity,
            item.containerInventoryItemId,
            item.isCarried,
          ),
      };
      expect(snapshotAfter, snapshotBefore);
    },
  );

  test(
    'transferInventoryItemStackToContainer rejects cycle violation without state change',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Transfer cycle in-memory',
          items: <String>['Flask bag', 'Flask bag'],
        ),
      );

      var sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      final flaskBags =
          sheet!.equipment.items
              .where((item) => item.name == 'Flask bag')
              .toList(growable: false)
            ..sort((left, right) => left.id.compareTo(right.id));
      final source = flaskBags.first;
      final target = flaskBags.last;
      await repository.setInventoryItemContainer(
        summary.id,
        target.id,
        source.id,
      );

      sheet = await repository.getCharacterSheetById(summary.id);
      final snapshotBefore = <String, (int, String?, bool)>{
        for (final item in sheet!.equipment.items)
          item.id: (
            item.quantity,
            item.containerInventoryItemId,
            item.isCarried,
          ),
      };

      await expectLater(
        repository.transferInventoryItemStackToContainer(
          summary.id,
          source.id,
          targetContainerInventoryItemId: target.id,
        ),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'invalid_structure',
          ),
        ),
      );

      final sheetAfter = await repository.getCharacterSheetById(summary.id);
      expect(sheetAfter, isNotNull);
      final snapshotAfter = <String, (int, String?, bool)>{
        for (final item in sheetAfter!.equipment.items)
          item.id: (
            item.quantity,
            item.containerInventoryItemId,
            item.isCarried,
          ),
      };
      expect(snapshotAfter, snapshotBefore);
    },
  );

  test(
    'transferInventoryItemStackToContainer rejects depth violation without state change',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Transfer depth in-memory',
          items: <String>[
            'Flask bag',
            'Backpack',
            'Scholar pack',
            'Explorer pack',
            'Priest pack',
            'Burglar pack',
            'Dungeoneer pack',
          ],
        ),
      );

      var sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      final itemByName = <String, String>{
        for (final item in sheet!.equipment.items) item.name: item.id,
      };
      final flaskBagId = itemByName['Flask bag']!;
      final backpackId = itemByName['Backpack']!;
      final scholarPackId = itemByName['Scholar pack']!;
      final explorerPackId = itemByName['Explorer pack']!;
      final priestPackId = itemByName['Priest pack']!;
      final burglarPackId = itemByName['Burglar pack']!;
      final dungeoneerPackId = itemByName['Dungeoneer pack']!;

      await repository.setInventoryItemContainer(
        summary.id,
        backpackId,
        flaskBagId,
      );
      await repository.setInventoryItemContainer(
        summary.id,
        scholarPackId,
        backpackId,
      );
      await repository.setInventoryItemContainer(
        summary.id,
        explorerPackId,
        scholarPackId,
      );
      await repository.setInventoryItemContainer(
        summary.id,
        priestPackId,
        explorerPackId,
      );
      await repository.setInventoryItemContainer(
        summary.id,
        dungeoneerPackId,
        priestPackId,
      );

      sheet = await repository.getCharacterSheetById(summary.id);
      final snapshotBefore = <String, (int, String?, bool)>{
        for (final item in sheet!.equipment.items)
          item.id: (
            item.quantity,
            item.containerInventoryItemId,
            item.isCarried,
          ),
      };

      await expectLater(
        repository.transferInventoryItemStackToContainer(
          summary.id,
          flaskBagId,
          targetContainerInventoryItemId: burglarPackId,
        ),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'invalid_structure',
          ),
        ),
      );

      final sheetAfter = await repository.getCharacterSheetById(summary.id);
      expect(sheetAfter, isNotNull);
      final snapshotAfter = <String, (int, String?, bool)>{
        for (final item in sheetAfter!.equipment.items)
          item.id: (
            item.quantity,
            item.containerInventoryItemId,
            item.isCarried,
          ),
      };
      expect(snapshotAfter, snapshotBefore);
    },
  );

  test(
    'retireZeroQuantityInventoryStacks removes zero-quantity rows',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Retire zero',
          items: <String>['Torch', 'Quarterstaff'],
        ),
      );

      final sheetBefore = await repository.getCharacterSheetById(summary.id);
      expect(sheetBefore, isNotNull);
      final torch = sheetBefore!.equipment.items.firstWhere(
        (item) => item.name == 'Torch',
      );

      await repository.setInventoryItemQuantity(summary.id, torch.id, 0);
      final removed = await repository.retireZeroQuantityInventoryStacks(
        summary.id,
      );
      expect(removed, 1);

      final sheetAfter = await repository.getCharacterSheetById(summary.id);
      expect(sheetAfter, isNotNull);
      expect(
        sheetAfter!.equipment.items.any((item) => item.name == 'Torch'),
        isFalse,
      );
    },
  );
}

Future<dynamic> _torchFor(
  InMemoryCharacterRepository repository,
  String characterId,
) async {
  final sheet = await repository.getCharacterSheetById(characterId);
  expect(sheet, isNotNull);
  return sheet!.equipment.items.firstWhere((item) => item.name == 'Torch');
}

CreateCharacterInput _createCharacterInput({
  required String name,
  required List<String> items,
  CharacterSpellStateInput spellState = const CharacterSpellStateInput(
    selectionMode: CharacterSpellSelectionMode.spellbook,
    selectedSpells: <CharacterSpellSelectionInput>[],
    slotUsages: <CharacterSpellSlotUsageInput>[],
  ),
}) {
  return CreateCharacterInput(
    name: name,
    raceName: 'Human',
    backgroundId: 'acolyte',
    backgroundName: 'Acolyte',
    backgroundSummary: 'Temple acolyte',
    abilityScoreMethod: 'manualPointAllocation',
    abilityScoreProvenance: 'method=manualPointAllocation',
    strength: 10,
    dexterity: 12,
    constitution: 13,
    intelligence: 10,
    wisdom: 14,
    charisma: 8,
    className: 'Wizard',
    level: 2,
    experience: 300,
    equipmentLoadoutId: 'wizard-focus',
    equipmentLoadoutLabel: 'Arcane focus kit',
    startingMoneySummary: '0 gp',
    selectedEquipmentItems: items,
    currentHitPoints: 12,
    maximumHitPoints: 12,
    temporaryHitPoints: 0,
    spellState: spellState,
    finishingDetails: const CharacterFinishingDetailsInput(
      appearanceDetails: '',
      narrativeNotes: '',
      narrativeSelections: <NarrativeSelection>[
        NarrativeSelection.empty(NarrativeFieldKey.alignment),
        NarrativeSelection.empty(NarrativeFieldKey.faction),
        NarrativeSelection.empty(NarrativeFieldKey.personalityTraits),
        NarrativeSelection.empty(NarrativeFieldKey.ideals),
        NarrativeSelection.empty(NarrativeFieldKey.bonds),
        NarrativeSelection.empty(NarrativeFieldKey.flaws),
      ],
    ),
  );
}

const _testCatalog = CompendiumCatalog(
  races: <String>['Human'],
  classes: <String>['Wizard'],
  backgrounds: <CompendiumBackground>[
    CompendiumBackground(
      id: 'acolyte',
      name: 'Acolyte',
      summary: 'Temple acolyte',
      bonuses: <String>['Skills: Insight, Religion'],
      socialPerks: <String>['Shelter of the Faithful'],
    ),
  ],
  narrativeOptionGroups: <CompendiumNarrativeOptionGroup>[],
  generatedAbilityScoreSet: <int>[15, 14, 13, 12, 10, 8],
  manualAbilityScoreOptions: <int>[8, 9, 10, 11, 12, 13, 14, 15],
  characterAdvancement: <CharacterAdvancementEntry>[
    CharacterAdvancementEntry(level: 1, experience: 0, proficiencyBonus: '+2'),
    CharacterAdvancementEntry(
      level: 2,
      experience: 300,
      proficiencyBonus: '+2',
    ),
  ],
  standardArrayByClass: <StandardArrayByClassEntry>[
    StandardArrayByClassEntry(
      classId: 'wizard',
      className: 'Wizard',
      strength: 8,
      dexterity: 12,
      constitution: 13,
      intelligence: 15,
      wisdom: 14,
      charisma: 10,
    ),
  ],
  spells: <CompendiumSpell>[],
  feats: <CompendiumFeat>[],
  monsters: <CompendiumMonster>[],
  equipmentSummariesByClass: <String, EquipmentSummaryViewData>{
    'Wizard': EquipmentSummaryViewData(
      statusLabel: 'MVP minimal',
      description: 'Equipment summary',
      highlightItems: <String>['Torch'],
    ),
  },
  equipmentLoadoutsByClass: <String, List<CompendiumEquipmentLoadout>>{
    'Wizard': <CompendiumEquipmentLoadout>[
      CompendiumEquipmentLoadout(
        id: 'wizard-focus',
        label: 'Arcane focus kit',
        startingMoneySummary: '0 gp',
        selectedItems: <String>['Torch'],
      ),
    ],
  },
);
