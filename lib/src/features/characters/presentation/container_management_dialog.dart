import 'dart:async';

import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:flutter/material.dart';

/// Dialog for managing character containers (add, remove, rename)
class ContainerManagementDialog extends StatefulWidget {
  final List<CharacterEquipmentItemDomainModel> containers;
  final VoidCallback onDismiss;
  final FutureOr<void> Function(String containerId, String containerName)
  onRename;
  final Future<void> Function(String containerId) onDelete;
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
  String? _selectedContainerName;
  bool _isProcessing = false;
  String? _error;

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
      _selectedContainerName = containerName;
      _error = null;
    });
  }

  Future<void> _renameContainer() async {
    if (_error != null) {
      setState(() => _error = null);
    }

    if (_selectedContainerId == null) {
      setState(() => _error = 'Please select a container to rename');
      return;
    }

    final newName = _newContainerController.text.trim();
    if (newName.isEmpty) {
      setState(() => _error = 'Container name cannot be empty');
      return;
    }

    setState(() {
      _isProcessing = true;
      _error = null;
    });

    try {
      await Future.sync(() => widget.onRename(_selectedContainerId!, newName));
      if (!mounted) return;
      widget.onDismiss();
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _error = error is String ? error : 'Failed to rename container';
      });
    }
  }

  Future<void> _addContainer() async {
    if (_error != null) {
      setState(() => _error = null);
    }

    final newName = _newContainerController.text.trim();
    if (newName.isEmpty) {
      setState(() => _error = 'Container name cannot be empty');
      return;
    }

    setState(() {
      _isProcessing = true;
      _error = null;
    });

    try {
      final createdContainerId = await widget.onAdd(newName);
      if (createdContainerId.isEmpty) {
        setState(() => _error = 'Failed to create container');
        _isProcessing = false;
        return;
      }

      _newContainerController.clear();
      widget.onDismiss();
    } catch (error) {
      setState(() {
        _isProcessing = false;
        _error = error is String ? error : 'Failed to create container';
      });
    }
  }

  void _deleteContainer(String containerId, String containerName) {
    if (_error != null) {
      setState(() => _error = null);
    }

    if (_selectedContainerId == null) {
      setState(() => _error = 'Please select a container to delete');
      return;
    }

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
            onPressed: () async {
              await widget.onDelete(containerId);
              if (!ctx.mounted) return;
              Navigator.pop(ctx);
              widget.onDismiss();
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
      child: Semantics(
        container: true,
        explicitChildNodes: true,
        namesRoute: true,
        label: 'Container management dialog',
        child: AlertDialog(
          semanticLabel: 'Container management dialog',
          title: const Text('Manage Containers'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  container: true,
                  label: 'Containers list',
                  child: ExcludeSemantics(
                    child: Text(
                      'Containers:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
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
                if (_containers.isEmpty)
                  const Text(
                    'No containers found',
                    style: TextStyle(color: Colors.grey),
                  )
                else ...[
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
                      key: Key('ContainerRow-$containerId'),
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
                          if (isSelected)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                'Selected',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          Semantics(
                            button: true,
                            selected: isSelected,
                            label: isSelected
                                ? 'Selected container ${container.name}'
                                : 'Select container ${container.name}',
                            child: TextButton(
                              key: Key('SelectContainer-$containerId'),
                              onPressed: _isProcessing
                                  ? null
                                  : () => _selectContainer(
                                      containerId,
                                      containerName,
                                    ),
                              child: Text(isSelected ? 'Selected' : 'Select'),
                            ),
                          ),
                          Semantics(
                            button: true,
                            label: 'Delete container',
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: _isProcessing
                                  ? null
                                  : () => _deleteContainer(
                                      containerId,
                                      containerName,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 12),
                  Semantics(
                    container: true,
                    label: _selectedContainerName == null
                        ? 'No container selected'
                        : 'Selected container ${_selectedContainerName!}',
                    child: ExcludeSemantics(
                      child: Text(
                        _selectedContainerName == null
                            ? 'Selected container: none'
                            : 'Selected container: ${_selectedContainerName!}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Semantics(
                  container: true,
                  label: 'Add new container',
                  child: ExcludeSemantics(
                    child: Text(
                      'Add new container:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Semantics(
                  container: true,
                  label: 'New container name',
                  child: TextField(
                    key: const Key('New container name'),
                    controller: _newContainerController,
                    focusNode: _newContainerFocusNode,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Container name',
                      errorText: _error,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Semantics(
                  container: true,
                  label: 'Number of containers',
                  child: ExcludeSemantics(
                    child: Text(
                      'After: ${_containers.length + 1} container(s)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Semantics(
              container: true,
              button: true,
              label: 'Close dialog',
              child: TextButton(
                onPressed: widget.onDismiss,
                child: const Text('Cancel'),
              ),
            ),
            Semantics(
              container: true,
              button: true,
              enabled: !_isProcessing,
              label: 'Rename container',
              child: ElevatedButton(
                key: const Key('Rename container'),
                onPressed: _isProcessing ? null : _renameContainer,
                child: const Text('Rename'),
              ),
            ),
            Semantics(
              container: true,
              button: true,
              enabled: !_isProcessing,
              label: 'Add container',
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _addContainer,
                child: const Text('Add'),
              ),
            ),
          ],
        ),
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
