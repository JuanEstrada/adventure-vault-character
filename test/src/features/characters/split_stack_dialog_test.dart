import 'package:adventure_vault_character/src/features/characters/presentation/split_stack_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SplitStackDialog focuses the quantity field on open', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SplitStackDialog(
            itemId: 'item-1',
            quantity: 10,
            onClose: () {},
            onSplit: (itemId, splitQuantity) {},
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Split Stack'), findsOneWidget);
    expect(
      FocusManager.instance.primaryFocus?.debugLabel,
      'SplitStackQuantity',
    );
  });
}
