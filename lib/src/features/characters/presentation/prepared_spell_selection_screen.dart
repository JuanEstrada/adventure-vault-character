import 'package:flutter/material.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/prepared_spell_selection_domain.dart';

/// Screen for selecting prepared spells (cleric, paladin, druid, bard)
class PreparedSpellSelectionScreen extends StatefulWidget {
  final String characterId;
  final CharacterSpellcastingDomainModel? currentSpellcasting;
  final List<CharacterSpellReferenceDomainModel> availableSpells;
  final int selectionLimit;
  final Function(CharacterSpellcastingDomainModel) onSave;
  final VoidCallback onDismiss;

  const PreparedSpellSelectionScreen({
    super.key,
    required this.characterId,
    this.currentSpellcasting,
    required this.availableSpells,
    required this.selectionLimit,
    required this.onSave,
    required this.onDismiss,
  });

  @override
  State<PreparedSpellSelectionScreen> createState() =>
      _PreparedSpellSelectionScreenState();
}

class _PreparedSpellSelectionScreenState
    extends State<PreparedSpellSelectionScreen> {
  late CharacterSpellcastingDomainModel _spellcasting;
  late PreparedSpellSelectionService _selectionService;

  @override
  void initState() {
    super.initState();
    _selectionService = const PreparedSpellSelectionService();
    _initializeSpellcasting();
  }

  void _initializeSpellcasting() {
    if (widget.currentSpellcasting != null) {
      setState(() {
        _spellcasting = widget.currentSpellcasting!;
      });
    } else {
      setState(() {
        _spellcasting = CharacterSpellcastingDomainModel(
          abilityKey: 'wisdom',
          abilityLabel: 'Wisdom',
          abilityScore: 10,
          proficiencyBonus: 2,
          availableSpells: const <CharacterSpellReferenceDomainModel>[],
          selectionMode: CharacterSpellSelectionMode.prepared,
          selectedSpells: const <CharacterSpellReferenceDomainModel>[],
          slotProgression: const <CharacterSpellSlotDomainModel>[],
          selectionLimit: widget.selectionLimit,
        );
      });
    }
  }

  bool _isSaving = false;

  void _toggleSpell(String spellId, bool value) {
    if (_isSaving) return;

    final spellIndex = _spellcasting.selectedSpells.indexWhere(
      (spell) => spell.id == spellId,
    );

    if (value && spellIndex == -1) {
      final spell = widget.availableSpells.firstWhere((s) => s.id == spellId);

      final result = _selectionService.selectSpell(
        _spellcasting.selectedSpells,
        spell,
      );

      if (result != null && mounted) {
        setState(() {
          _spellcasting = CharacterSpellcastingDomainModel(
            abilityKey: _spellcasting.abilityKey,
            abilityLabel: _spellcasting.abilityLabel,
            abilityScore: _spellcasting.abilityScore,
            proficiencyBonus: _spellcasting.proficiencyBonus,
            availableSpells: _spellcasting.availableSpells,
            selectionMode: _spellcasting.selectionMode,
            selectedSpells: result.selectedSpells,
            slotProgression: _spellcasting.slotProgression,
            selectionLimit: _spellcasting.selectionLimit,
          );
        });
      }
    } else if (!value && spellIndex != -1) {
      final result = _selectionService.selectSpell(
        _spellcasting.selectedSpells,
        CharacterSpellReferenceDomainModel(
          id: spellId,
          name: '',
          level: 0,
          school: '',
          castingTime: '',
          range: '',
          duration: '',
          source: '',
        ),
      );

      if (result != null && mounted) {
        setState(() {
          _spellcasting = CharacterSpellcastingDomainModel(
            abilityKey: _spellcasting.abilityKey,
            abilityLabel: _spellcasting.abilityLabel,
            abilityScore: _spellcasting.abilityScore,
            proficiencyBonus: _spellcasting.proficiencyBonus,
            availableSpells: _spellcasting.availableSpells,
            selectionMode: _spellcasting.selectionMode,
            selectedSpells: result.selectedSpells,
            slotProgression: _spellcasting.slotProgression,
            selectionLimit: _spellcasting.selectionLimit,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prepared Spells'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isSaving ? null : _saveSpellbook,
            tooltip: 'Save Spells',
          ),
        ],
      ),
      body: _spellcasting.selectedSpells.isEmpty
          ? _emptyState()
          : _spellListView(),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No spells prepared',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Select spells from the list below',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _spellListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _spellcasting.selectedSpells.length,
      itemBuilder: (context, index) {
        final spell = _spellcasting.selectedSpells[index];
        return _SpellbookSpellItem(
          spell: spell,
          isSelected: true,
          onToggle: () => _toggleSpell(spell.id, true),
        );
      },
    );
  }

  void _saveSpellbook() {
    setState(() {
      _isSaving = true;
    });

    widget.onSave(_spellcasting);

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
  final VoidCallback onToggle;

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
          backgroundColor: spell.level == 0
              ? Colors.grey.shade200
              : Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            spell.level == 0 ? 'Cantrip' : 'Level ${spell.level}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: spell.level == 0
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
        trailing: Switch(value: isSelected, onChanged: (value) => onToggle()),
      ),
    );
  }
}
