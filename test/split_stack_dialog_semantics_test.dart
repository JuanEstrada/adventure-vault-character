import 'package:adventure_vault_character/src/features/characters/presentation/split_stack_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('split stack dialog exposes a semantics label', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (_) => SplitStackDialog(
                    itemId: 'item-1',
                    quantity: 10,
                    onClose: () => Navigator.of(context).pop(),
                    onSplit: (itemId, splitQuantity) {},
                  ),
                );
              },
              child: const Text('Open split dialog'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open split dialog'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    final handle = tester.ensureSemantics();
    try {
      expect(find.bySemanticsLabel('Split stack dialog'), findsWidgets);
      expect(find.bySemanticsLabel('Split Stack'), findsWidgets);
    } finally {
      handle.dispose();
    }
  });

  testWidgets('split stack dialog shows validation errors', (tester) async {
    bool called = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SplitStackDialog(
            itemId: 'item-1',
            quantity: 10,
            onClose: () {},
            onSplit: (itemId, splitQuantity) {
              called = true;
            },
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), '0');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Split'));
    await tester.pump();

    expect(called, isFalse);
    expect(find.text('Split quantity must be greater than zero'), findsWidgets);
  });
}
