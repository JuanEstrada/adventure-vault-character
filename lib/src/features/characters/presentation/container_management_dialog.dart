import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:flutter/material.dart';

/// Dialog for managing character containers (add, remove, rename)
class ContainerManagementDialog extends StatefulWidget {
  final List<CharacterEquipmentItemDomainModel> containers;
  final VoidCallback onDismiss;
  final Function(String containerId, String containerName) onRename;
  final Function(String containerId) onDelete;
  final Future<String> Function(String containerName) onAdd;

  const ContainerManagementDialog({
    super.key,
    required this.containers,
    required this.onDismiss,
    required this.onRename,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  State<ContainerManagementDialog> createState() =>
      _ContainerManagementDialogState();
}

class _ContainerManagementDialogState extends State<ContainerManagementDialog> {
  late TextEditingController _newContainerController;
  late final FocusNode _newContainerFocusNode;
  late List<CharacterEquipmentItemDomainModel> _containers;
  String? _selectedContainerId;

  @override
  void initState() {
    super.initState();
    _newContainerController = TextEditingController(text: 'New Container');
    _newContainerFocusNode = FocusNode(
      debugLabel: 'ContainerManagementNewContainer',
    );
    _containers = List<CharacterEquipmentItemDomainModel>.from(
      widget.containers,
    );
  }

  @override
  void didUpdateWidget(covariant ContainerManagementDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.containers != widget.containers) {
      _containers = List<CharacterEquipmentItemDomainModel>.from(
        widget.containers,
      );
    }
  }

  Future<void> _selectContainer(
    String containerId,
    String containerName,
  ) async {
    setState(() {
      _selectedContainerId = containerId;
    });
  }

  void _renameContainer() {
    if (_selectedContainerId == null) {
      return;
    }

    final newName = _newContainerController.text.trim();
    if (newName.isEmpty) {
      return;
    }

    widget.onRename(_selectedContainerId!, newName);

    Future.delayed(const Duration(milliseconds: 100), () {
      widget.onDismiss();
    });
  }

  Future<void> _addContainer() async {
    final newName = _newContainerController.text.trim();
    if (newName.isEmpty) {
      return;
    }

    final createdContainerId = await widget.onAdd(newName);
    if (createdContainerId.isEmpty) {
      return;
    }

    _newContainerController.clear();
    widget.onDismiss();
  }

  void _deleteContainer(String containerId, String containerName) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Container'),
        content: Text('Delete container "$containerName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onDelete(containerId);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      autofocus: true,
      child: AlertDialog(
        title: const Text('Manage Containers'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Containers:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              if (_containers.isEmpty)
                const Text(
                  'No containers found',
                  style: TextStyle(color: Colors.grey),
                )
              else
                ..._containers.map((container) {
                  final isSelected = _selectedContainerId == container.id;
                  final containerName = container.name;
                  final containerId = container.id;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            containerName,
                            style: isSelected
                                ? Theme.of(context).textTheme.titleMedium
                                : Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: isSelected
                              ? () => _renameContainer()
                              : () => _selectContainer(
                                  containerId,
                                  containerName,
                                ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              _deleteContainer(containerId, containerName),
                        ),
                      ],
                    ),
                  );
                }),
              const SizedBox(height: 16),
              Text(
                'Add new container:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _newContainerController,
                focusNode: _newContainerFocusNode,
                autofocus: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Container name',
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'After: ${_containers.length + 1} container(s)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: widget.onDismiss, child: const Text('Cancel')),
          ElevatedButton(
            onPressed: _selectedContainerId != null ? _renameContainer : null,
            child: const Text('Rename'),
          ),
          ElevatedButton(onPressed: _addContainer, child: const Text('Add')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _newContainerController.dispose();
    _newContainerFocusNode.dispose();
    super.dispose();
  }
}
