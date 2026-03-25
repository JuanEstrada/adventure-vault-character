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
          compendiumRepository: const InMemoryCompendiumRepository(
            _testCatalog,
          ),
        ),
        compendiumRepository: const InMemoryCompendiumRepository(_testCatalog),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Continuar offline'), findsOneWidget);

    await tester.ensureVisible(find.text('Continuar offline'));
    await tester.tap(find.text('Continuar offline'));
    await tester.pumpAndSettle();

    expect(find.text('Compendio'), findsOneWidget);
    expect(find.text('Crear personaje nuevo'), findsOneWidget);
    expect(
      find.textContaining('Todavia no hay personajes guardados'),
      findsOneWidget,
    );
  });

  testWidgets('create flow saves character and opens sheet', (
    WidgetTester tester,
  ) async {
    const compendiumRepository = InMemoryCompendiumRepository(_testCatalog);
    final repository = InMemoryCharacterRepository.empty(
      compendiumRepository: compendiumRepository,
    );
    await tester.binding.setSurfaceSize(const Size(1200, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      AdventureVaultApp(
        characterRepository: repository,
        compendiumRepository: compendiumRepository,
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Continuar offline'));
    await tester.tap(find.text('Continuar offline'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Crear personaje nuevo'));
    await tester.tap(find.text('Crear personaje nuevo'));
    await tester.pumpAndSettle();

    expect(find.text('Background'), findsWidgets);
    expect(find.text('Ability Scores'), findsOneWidget);
    expect(find.text('Equipment'), findsWidgets);
    expect(find.text('Finishing details'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'Aelar');
    await tester.tap(find.widgetWithText(FilledButton, 'Guardar draft'));
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
    expect(find.text('Alignment'), findsOneWidget);
    expect(find.text('Strength'), findsWidgets);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Aelar'), findsOneWidget);
    expect(find.textContaining('Human  •  Fighter  •  Lv 1'), findsOneWidget);
  });

  testWidgets('generated ability set updates when class changes', (
    WidgetTester tester,
  ) async {
    const compendiumRepository = InMemoryCompendiumRepository(_testCatalog);
    final repository = InMemoryCharacterRepository.empty(
      compendiumRepository: compendiumRepository,
    );
    await tester.binding.setSurfaceSize(const Size(1200, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      AdventureVaultApp(
        characterRepository: repository,
        compendiumRepository: compendiumRepository,
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Continuar offline'));
    await tester.tap(find.text('Continuar offline'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Crear personaje nuevo'));
    await tester.tap(find.text('Crear personaje nuevo'));
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

    await tester.tap(find.widgetWithText(FilledButton, 'Guardar draft'));
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
  });

  testWidgets('open edit save and reopen keeps updated character data', (
    WidgetTester tester,
  ) async {
    const compendiumRepository = InMemoryCompendiumRepository(_testCatalog);
    final repository = InMemoryCharacterRepository.empty(
      compendiumRepository: compendiumRepository,
    );
    await tester.binding.setSurfaceSize(const Size(1200, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      AdventureVaultApp(
        characterRepository: repository,
        compendiumRepository: compendiumRepository,
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Continuar offline'));
    await tester.tap(find.text('Continuar offline'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Crear personaje nuevo'));
    await tester.tap(find.text('Crear personaje nuevo'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Aelar');
    await tester.tap(find.widgetWithText(FilledButton, 'Guardar draft'));
    await tester.pumpAndSettle();

    expect(find.text('Aelar'), findsWidgets);

    await tester.tap(find.widgetWithText(TextButton, 'Edit'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(FilledButton, 'Save changes'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).first, 'Meris');
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
      const compendiumRepository = InMemoryCompendiumRepository(
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

      await tester.ensureVisible(find.text('Continuar offline'));
      await tester.tap(find.text('Continuar offline'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Crear personaje nuevo'));
      await tester.tap(find.text('Crear personaje nuevo'));
      await tester.pumpAndSettle();

      expect(find.text('Compendio incompleto'), findsOneWidget);
      expect(
        find.textContaining(
          'faltan datos del compendio para: Race, Background, Class',
        ),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(OutlinedButton, 'Volver al menu'),
        findsOneWidget,
      );
    },
  );
}

const _testCatalog = CompendiumCatalog(
  races: <String>['Human', 'Dragonborn (Black)', 'Elf', 'Dwarf', 'Halfling'],
  classes: <String>['Fighter', 'Ranger', 'Wizard', 'Rogue', 'Cleric'],
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
  spells: <CompendiumSpell>[],
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
);
