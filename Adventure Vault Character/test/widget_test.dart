import 'package:adventure_vault_character/src/app/adventure_vault_app.dart';
import 'package:adventure_vault_character/src/features/characters/data/in_memory_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/data/in_memory_compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('boot flow reaches access and main menu offline path', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      AdventureVaultApp(
        characterRepository: InMemoryCharacterRepository.empty(
          compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
        ),
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Continue offline'), findsOneWidget);

    await tester.ensureVisible(find.text('Continue offline'));
    await tester.tap(find.text('Continue offline'));
    await tester.pumpAndSettle();

    expect(find.text('Compendium'), findsOneWidget);
    expect(find.text('Create character'), findsOneWidget);
    expect(find.text('Active compendium'), findsOneWidget);
    expect(
      find.textContaining('FightClub XML asset bundle with SRD 5.5e core data'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Rules baseline: SRD 5.5e FightClub XML'),
      findsOneWidget,
    );
    expect(
      find.textContaining('No saved characters are available yet'),
      findsOneWidget,
    );
  });

  testWidgets('main menu opens compendium screen with source details', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 2200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      AdventureVaultApp(
        characterRepository: InMemoryCharacterRepository.empty(
          compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
        ),
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Continue offline'));
    await tester.tap(find.text('Continue offline'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Compendium'));
    await tester.pumpAndSettle();

    expect(find.text('Content management'), findsOneWidget);
    expect(find.text('Bundled base'), findsOneWidget);
    expect(find.text('Always active'), findsOneWidget);
    expect(find.text('Imported packs'), findsOneWidget);
    expect(find.text('1 active'), findsOneWidget);
    expect(find.text('Import XML'), findsOneWidget);
    expect(find.text('Manage packs'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.widgetWithText(OutlinedButton, 'Import XML'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(OutlinedButton, 'Import XML'));
    await tester.pumpAndSettle();
    expect(find.text('Local pack registration'), findsOneWidget);

    await tester.enterText(find.byType(TextField), _importFixture);
    await tester.tap(find.widgetWithText(FilledButton, 'Register XML'));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'XML registered locally. You can now manage it as an optional pack.',
      ),
      findsOneWidget,
    );
    expect(
      find.text('Imported Acolyte Expansion • 1 compatible entries detected'),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(OutlinedButton, 'Open packs'));
    await tester.pumpAndSettle();

    expect(find.text('Manage packs'), findsOneWidget);
    expect(find.text('Base compendium'), findsOneWidget);
    expect(find.text('Fixed active'), findsOneWidget);
    expect(find.text('Packs opcionales importados'), findsOneWidget);
    expect(find.text('Active'), findsNWidgets(2));
    expect(find.text('Imported Acolyte Expansion'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('2 active'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Narrative options'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(
      find.textContaining(
        'Imported XML packs active: Imported Acolyte Expansion (1).',
      ),
      findsWidgets,
    );
    await tester.scrollUntilVisible(
      find.text('Narrative options'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(
      find.textContaining(
        'Imported XML packs active: Imported Acolyte Expansion (1).',
      ),
      findsNWidgets(2),
    );

    await tester.scrollUntilVisible(
      find.widgetWithText(OutlinedButton, 'Manage packs'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(OutlinedButton, 'Manage packs'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Switch).at(1));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Switch).at(2));
    await tester.pumpAndSettle();

    expect(find.text('Inactive'), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('0 active'), findsOneWidget);
    expect(find.textContaining('Imported XML packs active:'), findsNothing);

    await tester.scrollUntilVisible(
      find.text('Current coverage'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Current coverage'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Narrative options'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Narrative options'), findsOneWidget);
    expect(find.textContaining('backgrounds-phb.xml'), findsOneWidget);
    expect(find.textContaining('backgrounds-scag.xml'), findsNothing);
  });

  testWidgets('create flow saves character and opens sheet', (
    WidgetTester tester,
  ) async {
    final compendiumRepository = InMemoryCompendiumRepository(_testCatalog);
    final repository = InMemoryCharacterRepository.empty(
      compendiumRepository: compendiumRepository,
    );
    await tester.binding.setSurfaceSize(const Size(1200, 4200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      AdventureVaultApp(
        characterRepository: repository,
        compendiumRepository: compendiumRepository,
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Continue offline'));
    await tester.tap(find.text('Continue offline'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Create character'));
    await tester.tap(find.text('Create character'));
    await tester.pumpAndSettle();

    expect(find.text('Background'), findsWidgets);
    expect(find.text('Ability Scores'), findsOneWidget);
    expect(find.text('Equipment'), findsWidgets);
    expect(find.text('Finishing details'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'Aelar');
    await tester.scrollUntilVisible(
      find.widgetWithText(FilledButton, 'Save draft').first,
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save draft'));
    await tester.pumpAndSettle();

    expect(find.text('Resumen'), findsOneWidget);
    expect(find.text('Aelar'), findsWidgets);
    expect(find.textContaining('Human'), findsWidgets);
    expect(find.textContaining('Fighter'), findsWidgets);
    expect(find.text('Generated set assignment'), findsOneWidget);
    expect(find.text('Acolyte'), findsOneWidget);
    expect(find.text('Combat'), findsWidgets);
    expect(find.text('Current HP'), findsOneWidget);
    expect(find.text('Equipment'), findsWidgets);
    expect(find.text('Chain mail starter kit'), findsOneWidget);
    expect(find.text('Starting money'), findsOneWidget);
    expect(find.text('Strength'), findsWidgets);
    expect(find.text('Spell save DC'), findsNothing);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Aelar'), findsOneWidget);
    expect(find.textContaining('Human  •  Fighter  •  Lv 1'), findsOneWidget);
  });

  testWidgets('generated ability set updates when class changes', (
    WidgetTester tester,
  ) async {
    final compendiumRepository = InMemoryCompendiumRepository(_testCatalog);
    final repository = InMemoryCharacterRepository.empty(
      compendiumRepository: compendiumRepository,
    );
    await tester.binding.setSurfaceSize(const Size(1200, 4200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      AdventureVaultApp(
        characterRepository: repository,
        compendiumRepository: compendiumRepository,
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Continue offline'));
    await tester.tap(find.text('Continue offline'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Create character'));
    await tester.tap(find.text('Create character'));
    await tester.pumpAndSettle();

    final classField = find.byWidgetPredicate(
      (widget) =>
          widget is DropdownButtonFormField<String> &&
          widget.decoration.labelText == 'Clase',
    );

    await tester.enterText(find.byType(TextFormField).first, 'Meris');
    await tester.tap(classField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Wizard').last);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Spells'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Spellbook spells • 0 / 3 selected'), findsOneWidget);
    await tester.tap(find.text('Magic Missile (Level 1)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Magic Missile (Level 1)').last);
    await tester.pumpAndSettle();
    expect(find.text('Spellbook spells • 1 / 3 selected'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.widgetWithText(FilledButton, 'Save draft').first,
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save draft'));
    await tester.pumpAndSettle();

    final summaries = await repository.getCharacterSummaries();
    final character = await repository.getCharacterSheetById(
      summaries.single.id,
    );

    expect(character, isNotNull);
    final savedCharacter = character!;
    expect(savedCharacter.identity.className, 'Wizard');
    expect(
      savedCharacter.abilities.entries
          .firstWhere((row) => row.label == 'Strength')
          .score,
      8,
    );
    expect(
      savedCharacter.abilities.entries
          .firstWhere((row) => row.label == 'Intelligence')
          .score,
      15,
    );
    expect(savedCharacter.equipment.selectedEquipmentLabel, 'Arcane focus kit');
    expect(savedCharacter.spellcasting, isNotNull);
    expect(savedCharacter.spellcasting!.abilityLabel, 'Intelligence');
    expect(savedCharacter.spellcasting!.spellSaveDc, 12);
    expect(savedCharacter.spellcasting!.selectionSummary, '1 / 3');
    expect(
      savedCharacter.spellcasting!.selectedSpells.map((item) => item.name),
      <String>['Magic Missile'],
    );
    expect(
      savedCharacter.spellcasting!.availableSpells.map((item) => item.name),
      <String>['Magic Missile'],
    );
    expect(find.text('Spells'), findsWidgets);
    expect(find.text('Prepared spells'), findsOneWidget);
    expect(find.text('Spell save DC'), findsOneWidget);
    expect(find.text('Selected / max'), findsOneWidget);
    expect(find.text('1 / 3'), findsOneWidget);
    expect(find.textContaining('Magic Missile'), findsWidgets);
  });

  testWidgets('warlock uses known-spell mode with pact slot progression', (
    WidgetTester tester,
  ) async {
    final compendiumRepository = InMemoryCompendiumRepository(_testCatalog);
    final repository = InMemoryCharacterRepository.empty(
      compendiumRepository: compendiumRepository,
    );
    await tester.binding.setSurfaceSize(const Size(1200, 4200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      AdventureVaultApp(
        characterRepository: repository,
        compendiumRepository: compendiumRepository,
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Continue offline'));
    await tester.tap(find.text('Continue offline'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Create character'));
    await tester.tap(find.text('Create character'));
    await tester.pumpAndSettle();

    final classField = find.byWidgetPredicate(
      (widget) =>
          widget is DropdownButtonFormField<String> &&
          widget.decoration.labelText == 'Clase',
    );

    await tester.enterText(find.byType(TextFormField).first, 'Nim');
    await tester.tap(classField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Warlock').last);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Spells'),
      300,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.text('Known spells • 0 / 2 selected'), findsOneWidget);
    expect(find.text('Spell slots'), findsOneWidget);
    expect(find.text('Level 1 slots'), findsOneWidget);
    expect(find.text('Expended / 1'), findsOneWidget);
    expect(find.text('Apply short rest'), findsOneWidget);
    expect(find.text('Apply long rest'), findsOneWidget);
  });

  testWidgets(
    'spell picker enforces limit and trims overflow on ability change',
    (WidgetTester tester) async {
      final compendiumRepository = InMemoryCompendiumRepository(_testCatalog);
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: compendiumRepository,
      );
      await tester.binding.setSurfaceSize(const Size(1200, 4200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        AdventureVaultApp(
          characterRepository: repository,
          compendiumRepository: compendiumRepository,
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Continue offline'));
      await tester.tap(find.text('Continue offline'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Create character'));
      await tester.tap(find.text('Create character'));
      await tester.pumpAndSettle();

      final classField = find.byWidgetPredicate(
        (widget) =>
            widget is DropdownButtonFormField<String> &&
            widget.decoration.labelText == 'Clase',
      );

      await tester.enterText(find.byType(TextFormField).first, 'Limit Test');
      await tester.tap(classField);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Wizard').last);
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Spells'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Light (Cantrip)'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Light (Cantrip)').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mage Hand (Cantrip)'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mage Hand (Cantrip)').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Magic Missile (Level 1)'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Magic Missile (Level 1)').last);
      await tester.pumpAndSettle();

      expect(find.text('Spellbook spells • 3 / 3 selected'), findsOneWidget);
      expect(
        find.text(
          'Current class limit reached. Unselect a spell to choose another.',
        ),
        findsOneWidget,
      );

      await tester.tap(find.text('Manual').first);
      await tester.pumpAndSettle();

      expect(find.text('Spellbook spells • 1 / 1 selected'), findsOneWidget);
      expect(find.text('Light (Cantrip)'), findsWidgets);
      await tester.scrollUntilVisible(
        find.widgetWithText(FilledButton, 'Save draft').first,
        400,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Save draft'));
      await tester.pumpAndSettle();

      final summaries = await repository.getCharacterSummaries();
      final character = await repository.getCharacterSheetById(
        summaries.single.id,
      );

      expect(find.text('Selected / max'), findsOneWidget);
      expect(find.text('1 / 1'), findsOneWidget);
      expect(character, isNotNull);
      expect(character!.spellcasting!.selectionSummary, '1 / 1');
      expect(
        character.spellcasting!.selectedSpells.map((spell) => spell.name),
        <String>['Light'],
      );
    },
  );

  testWidgets('open edit save and reopen keeps updated character data', (
    WidgetTester tester,
  ) async {
    final compendiumRepository = InMemoryCompendiumRepository(_testCatalog);
    final repository = InMemoryCharacterRepository.empty(
      compendiumRepository: compendiumRepository,
    );
    await tester.binding.setSurfaceSize(const Size(1200, 4200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      AdventureVaultApp(
        characterRepository: repository,
        compendiumRepository: compendiumRepository,
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Continue offline'));
    await tester.tap(find.text('Continue offline'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Create character'));
    await tester.tap(find.text('Create character'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Aelar');
    await tester.scrollUntilVisible(
      find.widgetWithText(FilledButton, 'Save draft').first,
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save draft'));
    await tester.pumpAndSettle();

    expect(find.text('Aelar'), findsWidgets);

    await tester.tap(find.widgetWithText(TextButton, 'Edit'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(FilledButton, 'Save changes'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).first, 'Meris');
    await tester.scrollUntilVisible(
      find.widgetWithText(FilledButton, 'Save changes').first,
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save changes'));
    await tester.pumpAndSettle();

    expect(find.text('Meris'), findsWidgets);
    expect(find.text('Aelar'), findsNothing);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Meris'), findsOneWidget);

    final updatedCard = find.byType(InkWell).first;
    await tester.ensureVisible(updatedCard);
    await tester.tap(updatedCard);
    await tester.pumpAndSettle();

    expect(find.text('Meris'), findsWidgets);
    expect(find.text('Aelar'), findsNothing);
  });

  testWidgets(
    'create screen shows blocked state when compendium is incomplete',
    (WidgetTester tester) async {
      const incompleteCatalog = CompendiumCatalog(
        races: <String>[],
        classes: <String>[],
        backgrounds: <CompendiumBackground>[],
        narrativeOptionGroups: <CompendiumNarrativeOptionGroup>[],
        generatedAbilityScoreSet: <int>[15, 14, 13, 12, 10, 8],
        manualAbilityScoreOptions: <int>[8, 9, 10, 11, 12, 13, 14, 15],
        characterAdvancement: <CharacterAdvancementEntry>[],
        standardArrayByClass: <StandardArrayByClassEntry>[],
        spells: <CompendiumSpell>[],
        feats: <CompendiumFeat>[],
        monsters: <CompendiumMonster>[],
        equipmentSummariesByClass: <String, EquipmentSummaryViewData>{},
        equipmentLoadoutsByClass: <String, List<CompendiumEquipmentLoadout>>{},
      );
      final compendiumRepository = InMemoryCompendiumRepository(
        incompleteCatalog,
      );

      await tester.pumpWidget(
        AdventureVaultApp(
          characterRepository: InMemoryCharacterRepository.empty(
            compendiumRepository: compendiumRepository,
          ),
          compendiumRepository: compendiumRepository,
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Continue offline'));
      await tester.tap(find.text('Continue offline'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Create character'));
      await tester.tap(find.text('Create character'));
      await tester.pumpAndSettle();

      expect(find.text('Incomplete compendium'), findsOneWidget);
      expect(
        find.textContaining(
          'compendium data is missing for: Race, Background, Class',
        ),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(OutlinedButton, 'Back to menu'),
        findsOneWidget,
      );
    },
  );
}

const _testCatalog = CompendiumCatalog(
  races: <String>['Human', 'Dragonborn (Black)', 'Elf', 'Dwarf', 'Halfling'],
  classes: <String>[
    'Fighter',
    'Ranger',
    'Wizard',
    'Warlock',
    'Rogue',
    'Cleric',
  ],
  backgrounds: <CompendiumBackground>[
    CompendiumBackground(
      id: 'acolyte',
      name: 'Acolyte',
      summary:
          'Has servido en un templo y actuas como intermediario entre lo sagrado y el mundo mortal.',
      bonuses: <String>[
        'Skills: Insight, Religion',
        'Languages: any two of your choice',
      ],
      socialPerks: <String>['Shelter of the Faithful', 'Temple support'],
    ),
  ],
  narrativeOptionGroups: <CompendiumNarrativeOptionGroup>[
    CompendiumNarrativeOptionGroup(
      id: 'narrative-alignment-core',
      fieldKey: 'alignment',
      sourceType: 'core_rules',
      title: 'Alignment',
      options: <CompendiumNarrativeOption>[
        CompendiumNarrativeOption(
          id: 'narrative-alignment-1',
          optionIndex: 1,
          text: 'Lawful Good',
        ),
      ],
    ),
    CompendiumNarrativeOptionGroup(
      id: 'narrative-sword-coast-factions',
      fieldKey: 'faction',
      sourceType: 'setting',
      packId: 'legacy-narrative-supplements',
      sourceId: 'sword_coast',
      sourceName: 'Sword Coast Factions',
      title: 'Factions of the Sword Coast',
      options: <CompendiumNarrativeOption>[
        CompendiumNarrativeOption(
          id: 'narrative-sword-coast-faction-1',
          optionIndex: 1,
          text: 'The Harpers',
        ),
      ],
    ),
  ],
  generatedAbilityScoreSet: <int>[15, 14, 13, 12, 10, 8],
  manualAbilityScoreOptions: <int>[8, 9, 10, 11, 12, 13, 14, 15],
  characterAdvancement: <CharacterAdvancementEntry>[
    CharacterAdvancementEntry(level: 1, experience: 0, proficiencyBonus: '+2'),
  ],
  standardArrayByClass: <StandardArrayByClassEntry>[
    StandardArrayByClassEntry(
      classId: 'fighter',
      className: 'Fighter',
      strength: 15,
      dexterity: 14,
      constitution: 13,
      intelligence: 8,
      wisdom: 10,
      charisma: 12,
    ),
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
  spells: <CompendiumSpell>[
    CompendiumSpell(
      id: 'light',
      name: 'Light',
      level: 0,
      school: 'Evocation',
      castingTime: '1 action',
      range: 'Touch',
      components: 'V, M',
      duration: '1 hour',
      classes: <String>['Wizard', 'Cleric'],
      description: <String>['An object shines with bright light.'],
      source: 'SRD',
    ),
    CompendiumSpell(
      id: 'mage-hand',
      name: 'Mage Hand',
      level: 0,
      school: 'Conjuration',
      castingTime: '1 action',
      range: '30 feet',
      components: 'V, S',
      duration: '1 minute',
      classes: <String>['Wizard', 'Sorcerer', 'Warlock'],
      description: <String>['A spectral hand appears.'],
      source: 'SRD',
    ),
    CompendiumSpell(
      id: 'magic-missile',
      name: 'Magic Missile',
      level: 1,
      school: 'Evocation',
      castingTime: '1 action',
      range: '120 feet',
      components: 'V, S',
      duration: 'Instantaneous',
      classes: <String>['Wizard', 'Sorcerer'],
      description: <String>['Three glowing darts of magical force.'],
      source: 'SRD',
    ),
    CompendiumSpell(
      id: 'shield',
      name: 'Shield',
      level: 1,
      school: 'Abjuration',
      castingTime: '1 reaction',
      range: 'Self',
      components: 'V, S',
      duration: '1 round',
      classes: <String>['Wizard'],
      description: <String>['A barrier of magical force protects you.'],
      source: 'SRD',
    ),
    CompendiumSpell(
      id: 'cure-wounds',
      name: 'Cure Wounds',
      level: 1,
      school: 'Evocation',
      castingTime: '1 action',
      range: 'Touch',
      components: 'V, S',
      duration: 'Instantaneous',
      classes: <String>['Cleric', 'Druid', 'Bard'],
      description: <String>['Healing energy restores hit points.'],
      source: 'SRD',
    ),
  ],
  feats: <CompendiumFeat>[],
  monsters: <CompendiumMonster>[],
  equipmentSummariesByClass: <String, EquipmentSummaryViewData>{
    'Fighter': EquipmentSummaryViewData(
      statusLabel: 'MVP minimal',
      description:
          'La hoja ya reserva un espacio para el loadout del personaje, con foco futuro en armas, armadura y gear.',
      highlightItems: <String>[
        'Weapon loadout pending',
        'Armor summary pending',
        'Gear list pending',
      ],
    ),
  },
  equipmentLoadoutsByClass: <String, List<CompendiumEquipmentLoadout>>{
    'Fighter': <CompendiumEquipmentLoadout>[
      CompendiumEquipmentLoadout(
        id: 'fighter-chain-mail',
        label: 'Chain mail starter kit',
        startingMoneySummary: 'Class kit with default martial gear',
        selectedItems: <String>[
          'Chain mail',
          'Shield',
          'Longsword',
          'Explorer pack',
        ],
      ),
    ],
    'Wizard': <CompendiumEquipmentLoadout>[
      CompendiumEquipmentLoadout(
        id: 'wizard-focus',
        label: 'Arcane focus kit',
        startingMoneySummary: 'Class kit with prepared arcane tools',
        selectedItems: <String>[
          'Quarterstaff',
          'Component pouch',
          'Scholar pack',
        ],
      ),
    ],
  },
  packStates: <CompendiumPackStateModel>[
    CompendiumPackStateModel(
      id: 'bundled-base-compendium',
      title: 'Base compendium',
      description: 'FightClub XML bundled base content',
      kind: 'bundled_base',
      isFixed: true,
      isActive: true,
    ),
    CompendiumPackStateModel(
      id: 'legacy-narrative-supplements',
      title: 'Packs opcionales importados',
      description: 'Legacy narrative supplements',
      kind: 'optional_bundle',
      isFixed: false,
      isActive: true,
    ),
  ],
  sourcePolicy: CompendiumSourcePolicy(
    activeSourceType: 'fightclub_xml',
    activeSourceLabel:
        'FightClub XML asset bundle with SRD 5.5e core data and legacy 5e narrative supplements',
    fallbackSourceLabel: 'assets/compendium/catalog.json',
    sections: <CompendiumSectionSourcePolicy>[
      CompendiumSectionSourcePolicy(
        sectionKey: 'backgrounds',
        sectionLabel: 'Backgrounds',
        sourceType: 'srd_5_5e_xml',
        primarySources: <String>['default_backgrounds_5.5e.xml'],
      ),
      CompendiumSectionSourcePolicy(
        sectionKey: 'races',
        sectionLabel: 'Races',
        sourceType: 'srd_5_5e_xml',
        primarySources: <String>['default_races_5.5e.xml'],
      ),
      CompendiumSectionSourcePolicy(
        sectionKey: 'classes',
        sectionLabel: 'Classes',
        sourceType: 'srd_5_5e_xml',
        primarySources: <String>['default_classes_5.5e.xml'],
      ),
      CompendiumSectionSourcePolicy(
        sectionKey: 'spells',
        sectionLabel: 'Spells',
        sourceType: 'srd_5_5e_xml',
        primarySources: <String>['default_spells_5.5e.xml'],
      ),
      CompendiumSectionSourcePolicy(
        sectionKey: 'feats',
        sectionLabel: 'Feats',
        sourceType: 'srd_5_5e_xml',
        primarySources: <String>['default_feats_5.5e.xml'],
      ),
      CompendiumSectionSourcePolicy(
        sectionKey: 'monsters',
        sectionLabel: 'Monsters',
        sourceType: 'srd_5_5e_xml',
        primarySources: <String>['default_bestiary_5.5e.xml'],
      ),
      CompendiumSectionSourcePolicy(
        sectionKey: 'narrative_options',
        sectionLabel: 'Narrative options',
        sourceType: 'legacy_5e_xml_supplements',
        primarySources: <String>['backgrounds-phb.xml'],
        supplementalSources: <String>[
          'backgrounds-scag.xml',
          'backgrounds-pam.xml',
          'backgrounds-ggr.xml',
          'backgrounds-erlw.xml',
        ],
        supplementalPackId: 'legacy-narrative-supplements',
      ),
    ],
  ),
);

const _importFixture = '''
<compendium version="5" auto_indent="NO">
  <background>
    <name>Imported Acolyte Expansion</name>
    <source>Imported Test Source</source>
    <trait>
      <name>Description</name>
      <text>Imported background text.</text>
    </trait>
    <trait>
      <name>Suggested Characteristics</name>
      <text>d6 | Ideal
1 | Tradition. Preserve the old ways.</text>
    </trait>
  </background>
</compendium>
''';
