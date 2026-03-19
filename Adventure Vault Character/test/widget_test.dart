import 'package:flutter_test/flutter_test.dart';

import 'package:adventure_vault_character/main.dart';

void main() {
  testWidgets('bootstrap screen renders expected text', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AdventureVaultApp());

    expect(find.text('Adventure Vault Character'), findsOneWidget);
    expect(
      find.text(
        'Flutter bootstrap ready. Next step: generate full platform '
        'scaffolding and implement the first MVP slice.',
      ),
      findsOneWidget,
    );
  });
}
