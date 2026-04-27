import 'package:flutter/material.dart';

/// Dialog for managing character containers (add, remove, rename)
class ContainerManagementDialog extends StatefulWidget {
  final String characterId;
  final VoidCallback onDismiss;
  final Function(String containerId, String containerName) onRename;
  final Function(String containerId) onDelete;
  final Function(String containerId, String containerName) onAdd;

  const ContainerManagementDialog({
    super.key,
    required this.characterId,
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
  List<dynamic> _containers = [];
  String? _selectedContainerId;

  @override
  void initState() {
    super.initState();
    _newContainerController = TextEditingController(text: 'New Container');
    _fetchContainers();
  }

  Future<void> _fetchContainers() async {
    // Placeholder - containers should be fetched from repository
    // For now, using static sample data
    setState(() {
      _containers = [
        {'id': 'char-1-container-1', 'name': 'Backpack'},
        {'id': 'char-1-container-2', 'name': 'Pouch'},
        {'id': 'char-1-container-3', 'name': 'Bag of Holding'},
      ];
    });
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

  void _addContainer() {
    final newName = _newContainerController.text.trim();
    if (newName.isEmpty) {
      return;
    }

    widget.onAdd('new-container-id', newName);

    _newContainerController.clear();
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
    return AlertDialog(
      title: const Text('Manage Containers'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Containers:', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          if (_containers.isEmpty)
            const Text(
              'No containers found',
              style: TextStyle(color: Colors.grey),
            )
          else
            ..._containers.map((container) {
              final isSelected = _selectedContainerId == container['id'];
              final containerName = container['name'] as String;
              final containerId = container['id'] as String;

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
                          : () => _selectContainer(containerId, containerName),
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
      actions: [
        TextButton(onPressed: widget.onDismiss, child: const Text('Cancel')),
        ElevatedButton(
          onPressed: _selectedContainerId != null ? _renameContainer : null,
          child: const Text('Rename'),
        ),
        ElevatedButton(onPressed: _addContainer, child: const Text('Add')),
      ],
    );
  }

  @override
  void dispose() {
    _newContainerController.dispose();
    super.dispose();
  }
}
