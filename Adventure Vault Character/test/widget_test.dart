import 'package:adventure_vault_character/src/app/adventure_vault_app.dart';
import 'package:adventure_vault_character/src/features/characters/data/in_memory_character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('boot flow reaches access and main menu offline path', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      AdventureVaultApp(
        characterRepository: InMemoryCharacterRepository.empty(),
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
    final repository = InMemoryCharacterRepository.empty();
    await tester.binding.setSurfaceSize(const Size(1200, 1800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      AdventureVaultApp(
        characterRepository: repository,
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

    await tester.enterText(
      find.byType(TextFormField).first,
      'Aelar',
    );
    final saveButton = find.widgetWithText(FilledButton, 'Guardar draft');
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(find.text('Resumen'), findsOneWidget);
    expect(find.text('Aelar'), findsWidgets);
    expect(find.textContaining('Human'), findsWidgets);
    expect(find.textContaining('Fighter'), findsWidgets);
    expect(find.text('Generated set assignment'), findsOneWidget);
    expect(find.text('Scholar'), findsOneWidget);
    expect(find.text('Combat'), findsWidgets);
    expect(find.text('Current HP'), findsOneWidget);
    expect(find.text('Equipment'), findsWidgets);
    expect(find.text('MVP minimal'), findsOneWidget);
    expect(find.text('Strength'), findsWidgets);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Aelar'), findsOneWidget);
    expect(find.textContaining('Human  •  Fighter  •  Lv 1'), findsOneWidget);
  });
}
