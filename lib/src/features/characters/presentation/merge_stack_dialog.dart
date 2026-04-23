import 'package:flutter/material.dart';

/// Dialog for merging two inventory stacks with optional quantity override
class MergeStackDialog extends StatefulWidget {
  final String sourceItemId;
  final int sourceQuantity;
  final String targetItemId;
  final int targetQuantity;
  final VoidCallback onDismiss;
  final Function(String targetItemId, int mergeQuantity) onMerge;

  const MergeStackDialog({
    super.key,
    required this.sourceItemId,
    required this.sourceQuantity,
    required this.targetItemId,
    required this.targetQuantity,
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
    _mergeQuantity = widget.sourceQuantity;
    _quantityController = TextEditingController(text: _mergeQuantity.toString());
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

    if (mergeQuantity > widget.sourceQuantity) {
      setState(() => _error =
          'Merge quantity cannot exceed source stack ($widget.sourceQuantity)');
      return;
    }

    setState(() {
      _isMerging = true;
      _mergeQuantity = mergeQuantity;
      _error = null;
    });

    widget.onMerge(widget.targetItemId, _mergeQuantity);

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
            'Merge quantity from source:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          if (_error != null)
            Text(
              _error!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.red,
              ),
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
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Text(
                'Source: $widget.sourceQuantity',
                style: Theme.of(context).textTheme.bodySmall,
              )),
              const SizedBox(width: 16),
              Expanded(child: Text(
                'Target: $widget.targetQuantity',
                style: Theme.of(context).textTheme.bodySmall,
              )),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: Text(
                'After: ${widget.targetQuantity + _mergeQuantity}',
                style: Theme.of(context).textTheme.bodySmall,
              )),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: widget.onDismiss,
          child: const Text('Cancel'),
        ),
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
