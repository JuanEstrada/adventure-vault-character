import 'package:adventure_vault_character/src/features/characters/presentation/merge_stack_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MergeStackDialog focuses the quantity field on open', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MergeStackDialog(
            sourceItemId: 'item-1',
            sourceQuantity: 10,
            targetItemId: 'item-2',
            targetQuantity: 5,
            onDismiss: () {},
            onMerge: (targetItemId, mergeQuantity) {},
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Merge Stack'), findsOneWidget);
    expect(
      FocusManager.instance.primaryFocus?.debugLabel,
      'MergeStackQuantity',
    );
  });
}
