import 'package:flutter/material.dart';

/// Dialog para dividir un stack de items en dos stacks.
class SplitStackDialog extends StatefulWidget {
  final String itemId;
  final int quantity;
  final VoidCallback onClose;
  final void Function(String itemId, int splitQuantity) onSplit;

  const SplitStackDialog({
    super.key,
    required this.itemId,
    required this.quantity,
    required this.onClose,
    required this.onSplit,
  });

  @override
  State<SplitStackDialog> createState() => _SplitStackDialogState();
}

class _SplitStackDialogState extends State<SplitStackDialog> {
  late TextEditingController _quantityController;
  late final FocusNode _quantityFocusNode;
  int _splitQuantity = 0;
  bool _isSplitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _splitQuantity = widget.quantity ~/ 2;
    _quantityController = TextEditingController(
      text: _splitQuantity.toString(),
    );
    _quantityFocusNode = FocusNode(debugLabel: 'SplitStackQuantity');
  }

  void _validateAndSplit() {
    if (_error != null) {
      setState(() => _error = null);
    }

    final splitQuantity = int.tryParse(_quantityController.text);

    if (splitQuantity == null) {
      setState(() => _error = 'Please enter a valid number');
      return;
    }

    if (splitQuantity <= 0) {
      setState(() => _error = 'Split quantity must be greater than zero');
      return;
    }

    if (splitQuantity >= widget.quantity) {
      setState(
        () => _error =
            'Split quantity must be less than source stack ($widget.quantity)',
      );
      return;
    }

    setState(() {
      _isSplitting = true;
      _splitQuantity = splitQuantity;
      _error = null;
    });

    widget.onSplit(widget.itemId, _splitQuantity);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) widget.onClose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      autofocus: true,
      child: Semantics(
        container: true,
        explicitChildNodes: true,
        namesRoute: true,
        label: 'Split stack dialog',
        child: AlertDialog(
          semanticLabel: 'Split stack dialog',
          title: const Text('Split Stack'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Split quantity to create new stack:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              if (_error != null)
                Semantics(
                  container: true,
                  liveRegion: true,
                  label: _error!,
                  child: ExcludeSemantics(
                    child: Text(
                      _error!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.red),
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              TextField(
                controller: _quantityController,
                focusNode: _quantityFocusNode,
                autofocus: true,
                keyboardType: TextInputType.number,
                maxLength: 5,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Amount to split',
                  errorText: _error,
                ),
                onChanged: (value) {
                  final parsed = int.tryParse(value);
                  setState(() {
                    _splitQuantity = parsed ?? 0;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Source: $widget.quantity',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'New: $_splitQuantity',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Remaining: ${widget.quantity - _splitQuantity}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: widget.onClose, child: const Text('Cancel')),
            Semantics(
              container: true,
              button: true,
              enabled: !_isSplitting,
              label: 'Confirm split',
              child: ElevatedButton(
                onPressed: _isSplitting ? null : _validateAndSplit,
                child: const Text('Split'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _quantityFocusNode.dispose();
    super.dispose();
  }
}
