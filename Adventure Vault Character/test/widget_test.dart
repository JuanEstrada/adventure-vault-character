import 'package:adventure_vault_character/src/app/adventure_vault_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('boot flow reaches access and main menu offline path', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AdventureVaultApp());
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
}
