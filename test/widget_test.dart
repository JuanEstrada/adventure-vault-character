import 'package:adventure_vault_character/src/app/adventure_vault_app.dart';
import 'package:adventure_vault_character/src/features/characters/data/in_memory_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/data/in_memory_compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:adventure_vault_character/src/features/settings/data/in_memory_system_settings_repository.dart';
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
    expect(find.text('Optional packs'), findsOneWidget);
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
    expect(
      find.textContaining('SRD alignment reference (core rules)'),
      findsOneWidget,
    );
    expect(find.textContaining('backgrounds-phb.xml'), findsNothing);
    expect(find.textContaining('backgrounds-scag.xml'), findsNothing);
  });

  testWidgets('main menu Rules and LOAD XML actions open existing routes', (
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

    await tester.ensureVisible(find.text('Continue offline'));
    await tester.tap(find.text('Continue offline'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Rules'));
    await tester.pumpAndSettle();

    expect(find.text('Compendium'), findsOneWidget);
    expect(find.text('Content management'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    await tester.tap(find.text('LOAD XML'));
    await tester.pumpAndSettle();

    expect(find.text('Import XML'), findsOneWidget);
    expect(find.text('Local pack registration'), findsOneWidget);
  });

  testWidgets('settings toggles coin weight preference', (
    WidgetTester tester,
  ) async {
    final settingsRepository = InMemorySystemSettingsRepository();

    await tester.pumpWidget(
      AdventureVaultApp(
        characterRepository: InMemoryCharacterRepository.empty(
          compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
        ),
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
        systemSettingsRepository: settingsRepository,
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Continue offline'));
    await tester.tap(find.text('Continue offline'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('System rules'), findsOneWidget);
    expect(find.text('Count coin weight in carried load'), findsOneWidget);
    expect(
      find.text('Current default: coin weight is excluded.'),
      findsOneWidget,
    );

    await tester.tap(find.byType(SwitchListTile).first);
    await tester.pumpAndSettle();

    expect(
      find.text('Current default: coin weight is included.'),
      findsOneWidget,
    );
    expect(
      await settingsRepository.getIncludeCoinWeightInEncumbrance(),
      isTrue,
    );
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

    expect(find.text('Summary'), findsOneWidget);
    expect(find.text('Aelar'), findsWidgets);
    expect(find.textContaining('Human'), findsWidgets);
    expect(find.textContaining('Fighter'), findsWidgets);
    expect(find.text('Generated set assignment'), findsOneWidget);
    expect(find.text('Acolyte'), findsOneWidget);
    expect(find.text('Combat'), findsWidgets);
    expect(find.text('Current HP'), findsOneWidget);
    expect(find.text('Passive Perception'), findsOneWidget);
    expect(find.text('Equipment'), findsWidgets);
    expect(find.text('Chain mail starter kit'), findsOneWidget);
    expect(find.text('Starting money'), findsOneWidget);
    expect(find.text('Strength'), findsWidgets);
    expect(find.text('Languages'), findsOneWidget);
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
          widget.decoration.labelText == 'Class',
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
    expect(find.text('Prepare all valid'), findsOneWidget);
    expect(find.text('Clear prepared'), findsOneWidget);
    await tester.tap(find.text('Prepare all valid'));
    await tester.pumpAndSettle();
    expect(find.text('Prepared spells • 1 / 3 selected'), findsOneWidget);
    await tester.tap(find.text('Clear prepared'));
    await tester.pumpAndSettle();
    expect(find.text('Prepared spells • 0 / 3 selected'), findsOneWidget);
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
          widget.decoration.labelText == 'Class',
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
            widget.decoration.labelText == 'Class',
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

  testWidgets('sheet class resource controls update persisted uses', (
    WidgetTester tester,
  ) async {
    final catalog = _testCatalog.copyWith(
      equipmentLoadoutsByClass: <String, List<CompendiumEquipmentLoadout>>{
        ..._testCatalog.equipmentLoadoutsByClass,
        'Cleric': <CompendiumEquipmentLoadout>[
          const CompendiumEquipmentLoadout(
            id: 'cleric-mace-shield',
            label: 'Temple duty kit',
            startingMoneySummary: 'Class kit with cleric essentials',
            selectedItems: <String>['Mace', 'Shield', 'Priest pack'],
          ),
        ],
      },
    );
    final compendiumRepository = InMemoryCompendiumRepository(catalog);
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
          widget.decoration.labelText == 'Class',
    );
    await tester.enterText(find.byType(TextFormField).first, 'Seren');
    await tester.tap(classField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cleric').last);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.widgetWithText(FilledButton, 'Save draft').first,
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save draft'));
    await tester.pumpAndSettle();

    final summaries = await repository.getCharacterSummaries();
    final sheet = await repository.getCharacterSheetById(summaries.single.id);
    expect(sheet, isNotNull);
    expect(sheet!.combat.classResources, hasLength(1));
    expect(sheet.combat.classResources.single.resourceKey, 'channel-divinity');
    expect(find.textContaining('Last changed:'), findsWidgets);
    expect(find.textContaining('via Initial'), findsWidgets);

    await tester.tap(find.byTooltip('Spend use').first);
    await tester.pumpAndSettle();

    final updatedSheet = await repository.getCharacterSheetById(
      summaries.single.id,
    );
    expect(updatedSheet, isNotNull);
    expect(updatedSheet!.combat.classResources.single.currentUses, 0);
    expect(find.textContaining('via Manual'), findsWidgets);
  });

  testWidgets('sheet inventory charge controls persist tracked values', (
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

    await tester.enterText(find.byType(TextFormField).first, 'Iriel');
    final classField = find.byWidgetPredicate(
      (widget) =>
          widget is DropdownButtonFormField<String> &&
          widget.decoration.labelText == 'Class',
    );
    await tester.tap(classField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Wizard').last);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.widgetWithText(FilledButton, 'Save draft').first,
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save draft'));
    await tester.pumpAndSettle();

    final trackChargesChip = find.widgetWithText(ActionChip, 'Track charges');
    expect(trackChargesChip, findsWidgets);
    await tester.tap(trackChargesChip.first);
    await tester.pumpAndSettle();

    expect(find.widgetWithText(ActionChip, 'Clear charges'), findsWidgets);
    expect(find.byType(LinearProgressIndicator), findsWidgets);

    final summaries = await repository.getCharacterSummaries();
    final sheet = await repository.getCharacterSheetById(summaries.single.id);
    expect(sheet, isNotNull);
    expect(
      sheet!.equipment.items.any((item) => item.chargesCurrent == 1),
      isTrue,
    );
    expect(sheet.equipment.items.any((item) => item.chargesMax == 1), isTrue);
  });

  testWidgets('sheet consumable spend action decrements quantity end-to-end', (
    WidgetTester tester,
  ) async {
    final catalog = _testCatalog.copyWith(
      equipmentLoadoutsByClass: <String, List<CompendiumEquipmentLoadout>>{
        ..._testCatalog.equipmentLoadoutsByClass,
        'Fighter': <CompendiumEquipmentLoadout>[
          const CompendiumEquipmentLoadout(
            id: 'fighter-consumable-kit',
            label: 'Consumable kit',
            startingMoneySummary: 'Class kit with a spendable item',
            selectedItems: <String>['Quarterstaff', 'Torch'],
          ),
        ],
      },
    );
    final compendiumRepository = InMemoryCompendiumRepository(catalog);
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
          widget.decoration.labelText == 'Class',
    );
    await tester.enterText(find.byType(TextFormField).first, 'Borin');
    await tester.tap(classField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fighter').last);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.widgetWithText(FilledButton, 'Save draft').first,
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save draft'));
    await tester.pumpAndSettle();

    final spendChip = find.widgetWithText(ActionChip, 'Spend 1');
    expect(spendChip, findsOneWidget);

    await tester.tap(spendChip);
    await tester.pumpAndSettle();

    expect(find.text('Qty 0'), findsOneWidget);
    final spentChipWidget = tester.widget<ActionChip>(spendChip);
    expect(spentChipWidget.onPressed, isNull);

    final summaries = await repository.getCharacterSummaries();
    final sheet = await repository.getCharacterSheetById(summaries.single.id);
    final torch = sheet!.equipment.items.firstWhere(
      (item) => item.name == 'Torch',
    );
    expect(torch.quantity, 0);
  });

  testWidgets('sheet spell-slot spend action persists after reopen', (
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
          widget.decoration.labelText == 'Class',
    );

    await tester.enterText(find.byType(TextFormField).first, 'Selene');
    await tester.tap(classField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Wizard').last);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.widgetWithText(FilledButton, 'Save draft').first,
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save draft'));
    await tester.pumpAndSettle();

    expect(find.text('2 / 2'), findsOneWidget);

    final spendChip = find.widgetWithText(ActionChip, 'Spend 1').first;
    await tester.tap(spendChip);
    await tester.pumpAndSettle();

    expect(find.text('1 / 2'), findsOneWidget);

    final summaries = await repository.getCharacterSummaries();
    final sheet = await repository.getCharacterSheetById(summaries.single.id);
    expect(sheet, isNotNull);
    final levelOneSlot = sheet!.spellcasting!.slotProgression.firstWhere(
      (slot) => slot.spellLevel == 1,
    );
    expect(levelOneSlot.slotsExpended, 1);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Selene'), findsOneWidget);

    final updatedCharacterName = find.text('Selene').last;
    await tester.ensureVisible(updatedCharacterName);
    await tester.tap(updatedCharacterName);
    await tester.pumpAndSettle();

    expect(find.text('1 / 2'), findsOneWidget);
    expect(find.widgetWithText(ActionChip, 'Spend 1'), findsOneWidget);
  });

  testWidgets('sheet spell-slot restore action closes the minimum slot loop', (
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
          widget.decoration.labelText == 'Class',
    );

    await tester.enterText(find.byType(TextFormField).first, 'Lyra');
    await tester.tap(classField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Wizard').last);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.widgetWithText(FilledButton, 'Save draft').first,
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save draft'));
    await tester.pumpAndSettle();

    expect(find.text('2 / 2'), findsOneWidget);

    final spendChip = find.widgetWithText(ActionChip, 'Spend 1').first;
    final restoreChip = find.widgetWithText(ActionChip, 'Restore 1').first;

    final restoreChipBeforeSpend = tester.widget<ActionChip>(restoreChip);
    expect(restoreChipBeforeSpend.onPressed, isNull);

    await tester.tap(spendChip);
    await tester.pumpAndSettle();

    expect(find.text('1 / 2'), findsOneWidget);

    final restoreChipAfterSpend = tester.widget<ActionChip>(restoreChip);
    expect(restoreChipAfterSpend.onPressed, isNotNull);

    await tester.tap(restoreChip);
    await tester.pumpAndSettle();

    expect(find.text('2 / 2'), findsOneWidget);

    final summaries = await repository.getCharacterSummaries();
    final sheet = await repository.getCharacterSheetById(summaries.single.id);
    expect(sheet, isNotNull);
    final levelOneSlot = sheet!.spellcasting!.slotProgression.firstWhere(
      (slot) => slot.spellLevel == 1,
    );
    expect(levelOneSlot.slotsExpended, 0);
  });

  testWidgets('sheet spell-slot restore action persists after reopen', (
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
          widget.decoration.labelText == 'Class',
    );

    await tester.enterText(find.byType(TextFormField).first, 'Talia');
    await tester.tap(classField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Wizard').last);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.widgetWithText(FilledButton, 'Save draft').first,
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save draft'));
    await tester.pumpAndSettle();

    expect(find.text('2 / 2'), findsOneWidget);

    final spendChip = find.widgetWithText(ActionChip, 'Spend 1').first;
    await tester.tap(spendChip);
    await tester.pumpAndSettle();

    expect(find.text('1 / 2'), findsOneWidget);

    final restoreChip = find.widgetWithText(ActionChip, 'Restore 1').first;
    await tester.tap(restoreChip);
    await tester.pumpAndSettle();

    expect(find.text('2 / 2'), findsOneWidget);

    final summaries = await repository.getCharacterSummaries();
    final sheet = await repository.getCharacterSheetById(summaries.single.id);
    expect(sheet, isNotNull);
    final levelOneSlot = sheet!.spellcasting!.slotProgression.firstWhere(
      (slot) => slot.spellLevel == 1,
    );
    expect(levelOneSlot.slotsExpended, 0);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Talia'), findsOneWidget);

    final updatedCharacterName = find.text('Talia').last;
    await tester.ensureVisible(updatedCharacterName);
    await tester.tap(updatedCharacterName);
    await tester.pumpAndSettle();

    expect(find.text('2 / 2'), findsOneWidget);
    final restoreChipAfterReopen = tester.widget<ActionChip>(
      find.widgetWithText(ActionChip, 'Restore 1').first,
    );
    expect(restoreChipAfterReopen.onPressed, isNull);
  });

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

    final classField = find.byWidgetPredicate(
      (widget) =>
          widget is DropdownButtonFormField<String> &&
          widget.decoration.labelText == 'Class',
    );
    await tester.tap(classField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Wizard').last);
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
      find.text('Spells'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    final expendedField = find.byWidgetPredicate(
      (widget) =>
          widget is DropdownButtonFormField<int> &&
          widget.decoration.labelText == 'Expended / 2',
    );
    await tester.tap(expendedField);
    await tester.pumpAndSettle();
    await tester.tap(find.text('1').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Apply long rest'));
    await tester.pumpAndSettle();
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
    expect(find.text('Level 1 slots'), findsOneWidget);
    expect(find.text('Apply short rest'), findsOneWidget);
    expect(find.text('Apply long rest'), findsOneWidget);
    final shortRestButton = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Apply short rest'),
    );
    expect(shortRestButton.onPressed, isNull);
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
          'The sheet already reserves space for the character loadout, with future focus on weapons, armor, and gear.',
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
        'FightClub XML asset bundle with SRD 5.5e core data plus optional legacy narrative packs',
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
        sourceType: 'srd_core_plus_optional_legacy_pack',
        primarySources: <String>['SRD alignment reference (core rules)'],
        supplementalSources: <String>[
          'backgrounds-phb.xml',
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
