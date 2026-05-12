import 'package:adventure_vault_character/src/app/app_controller.dart';
import 'package:adventure_vault_character/src/core/navigation/app_screen.dart';
import 'package:adventure_vault_character/src/features/characters/data/in_memory_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/data/in_memory_compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:adventure_vault_character/src/features/settings/data/in_memory_system_settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'initialize uses startup catalog and defers full catalog load',
    () async {
      final repository = _RecordingCompendiumRepository(
        startupCatalog: _buildCatalog(sourceType: 'startup_index'),
        fullCatalog: _buildCatalog(
          sourceType: 'fightclub_xml',
          includeSpell: true,
        ),
      );
      final controller = AppController(
        characterRepository: InMemoryCharacterRepository.empty(
          compendiumRepository: repository,
        ),
        compendiumRepository: repository,
        systemSettingsRepository: InMemorySystemSettingsRepository(),
      );
      addTearDown(controller.dispose);

      await controller.initialize();

      expect(repository.startupLoadCount, 1);
      expect(repository.fullLoadCount, 0);
      expect(controller.state.screen, AppScreen.access);
      expect(
        controller.state.compendiumCatalog?.sourcePolicy.activeSourceType,
        'startup_index',
      );
    },
  );

  test('compendium route requests full catalog lazily', () async {
    final repository = _RecordingCompendiumRepository(
      startupCatalog: _buildCatalog(sourceType: 'startup_index'),
      fullCatalog: _buildCatalog(
        sourceType: 'fightclub_xml',
        includeSpell: true,
      ),
    );
    final controller = AppController(
      characterRepository: InMemoryCharacterRepository.empty(
        compendiumRepository: repository,
      ),
      compendiumRepository: repository,
      systemSettingsRepository: InMemorySystemSettingsRepository(),
    );
    addTearDown(controller.dispose);

    await controller.initialize();
    await controller.openCompendium();

    expect(repository.startupLoadCount, 1);
    expect(repository.fullLoadCount, 1);
    expect(controller.state.screen, AppScreen.compendium);
    expect(controller.state.compendiumCatalog?.spells, isNotEmpty);
    expect(
      controller.state.compendiumCatalog?.sourcePolicy.activeSourceType,
      'fightclub_xml',
    );
  });

  test('create route reuses already loaded full catalog', () async {
    final repository = _RecordingCompendiumRepository(
      startupCatalog: _buildCatalog(sourceType: 'startup_index'),
      fullCatalog: _buildCatalog(
        sourceType: 'fightclub_xml',
        includeSpell: true,
      ),
    );
    final controller = AppController(
      characterRepository: InMemoryCharacterRepository.empty(
        compendiumRepository: repository,
      ),
      compendiumRepository: repository,
      systemSettingsRepository: InMemorySystemSettingsRepository(),
    );
    addTearDown(controller.dispose);

    await controller.initialize();
    await controller.openCompendium();
    await controller.openCreateCharacter();

    expect(repository.fullLoadCount, 1);
    expect(controller.state.screen, AppScreen.createCharacter);
  });

  test(
    'transfer inventory stack routes through the controller mutation path',
    () async {
      final catalog = _buildTransferCatalog();
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(catalog),
      );
      final controller = AppController(
        characterRepository: repository,
        compendiumRepository: InMemoryCompendiumRepository(catalog),
        systemSettingsRepository: InMemorySystemSettingsRepository(),
      );
      addTearDown(controller.dispose);

      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Controller transfer',
          items: <String>['Backpack', '2 Torch'],
        ),
      );
      final sheetBefore = await repository.getCharacterSheetById(summary.id);
      expect(sheetBefore, isNotNull);
      final backpack = sheetBefore!.equipment.items.firstWhere(
        (item) => item.name == 'Backpack',
      );
      final torch = sheetBefore.equipment.items.firstWhere(
        (item) => item.name == 'Torch',
      );

      await controller.openCharacter(summary.id);
      await controller.transferSelectedCharacterInventoryItemToContainer(
        torch.id,
        backpack.id,
        2,
      );

      final visibleSheet = controller.state.selectedCharacterSheet;
      expect(visibleSheet, isNotNull);
      final visibleTorchStacks = visibleSheet!.equipment.items
          .where((item) => item.name == 'Torch')
          .toList(growable: false);
      expect(
        visibleTorchStacks.any(
          (item) =>
              item.containerInventoryItemId == backpack.id &&
              item.quantity == 2,
        ),
        isTrue,
      );

      await controller.openCharacter(summary.id);
      final reopenedSheet = controller.state.selectedCharacterSheet;
      expect(reopenedSheet, isNotNull);
      final reopenedTorchStacks = reopenedSheet!.equipment.items
          .where((item) => item.name == 'Torch')
          .toList(growable: false);
      expect(
        reopenedTorchStacks.any(
          (item) =>
              item.containerInventoryItemId == backpack.id &&
              item.quantity == 2,
        ),
        isTrue,
      );

      final sheetAfter = await repository.getCharacterSheetById(summary.id);
      expect(sheetAfter, isNotNull);
      final torchStacks = sheetAfter!.equipment.items
          .where((item) => item.name == 'Torch')
          .toList(growable: false);
      expect(
        torchStacks.any(
          (item) =>
              item.containerInventoryItemId == backpack.id &&
              item.quantity == 2,
        ),
        isTrue,
      );
      expect(controller.state.errorMessage, isNull);
    },
  );

  test(
    'create container persists across reopen through the controller mutation path',
    () async {
      final catalog = _buildTransferCatalog();
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(catalog),
      );
      final controller = AppController(
        characterRepository: repository,
        compendiumRepository: InMemoryCompendiumRepository(catalog),
        systemSettingsRepository: InMemorySystemSettingsRepository(),
      );
      addTearDown(controller.dispose);

      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Controller create container',
          items: <String>['Backpack', 'Torch'],
        ),
      );

      await controller.openCharacter(summary.id);
      final containerId = await controller.createContainer(
        summary.id,
        'Spell Pouch',
      );

      final visibleSheet = controller.state.selectedCharacterSheet;
      expect(visibleSheet, isNotNull);
      expect(
        visibleSheet!.equipment.items.any(
          (item) => item.id == containerId && item.name == 'Spell Pouch',
        ),
        isTrue,
      );

      await controller.openCharacter(summary.id);
      final reopenedSheet = controller.state.selectedCharacterSheet;
      expect(reopenedSheet, isNotNull);
      expect(
        reopenedSheet!.equipment.items.any(
          (item) => item.id == containerId && item.name == 'Spell Pouch',
        ),
        isTrue,
      );

      final persistedSheet = await repository.getCharacterSheetById(summary.id);
      expect(persistedSheet, isNotNull);
      expect(
        persistedSheet!.equipment.items.any(
          (item) => item.id == containerId && item.name == 'Spell Pouch',
        ),
        isTrue,
      );
      expect(controller.state.errorMessage, isNull);
    },
  );

  test(
    'delete container persists across reopen through the controller mutation path',
    () async {
      final catalog = _buildTransferCatalog();
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(catalog),
      );
      final controller = AppController(
        characterRepository: repository,
        compendiumRepository: InMemoryCompendiumRepository(catalog),
        systemSettingsRepository: InMemorySystemSettingsRepository(),
      );
      addTearDown(controller.dispose);

      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Controller delete container',
          items: <String>['Backpack', 'Torch'],
        ),
      );
      final sheetBefore = await repository.getCharacterSheetById(summary.id);
      expect(sheetBefore, isNotNull);
      final containerId = sheetBefore!.equipment.items
          .firstWhere((item) => item.isContainer)
          .id;

      await controller.openCharacter(summary.id);
      await controller.deleteContainer(containerId);

      final visibleSheet = controller.state.selectedCharacterSheet;
      expect(visibleSheet, isNotNull);
      expect(
        visibleSheet!.equipment.items.any((item) => item.isContainer),
        isFalse,
      );

      await controller.openCharacter(summary.id);
      final reopenedSheet = controller.state.selectedCharacterSheet;
      expect(reopenedSheet, isNotNull);
      expect(
        reopenedSheet!.equipment.items.any((item) => item.isContainer),
        isFalse,
      );

      final persistedSheet = await repository.getCharacterSheetById(summary.id);
      expect(persistedSheet, isNotNull);
      expect(
        persistedSheet!.equipment.items.any((item) => item.isContainer),
        isFalse,
      );
      expect(controller.state.errorMessage, isNull);
    },
  );
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

