import 'package:flutter/material.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_spellbook_domain.dart';

/// Screen for managing wizard spellbook
class SpellbookManagementScreen extends StatefulWidget {
  final String characterId;
  final CharacterSpellbookDomainModel? currentSpellbook;
  final List<CharacterSpellReferenceDomainModel> availableSpells;
  final WizardSpellSelectionMode spellSelectionMode;
  final int selectionLimit;
  final Function(CharacterSpellbookDomainModel) onSave;
  final VoidCallback onDismiss;

  const SpellbookManagementScreen({
    super.key,
    required this.characterId,
    this.currentSpellbook,
    required this.availableSpells,
    required this.spellSelectionMode,
    required this.selectionLimit,
    required this.onSave,
    required this.onDismiss,
  });

  @override
  State<SpellbookManagementScreen> createState() =>
      _SpellbookManagementScreenState();
}

class _SpellbookManagementScreenState extends State<SpellbookManagementScreen> {
  late CharacterSpellbookDomainModel _spellbook;
  late CharacterSpellbookService _spellbookService;

  @override
  void initState() {
    super.initState();
    _spellbookService = const CharacterSpellbookService();
    _initializeSpellbook();
  }

  void _initializeSpellbook() {
    if (widget.currentSpellbook != null) {
      setState(() {
        _spellbook = widget.currentSpellbook!;
      });
    } else {
      setState(() {
        _spellbook = CharacterSpellbookDomainModel(
          spells: const <CharacterSpellReferenceDomainModel>[],
          spellSelectionMode: widget.spellSelectionMode,
          selectionLimit: widget.selectionLimit,
        );
      });
    }
  }

 bool _isSaving = false;

  void _selectSpell(String spellId, bool value) {
  if (_isSaving) return;

  final spellIndex = _spellbook.spells.indexWhere(
    (spell) => spell.id == spellId,
  );

  if (value && spellIndex == -1) {
    // Add spell
    final spell = widget.availableSpells.firstWhere(
      (s) => s.id == spellId,
    );

    final result = _spellbookService.addSpell(
      _spellbook.spells,
      spell,
      widget.selectionLimit,
      widget.spellSelectionMode,
    );

    if (result != null && mounted) {
      setState(() {
        _spellbook = CharacterSpellbookDomainModel(
          spells: result.spells,
          spellSelectionMode: _spellbook.spellSelectionMode,
          selectionLimit: _spellbook.selectionLimit,
        );
      });
    }
  } else if (!value && spellIndex != -1) {
    // Remove spell
    final result = _spellbookService.removeSpell(
      _spellbook.spells,
      spellId,
    );

    if (result != null && mounted) {
      setState(() {
        _spellbook = CharacterSpellbookDomainModel(
          spells: result.spells,
          spellSelectionMode: _spellbook.spellSelectionMode,
          selectionLimit: _spellbook.selectionLimit,
        );
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.spellSelectionMode == WizardSpellSelectionMode.prepared ? 'Prepared' : 'Known'} Spells',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isSaving ? null : _saveSpellbook,
            tooltip: 'Save Spellbook',
          ),
        ],
      ),
      body: _spellbook.spells.isEmpty
          ? _emptyState()
          : _spellbookListView(),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No spells selected',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Select spells from the list below',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _spellbookListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _spellbook.spells.length,
      itemBuilder: (context, index) {
        final spell = _spellbook.spells[index];
        return _SpellbookSpellItem(
          spell: spell,
          isSelected: true,
          onToggle: (value) => _selectSpell(spell.id, value),
        );
      },
    );
  }

  void _saveSpellbook() {
    setState(() {
      _isSaving = true;
    });

    widget.onSave(_spellbook);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    });
  }
}

class _SpellbookSpellItem extends StatelessWidget {
  final CharacterSpellReferenceDomainModel spell;
  final bool isSelected;
  final ValueChanged<bool> onToggle;

  const _SpellbookSpellItem({
    required this.spell,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: spell.isCantrip
              ? Colors.grey.shade200
              : Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            spell.levelLabel,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: spell.isCantrip
                  ? Colors.grey.shade700
                  : Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        title: Text(
          spell.name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            decoration: isSelected ? TextDecoration.underline : null,
          ),
        ),
        subtitle: Text(
          '${spell.school} • ${spell.castingTime} • ${spell.range} • ${spell.duration}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Switch(
          value: isSelected,
          onChanged: onToggle,
        ),
      ),
    );
  }
}
