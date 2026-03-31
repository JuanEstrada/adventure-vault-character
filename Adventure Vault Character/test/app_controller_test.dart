import 'package:adventure_vault_character/src/app/app_controller.dart';
import 'package:adventure_vault_character/src/core/navigation/app_screen.dart';
import 'package:adventure_vault_character/src/features/characters/data/in_memory_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
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
