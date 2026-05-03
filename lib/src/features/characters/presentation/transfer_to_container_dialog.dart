import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:flutter/material.dart';

/// Dialog for transferring an inventory stack to a container
class TransferToContainerDialog extends StatefulWidget {
  final String sourceItemId;
  final int sourceQuantity;
  final VoidCallback onDismiss;
  final Function(String containerId, int quantity) onTransfer;

  const TransferToContainerDialog({
    super.key,
    required this.sourceItemId,
    required this.sourceQuantity,
    required this.onDismiss,
    required this.onTransfer,
  });

  @override
  State<TransferToContainerDialog> createState() =>
      _TransferToContainerDialogState();
}

class _TransferToContainerDialogState extends State<TransferToContainerDialog> {
  late TextEditingController _quantityController;
  int _transferQuantity = 0;
  bool _isTransferring = false;
  String? _error;
  List<CharacterEquipmentItemDomainModel> _containers = [];
  String? _selectedContainerId;
  String _selectedContainerName = 'Select container';

  @override
  void initState() {
    super.initState();
    _transferQuantity = widget.sourceQuantity;
    _quantityController = TextEditingController(
      text: _transferQuantity.toString(),
    );
    _fetchContainers();
  }

  Future<void> _fetchContainers() async {
    // Placeholder - containers should be fetched from repository
    // For now, using static sample data
    setState(() {
      _containers = [
        CharacterEquipmentItemDomainModel(
          id: 'char-1-container-1',
          name: 'Backpack',
          type: CharacterEquipmentItemDomainModelType.container,
          quantity: 999,
          isContainer: true,
          isEquipped: false,
          isCarried: true,
          weight: 5.0,
          inventoryItemId: null,
          chargesMax: null,
          chargesCurrent: null,
          stackStateLabel: 'Backpack',
          containerLabel: 'Backpack',
          containerDisplayName: 'Backpack',
          summaryLabel: 'Backpack',
        ),
        CharacterEquipmentItemDomainModel(
          id: 'char-1-container-2',
          name: 'Pouch',
          type: CharacterEquipmentItemDomainModelType.container,
          quantity: 999,
          isContainer: true,
          isEquipped: false,
          isCarried: true,
          weight: 1.0,
          inventoryItemId: null,
          chargesMax: null,
          chargesCurrent: null,
          stackStateLabel: 'Pouch',
          containerLabel: 'Pouch',
          containerDisplayName: 'Pouch',
          summaryLabel: 'Pouch',
        ),
        CharacterEquipmentItemDomainModel(
          id: 'char-1-container-3',
          name: 'Bag of Holding',
          type: CharacterEquipmentItemDomainModelType.container,
          quantity: 999,
          isContainer: true,
          isEquipped: false,
          isCarried: true,
          weight: 1.0,
          inventoryItemId: null,
          chargesMax: null,
          chargesCurrent: null,
          stackStateLabel: 'Bag of Holding',
          containerLabel: 'Bag of Holding',
          containerDisplayName: 'Bag of Holding',
          summaryLabel: 'Bag of Holding',
        ),
      ];
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

  void _validateAndTransfer() {
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

    widget.onTransfer(_selectedContainerId!, _transferQuantity);

    Future.delayed(const Duration(milliseconds: 100), () {
      widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Transfer to Container'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transfer from: ${widget.sourceItemId} (${widget.sourceQuantity})',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Select container:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _containers.map((container) {
              final isSelected = _selectedContainerId == container.id;
              return ChoiceChip(
                label: Text(container.name),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    _selectContainer(container.id, container.name);
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'After: ${widget.sourceQuantity - _transferQuantity}',
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
          onPressed: _isTransferring ? null : _validateAndTransfer,
          child: const Text('Transfer'),
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