CompendiumCatalog _buildTransferCatalog() {
  return CompendiumCatalog(
    races: const <String>['Human'],
    classes: const <String>['Wizard'],
    backgrounds: const <CompendiumBackground>[
      CompendiumBackground(
        id: 'acolyte',
        name: 'Acolyte',
        summary: 'Temple acolyte',
        bonuses: <String>['Skills: Insight, Religion'],
        socialPerks: <String>['Shelter of the Faithful'],
      ),
    ],
    narrativeOptionGroups: const <CompendiumNarrativeOptionGroup>[],
    generatedAbilityScoreSet: const <int>[15, 14, 13, 12, 10, 8],
    manualAbilityScoreOptions: const <int>[8, 9, 10, 11, 12, 13, 14, 15],
    characterAdvancement: const <CharacterAdvancementEntry>[
      CharacterAdvancementEntry(
        level: 1,
        experience: 0,
        proficiencyBonus: '+2',
      ),
      CharacterAdvancementEntry(
        level: 2,
        experience: 300,
        proficiencyBonus: '+2',
      ),
    ],
    standardArrayByClass: const <StandardArrayByClassEntry>[
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
    spells: const <CompendiumSpell>[],
    feats: const <CompendiumFeat>[],
    monsters: const <CompendiumMonster>[],
    equipmentSummariesByClass: const <String, EquipmentSummaryViewData>{
      'Wizard': EquipmentSummaryViewData(
        statusLabel: 'MVP minimal',
        description: 'Equipment summary',
        highlightItems: <String>['Torch'],
      ),
    },
    equipmentLoadoutsByClass: const <String, List<CompendiumEquipmentLoadout>>{
      'Wizard': <CompendiumEquipmentLoadout>[
        CompendiumEquipmentLoadout(
          id: 'wizard-focus',
          label: 'Arcane focus kit',
          startingMoneySummary: '0 gp',
          selectedItems: <String>['Torch'],
        ),
      ],
    },
    packStates: const <CompendiumPackStateModel>[
      CompendiumPackStateModel(
        id: 'bundled-base-compendium',
        title: 'Base compendium',
        description: 'Bundled',
        kind: 'bundled_base',
        isFixed: true,
        isActive: true,
      ),
    ],
    sourcePolicy: const CompendiumSourcePolicy(
      activeSourceType: 'startup_index',
      activeSourceLabel: 'startup_index',
      fallbackSourceLabel: 'assets/compendium/catalog.json',
      sections: <CompendiumSectionSourcePolicy>[],
    ),
  );
}

CompendiumCatalog _buildCatalog({
  required String sourceType,
  bool includeSpell = false,
}) {
  return CompendiumCatalog(
    races: const <String>['Human'],
    classes: const <String>['Fighter'],
    backgrounds: const <CompendiumBackground>[
      CompendiumBackground(
        id: 'acolyte',
        name: 'Acolyte',
        summary: 'Temple background.',
        bonuses: <String>['Skills: Insight'],
        socialPerks: <String>['Temple service'],
      ),
    ],
    narrativeOptionGroups: const <CompendiumNarrativeOptionGroup>[],
    generatedAbilityScoreSet: const <int>[15, 14, 13, 12, 10, 8],
    manualAbilityScoreOptions: const <int>[8, 9, 10, 11, 12, 13, 14, 15],
    characterAdvancement: const <CharacterAdvancementEntry>[],
    standardArrayByClass: const <StandardArrayByClassEntry>[],
    spells: includeSpell
        ? const <CompendiumSpell>[
            CompendiumSpell(
              id: 'magic-missile',
              name: 'Magic Missile',
              level: 1,
              school: 'Evocation',
              castingTime: '1 action',
              range: '120 feet',
              components: 'V, S',
              duration: 'Instantaneous',
              classes: <String>['Wizard'],
              description: <String>['Arcane darts.'],
              source: 'SRD',
            ),
          ]
        : const <CompendiumSpell>[],
    feats: const <CompendiumFeat>[],
    monsters: const <CompendiumMonster>[],
    equipmentSummariesByClass: const <String, EquipmentSummaryViewData>{},
    equipmentLoadoutsByClass:
        const <String, List<CompendiumEquipmentLoadout>>{},
    packStates: const <CompendiumPackStateModel>[
      CompendiumPackStateModel(
        id: 'bundled-base-compendium',
        title: 'Base compendium',
        description: 'Bundled',
        kind: 'bundled_base',
        isFixed: true,
        isActive: true,
      ),
    ],
    sourcePolicy: CompendiumSourcePolicy(
      activeSourceType: sourceType,
      activeSourceLabel: sourceType,
      fallbackSourceLabel: 'assets/compendium/catalog.json',
      sections: const <CompendiumSectionSourcePolicy>[],
    ),
  );
}

class _RecordingCompendiumRepository implements CompendiumRepository {
  _RecordingCompendiumRepository({
    required this.startupCatalog,
    required this.fullCatalog,
  });

  final CompendiumCatalog startupCatalog;
  final CompendiumCatalog fullCatalog;

  int startupLoadCount = 0;
  int fullLoadCount = 0;

  @override
  Future<CompendiumCatalog> loadStartupCatalog() async {
    startupLoadCount += 1;
    return startupCatalog;
  }

  @override
  Future<CompendiumCatalog> loadCatalog() async {
    fullLoadCount += 1;
    return fullCatalog;
  }

  @override
  Future<CompendiumCatalog> setPackActive(String packId, bool isActive) async {
    return fullCatalog;
  }

  @override
  Future<CompendiumCatalog> importXmlPack(String rawXml) async {
    return fullCatalog;
  }
}
