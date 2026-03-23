import 'package:adventure_vault_character/src/app/adventure_vault_app.dart';
import 'package:adventure_vault_character/src/features/characters/data/in_memory_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
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
