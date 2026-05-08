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
}
