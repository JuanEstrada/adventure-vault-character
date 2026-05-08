import 'package:adventure_vault_character/src/features/characters/presentation/merge_stack_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('merge stack dialog exposes semantics labels', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (_) => MergeStackDialog(
                    sourceItemId: 'source-1',
                    sourceQuantity: 8,
                    targetItemId: 'target-1',
                    targetQuantity: 4,
                    onDismiss: () => Navigator.of(context).pop(),
                    onMerge: (targetItemId, mergeQuantity) {},
                  ),
                );
              },
              child: const Text('Open merge dialog'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open merge dialog'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    final handle = tester.ensureSemantics();
    try {
      expect(find.bySemanticsLabel('Merge stack dialog'), findsWidgets);
      expect(find.bySemanticsLabel('Merge stack dialog title'), findsWidgets);
      expect(find.bySemanticsLabel('Merge quantity from source'), findsWidgets);
      expect(find.bySemanticsLabel('Source quantity 8'), findsWidgets);
      expect(find.bySemanticsLabel('Target quantity 4'), findsWidgets);
      expect(find.bySemanticsLabel('After merge 12'), findsWidgets);
      expect(find.bySemanticsLabel('Cancel merge'), findsWidgets);
      expect(find.bySemanticsLabel('Confirm merge'), findsWidgets);
    } finally {
      handle.dispose();
    }
  });
}
