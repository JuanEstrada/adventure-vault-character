import 'package:flutter/material.dart';

/// Dialog for splitting an inventory stack into a new stack
class SplitStackDialog extends StatefulWidget {
  final String itemId;
  final int quantity;
  final VoidCallback onClose;
  final Function(String itemId, int splitQuantity) onSplit;

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

    // Call the split callback with the item ID and split quantity
    widget.onSplit(widget.itemId, _splitQuantity);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) widget.onClose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            Text(
              _error!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.red),
            ),
          const SizedBox(height: 8),
          TextField(
            controller: _quantityController,
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
        ElevatedButton(
          onPressed: _isSplitting ? null : _validateAndSplit,
          child: const Text('Split'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}

/// Dialog for merging inventory stacks with optional quantity override
class MergeStackDialog extends StatefulWidget {
  final List<String> stackIds;
  final int? quantityOverride;
  final VoidCallback onDismiss;
  final Function(List<String> stackIds, int mergeQuantity) onMerge;

  const MergeStackDialog({
    super.key,
    required this.stackIds,
    this.quantityOverride,
    required this.onDismiss,
    required this.onMerge,
  });

  @override
  State<MergeStackDialog> createState() => _MergeStackDialogState();
}

class _MergeStackDialogState extends State<MergeStackDialog> {
  late TextEditingController _quantityController;
  int _mergeQuantity = 0;
  bool _isMerging = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _mergeQuantity = widget.quantityOverride ?? 0;
    _quantityController = TextEditingController(
      text: _mergeQuantity.toString(),
    );
  }

  void _validateAndMerge() {
    if (_error != null) {
      setState(() => _error = null);
    }

    final mergeQuantity = int.tryParse(_quantityController.text);

    if (mergeQuantity == null) {
      setState(() => _error = 'Please enter a valid number');
      return;
    }

    if (mergeQuantity <= 0) {
      setState(() => _error = 'Merge quantity must be greater than zero');
      return;
    }

    // Use first stack as source reference if quantity not overridden
    final sourceQuantity = widget.stackIds.isNotEmpty ? 0 : 0;
    if (mergeQuantity > sourceQuantity && sourceQuantity > 0) {
      setState(
        () => _error =
            'Merge quantity cannot exceed source stack ($sourceQuantity)',
      );
      return;
    }

    setState(() {
      _isMerging = true;
      _mergeQuantity = mergeQuantity;
      _error = null;
    });

    widget.onMerge(widget.stackIds, _mergeQuantity);

    Future.delayed(const Duration(milliseconds: 100), () {
      widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Merge Stack'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Merge quantity to add to target:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          if (_error != null)
            Text(
              _error!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.red),
            ),
          const SizedBox(height: 8),
          TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            maxLength: 5,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Amount to merge',
              errorText: _error,
            ),
            onChanged: (value) {
              final parsed = int.tryParse(value);
              setState(() {
                _mergeQuantity = parsed ?? 0;
              });
            },
          ),
          const SizedBox(height: 8),
          Text(
            'Merging ${widget.stackIds.length} stack(s)',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Row(
            children: widget.stackIds.map((id) {
              return Expanded(
                child: Text(
                  'Stack: $id',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  'After: ${widget.quantityOverride ?? 0 + _mergeQuantity}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: widget.onDismiss, child: const Text('Cancel')),
        ElevatedButton(
          onPressed: _isMerging ? null : _validateAndMerge,
          child: const Text('Merge'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}
