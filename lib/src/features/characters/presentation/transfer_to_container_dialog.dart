import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:flutter/material.dart';

/// Dialog for transferring an inventory stack to a container
class TransferToContainerDialog extends StatefulWidget {
  final String sourceItemId;
  final int sourceQuantity;
  final String sourceName;
  final VoidCallback onDismiss;
  final Future<void> Function(
    String containerId,
    String containerName,
    int quantity,
  )
  onTransfer;
  final List<CharacterEquipmentItemDomainModel> containers;

  const TransferToContainerDialog({
    super.key,
    required this.sourceItemId,
    required this.sourceQuantity,
    required this.sourceName,
    required this.onDismiss,
    required this.onTransfer,
    required this.containers,
  });

  @override
  State<TransferToContainerDialog> createState() =>
      _TransferToContainerDialogState();
}

class _TransferToContainerDialogState extends State<TransferToContainerDialog> {
  late TextEditingController _quantityController;
  late final FocusNode _quantityFocusNode;
  int _transferQuantity = 0;
  bool _isTransferring = false;
  String? _error;
  List<dynamic> _containers = [];
  String? _selectedContainerId;
  String _selectedContainerName = 'Select container';

  @override
  void initState() {
    super.initState();
    _transferQuantity = widget.sourceQuantity;
    _quantityController = TextEditingController(
      text: _transferQuantity.toString(),
    );
    _quantityFocusNode = FocusNode(debugLabel: 'TransferToContainerQuantity');
    _fetchContainers();
  }

  Future<void> _fetchContainers() async {
    setState(() {
      _containers = widget.containers
          .map((container) => {'id': container.id, 'name': container.name})
          .toList(growable: false);
    });
  }

  Future<void> _selectContainer(
    String containerId,
    String containerName,
  ) async {
    setState(() {
      _selectedContainerId = containerId;
      _selectedContainerName = containerName;
      _error = null;
    });
  }

  Future<void> _validateAndTransfer() async {
    if (_error != null) {
      setState(() => _error = null);
    }

    if (_selectedContainerId == null) {
      setState(() => _error = 'Please select a container');
      return;
    }

    final transferQuantity = int.tryParse(_quantityController.text);

    if (transferQuantity == null) {
      setState(() => _error = 'Please enter a valid number');
      return;
    }

    if (transferQuantity <= 0) {
      setState(() => _error = 'Transfer quantity must be greater than zero');
      return;
    }

    if (transferQuantity > widget.sourceQuantity) {
      setState(
        () => _error =
            'Transfer quantity cannot exceed source stack ($widget.sourceQuantity)',
      );
      return;
    }

    setState(() {
      _isTransferring = true;
      _error = null;
    });

    try {
      await widget.onTransfer(
        _selectedContainerId!,
        _selectedContainerName,
        transferQuantity,
      );
      if (!mounted) {
        return;
      }
      widget.onDismiss();
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isTransferring = false;
        _error = error is String ? error : 'Transfer failed.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      autofocus: true,
      child: Semantics(
        container: true,
        explicitChildNodes: true,
        namesRoute: true,
        label: 'Transfer to container dialog',
        child: AlertDialog(
          semanticLabel: 'Transfer to container dialog',
          title: const Text('Transfer to Container'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                container: true,
                label:
                    'Source item ${widget.sourceName}, quantity ${widget.sourceQuantity}',
                child: ExcludeSemantics(
                  child: Text(
                    'Transfer from: ${widget.sourceName} (${widget.sourceQuantity})',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                container: true,
                label: 'Select container',
                child: ExcludeSemantics(
                  child: Text(
                    'Select container:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _containers.map((container) {
                  final isSelected = _selectedContainerId == container['id'];
                  return Semantics(
                    container: true,
                    button: true,
                    selected: isSelected,
                    label: 'Container ${container['name'] as String}',
                    child: ChoiceChip(
                      label: Text(container['name'] as String),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          _selectContainer(
                            container['id'] as String,
                            container['name'] as String,
                          );
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
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
              Semantics(
                container: true,
                label: 'Transfer quantity',
                child: TextField(
                  controller: _quantityController,
                  focusNode: _quantityFocusNode,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Amount to transfer',
                    errorText: _error,
                  ),
                  onChanged: (value) {
                    final parsed = int.tryParse(value);
                    setState(() {
                      _transferQuantity = parsed ?? 0;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                container: true,
                label: 'After: ${widget.sourceQuantity - _transferQuantity}',
                child: ExcludeSemantics(
                  child: Text(
                    'After: ${widget.sourceQuantity - _transferQuantity}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Semantics(
              container: true,
              button: true,
              label: 'Cancel transfer',
              child: TextButton(
                onPressed: widget.onDismiss,
                child: const Text('Cancel'),
              ),
            ),
            Semantics(
              container: true,
              button: true,
              enabled: !_isTransferring,
              label: 'Transfer to container',
              child: ElevatedButton(
                onPressed: _isTransferring ? null : _validateAndTransfer,
                child: const Text('Transfer'),
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
