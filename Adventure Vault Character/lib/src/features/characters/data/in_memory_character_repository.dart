import 'dart:async';

import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_spell_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary_mapper.dart';
import 'package:adventure_vault_character/src/features/characters/domain/editable_character.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

class InMemoryCharacterRepository implements CharacterRepository {
  InMemoryCharacterRepository.empty({
    required CompendiumRepository compendiumRepository,
  }) : _summaries = <CharacterSummary>[],
       _createdInputsById = <String, CreateCharacterInput>{},
       _compendiumRepository = compendiumRepository;

  InMemoryCharacterRepository.seeded(
    List<CharacterSummary> summaries, {
    required CompendiumRepository compendiumRepository,
  }) : _summaries = List<CharacterSummary>.from(summaries),
       _createdInputsById = <String, CreateCharacterInput>{},
       _compendiumRepository = compendiumRepository;

  final List<CharacterSummary> _summaries;
  final Map<String, CreateCharacterInput> _createdInputsById;
  final CompendiumRepository _compendiumRepository;
  final CharacterSummaryMapper _characterSummaryMapper =
      const CharacterSummaryMapper();
  final CharacterSpellRules _characterSpellRules = const CharacterSpellRules();
  final StreamController<void> _changes = StreamController<void>.broadcast();

  @override
  Future<List<CharacterSummary>> getCharacterSummaries() async {
    return List<CharacterSummary>.unmodifiable(_summaries);
  }

  @override
  Stream<List<CharacterSummary>> watchCharacterSummaries() async* {
    yield await getCharacterSummaries();
    yield* _changes.stream.asyncMap((_) => getCharacterSummaries());
  }

  @override
  Future<CharacterSummary> createCharacter(CreateCharacterInput input) async {
    if (input.equipmentLoadoutId == 'fallback-loadout' ||
        input.selectedEquipmentItems.any(_isPlaceholderEquipmentItem)) {
      throw StateError('Unsupported equipment loadout selected.');
    }

    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final summary = _characterSummaryMapper.fromCreateInput(
      id: id,
      input: input,
    );
    _summaries.insert(0, summary);
    _createdInputsById[id] = input;
    _changes.add(null);
    return summary;
  }

  @override
  Future<CharacterSummary> updateCharacter(
    String id,
    CreateCharacterInput input,
  ) async {
    final existingIndex = _summaries.indexWhere((summary) => summary.id == id);
    if (existingIndex < 0) {
      throw StateError('Character not found.');
    }

    final summary = _characterSummaryMapper.fromCreateInput(
      id: id,
      input: input,
    );
    _summaries[existingIndex] = summary;
    _createdInputsById[id] = input;
    _changes.add(null);
    return summary;
  }

  @override
  Future<CharacterSummary?> getCharacterSummaryById(String id) async {
    for (final summary in _summaries) {
      if (summary.id == id) {
        return summary;
      }
    }
    return null;
  }

  @override
  Future<CharacterDomainModel?> getCharacterSheetById(String id) async {
    final summary = await getCharacterSummaryById(id);
    if (summary == null) {
      return null;
    }
    final createdInput = _createdInputsById[id];

    final catalog = await _compendiumRepository.loadCatalog();
    final background =
        catalog.backgroundById(createdInput?.backgroundId) ??
        catalog.backgrounds.first;
    final className = createdInput?.className ?? summary.className;
    final equipmentLoadout = catalog.equipmentLoadoutsForClass(className).first;
    final constitutionScore = createdInput?.constitution ?? 13;
    final level = createdInput?.level ?? summary.level;
    final hitPoints = CharacterRules.startingHitPoints(
      hitDie: _hitDieForClass(className),
      constitutionScore: constitutionScore,
      level: level,
    );
    final selectedItems =
        createdInput?.selectedEquipmentItems ?? equipmentLoadout.selectedItems;
    final inventoryItems = selectedItems
        .map(_parseInventoryItemSpec)
        .toList(growable: false);
    final progression = CharacterProgressionDomainModel(
      level: summary.level,
      experience: createdInput?.experience ?? 0,
    );
    final spellcasting = _buildSpellcastingSummary(
      className: className,
      catalog: catalog,
      progression: progression,
      spellState:
          createdInput?.spellState ?? const CharacterSpellStateInput.empty(),
      strength: createdInput?.strength ?? 15,
      dexterity: createdInput?.dexterity ?? 14,
      constitution: createdInput?.constitution ?? 13,
      intelligence: createdInput?.intelligence ?? 12,
      wisdom: createdInput?.wisdom ?? 10,
      charisma: createdInput?.charisma ?? 8,
    );

    return CharacterDomainModel(
      id: summary.id,
      identity: CharacterIdentityDomainModel(
        name: summary.name,
        raceName: summary.raceName,
        className: summary.className,
        progression: progression,
      ),
      combat: CharacterCombatDomainModel(
        hitPoints: CharacterHitPointsDomainModel(
          current: hitPoints,
          maximum: hitPoints,
          temporary: 0,
        ),
        savingThrows: const <CharacterSavingThrowDomainModel>[],
      ),
      abilities: CharacterAbilitiesDomainModel(
        methodKey: createdInput?.abilityScoreMethod,
        entries: <CharacterAbilityScoreDomainModel>[
          _abilityRow('Strength', createdInput?.strength ?? 15),
          _abilityRow('Dexterity', createdInput?.dexterity ?? 14),
          _abilityRow('Constitution', createdInput?.constitution ?? 13),
          _abilityRow('Intelligence', createdInput?.intelligence ?? 12),
          _abilityRow('Wisdom', createdInput?.wisdom ?? 10),
          _abilityRow('Charisma', createdInput?.charisma ?? 8),
        ],
      ),
      featuresNotes: CharacterFeaturesNotesDomainModel(
        background: CharacterBackgroundDomainModel(
          name: createdInput?.backgroundName ?? background.name,
          summary: createdInput?.backgroundSummary ?? background.summary,
          bonuses: background.bonuses
              .map(_mapBackgroundEntry)
              .toList(growable: false),
          socialPerks: background.socialPerks
              .map(_mapBackgroundEntry)
              .toList(growable: false),
        ),
        proficientSkills: _extractBackgroundSkillLabels(background)
            .map(
              (item) => CharacterSkillDomainModel(
                name: item,
                isProficient: true,
                hasExpertise: false,
              ),
            )
            .toList(growable: false),
        otherProficiencies: <CharacterProficiencyDomainModel>[
          ..._extractBackgroundLanguageKeys(background).map(
            (item) => CharacterProficiencyDomainModel(
              proficiencyType: 'language',
              referenceKey: item,
            ),
          ),
          ..._extractBackgroundNarrativeBonuses(background).map(
            (item) => CharacterProficiencyDomainModel(
              proficiencyType: 'background',
              referenceKey: item,
            ),
          ),
        ],
        finishingDetails: CharacterFinishingDetailsDomainModel(
          portraitAssetPath: createdInput?.portraitAssetPath,
          appearanceDetails: createdInput?.appearanceDetails ?? '',
          narrativeNotes: createdInput?.narrativeDetails ?? '',
          narrativeSelections: NarrativeFieldKey.values
              .map(
                (fieldKey) => CharacterNarrativeSelectionDomainModel(
                  fieldKey: fieldKey,
                  mode:
                      createdInput?.finishingDetails
                          .selectionFor(fieldKey)
                          .mode ??
                      NarrativeSelectionMode.empty,
                  valueText: createdInput?.finishingDetails.valueFor(fieldKey),
                ),
              )
              .toList(growable: false),
        ),
      ),
      equipment: CharacterEquipmentDomainModel(
        equipmentSummary: catalog.equipmentSummaryForClass(className),
        selectedEquipmentLabel:
            createdInput?.equipmentLoadoutLabel ?? equipmentLoadout.label,
        money: CharacterMoneySummaryDomainModel(
          currencySummary:
              createdInput?.startingMoneySummary ??
              equipmentLoadout.startingMoneySummary,
          startingMoneySummary:
              createdInput?.startingMoneySummary ??
              equipmentLoadout.startingMoneySummary,
        ),
        items: inventoryItems
            .map(
              (item) => CharacterEquipmentItemDomainModel(
                name: item.name,
                quantity: item.quantity,
                isEquipped: _looksEquipped(item.name),
              ),
            )
            .toList(growable: false),
      ),
      spellcasting: spellcasting,
    );
  }

  @override
  Stream<CharacterDomainModel?> watchCharacterSheetById(String id) async* {
    yield await getCharacterSheetById(id);
    yield* _changes.stream.asyncMap((_) => getCharacterSheetById(id));
  }

  @override
  Future<EditableCharacter?> getEditableCharacterById(String id) async {
    final sheet = await getCharacterSheetById(id);
    final createdInput = _createdInputsById[id];
    if (sheet == null) {
      return null;
    }

    final provenance = <String, int>{
      'Strength': createdInput?.strength ?? sheet.abilities.entries[0].score,
      'Dexterity': createdInput?.dexterity ?? sheet.abilities.entries[1].score,
      'Constitution':
          createdInput?.constitution ?? sheet.abilities.entries[2].score,
      'Intelligence':
          createdInput?.intelligence ?? sheet.abilities.entries[3].score,
      'Wisdom': createdInput?.wisdom ?? sheet.abilities.entries[4].score,
      'Charisma': createdInput?.charisma ?? sheet.abilities.entries[5].score,
    };

    return EditableCharacter(
      id: id,
      identity: EditableCharacterIdentity(
        name: sheet.identity.name,
        raceName: sheet.identity.raceName,
        className: sheet.identity.className,
        portraitAssetPath: createdInput?.portraitAssetPath,
      ),
      background: EditableCharacterBackground(
        id: createdInput?.backgroundId,
        name: sheet.featuresNotes.background.name,
        summary: sheet.featuresNotes.background.summary,
        bonuses: sheet.featuresNotes.background.bonuses,
        socialPerks: sheet.featuresNotes.background.socialPerks,
      ),
      abilities: EditableCharacterAbilities(
        methodKey: sheet.abilities.methodKey,
        entries: sheet.abilities.entries,
        provenance: EditableAbilityScoreProvenance(
          rawValue: createdInput?.abilityScoreProvenance,
          methodKey:
              createdInput?.abilityScoreMethod ?? sheet.abilities.methodKey,
          assignedScoresByAbility: provenance,
        ),
      ),
      progression: sheet.identity.progression,
      hitPoints: sheet.combat.hitPoints,
      spellState: EditableCharacterSpellState(
        selectionMode: createdInput?.spellState.selectionMode,
        selectedSpells:
            createdInput?.spellState.selectedSpells ??
            const <CharacterSpellSelectionInput>[],
        slotUsages:
            createdInput?.spellState.slotUsages ??
            const <CharacterSpellSlotUsageInput>[],
      ),
      equipment: EditableCharacterEquipment(
        loadoutId: createdInput?.equipmentLoadoutId,
        loadoutLabel: sheet.equipment.selectedEquipmentLabel,
        startingMoneySummary: sheet.equipment.money.startingMoneySummary,
        currencySummary: sheet.equipment.money.currencySummary,
        items: sheet.equipment.items
            .map(
              (item) => EditableCharacterEquipmentItem(
                name: item.name,
                quantity: item.quantity,
                isEquipped: item.isEquipped,
              ),
            )
            .toList(growable: false),
      ),
      finishingDetails: EditableCharacterFinishingDetails(
        appearanceDetails: sheet.featuresNotes.appearanceDetails,
        narrativeNotes: sheet.featuresNotes.narrativeDetails,
        portraitAssetPath: createdInput?.portraitAssetPath,
        narrativeSelections:
            createdInput?.finishingDetails.narrativeSelections ??
            CharacterFinishingDetailsInput.empty().narrativeSelections,
      ),
      createdAt: DateTime.fromMicrosecondsSinceEpoch(int.tryParse(id) ?? 0),
      updatedAt: DateTime.fromMicrosecondsSinceEpoch(int.tryParse(id) ?? 0),
    );
  }

  CharacterAbilityScoreDomainModel _abilityRow(String label, int score) {
    return CharacterAbilityScoreDomainModel(label: label, score: score);
  }

  CharacterBackgroundEntryDomainModel _mapBackgroundEntry(String raw) {
    final separatorIndex = raw.indexOf(':');
    if (separatorIndex <= 0 || separatorIndex >= raw.length - 1) {
      return CharacterBackgroundEntryDomainModel(
        label: raw.trim(),
        description: '',
      );
    }

    return CharacterBackgroundEntryDomainModel(
      label: raw.substring(0, separatorIndex).trim(),
      description: raw.substring(separatorIndex + 1).trim(),
    );
  }

  int _hitDieForClass(String className) {
    const hitDieByClass = <String, int>{
      'barbarian': 12,
      'bard': 8,
      'cleric': 8,
      'druid': 8,
      'fighter': 10,
      'monk': 8,
      'paladin': 10,
      'ranger': 10,
      'rogue': 8,
      'sorcerer': 6,
      'warlock': 8,
      'wizard': 6,
    };
    final key = _slugify(className);
    return hitDieByClass[key] ?? 10;
  }

  _InventoryItemSpec _parseInventoryItemSpec(String raw) {
    final trimmed = raw.trim();
    final match = RegExp(r'^(\d+)\s+(.+)$').firstMatch(trimmed);
    if (match == null) {
      return _InventoryItemSpec(name: trimmed, quantity: 1);
    }

    final quantity = int.tryParse(match.group(1) ?? '') ?? 1;
    final name = (match.group(2) ?? trimmed).trim();
    return _InventoryItemSpec(name: name, quantity: quantity);
  }

  bool _looksEquipped(String itemName) {
    final lower = itemName.toLowerCase();
    return lower.contains('mail') ||
        lower.contains('armor') ||
        lower.contains('shield') ||
        lower.contains('sword') ||
        lower.contains('dagger') ||
        lower.contains('staff') ||
        lower.contains('bow');
  }

  bool _isPlaceholderEquipmentItem(String itemName) {
    return itemName.trim().toLowerCase().contains('pending');
  }

  CharacterSpellcastingDomainModel? _buildSpellcastingSummary({
    required String className,
    required CompendiumCatalog catalog,
    required CharacterProgressionDomainModel progression,
    required CharacterSpellStateInput spellState,
    required int strength,
    required int dexterity,
    required int constitution,
    required int intelligence,
    required int wisdom,
    required int charisma,
  }) {
    final abilityKey = _spellcastingAbilityForClass(className);
    if (abilityKey == null) {
      return null;
    }

    final abilityScore = switch (abilityKey) {
      'STR' => strength,
      'DEX' => dexterity,
      'CON' => constitution,
      'INT' => intelligence,
      'WIS' => wisdom,
      'CHA' => charisma,
      _ => 0,
    };
    final availableSpells =
        catalog.spells
            .where(
              (spell) => spell.classes.any(
                (item) =>
                    _normalizeClassName(item) == _normalizeClassName(className),
              ),
            )
            .map(
              (spell) => CharacterSpellReferenceDomainModel(
                id: spell.id,
                name: spell.name,
                level: spell.level,
                school: spell.school,
                castingTime: spell.castingTime,
                range: spell.range,
                duration: spell.duration,
                source: spell.source,
              ),
            )
            .toList(growable: false)
          ..sort((left, right) {
            final byLevel = left.level.compareTo(right.level);
            if (byLevel != 0) {
              return byLevel;
            }
            return left.name.compareTo(right.name);
          });
    final availableSpellsById = <String, CharacterSpellReferenceDomainModel>{
      for (final spell in availableSpells) spell.id: spell,
    };
    final expectedMode = _characterSpellRules.selectionModeForClass(className);
    final spellbookSpells = spellState.selectedSpells
        .where((selection) => selection.selectionMode == expectedMode)
        .map((selection) => availableSpellsById[selection.spellId])
        .whereType<CharacterSpellReferenceDomainModel>()
        .toList(growable: false);
    final preparedSpells = spellState.selectedSpells
        .where(
          (selection) =>
              selection.selectionMode == CharacterSpellSelectionMode.prepared,
        )
        .map((selection) => availableSpellsById[selection.spellId])
        .whereType<CharacterSpellReferenceDomainModel>()
        .toList(growable: false);
    final selectedSpells = expectedMode == CharacterSpellSelectionMode.spellbook
        ? preparedSpells
        : spellbookSpells;
    final effectiveAvailableSpells =
        expectedMode == CharacterSpellSelectionMode.spellbook &&
            spellbookSpells.isNotEmpty
        ? spellbookSpells
        : availableSpells;
    final slotProgression = _characterSpellRules.slotProgressionFor(
      className: className,
      level: progression.level,
    );
    final slotUsageByLevel = <int, int>{
      for (final usage in spellState.slotUsages)
        usage.spellLevel: usage.slotsExpended,
    };

    return CharacterSpellcastingDomainModel(
      abilityKey: abilityKey,
      abilityLabel: _spellcastingAbilityLabel(abilityKey),
      abilityScore: abilityScore,
      proficiencyBonus: progression.proficiencyBonus,
      availableSpells: effectiveAvailableSpells,
      selectionMode: expectedMode,
      selectedSpells: selectedSpells,
      selectionLimit: _characterSpellRules.selectionLimitFor(
        className: className,
        level: progression.level,
        abilityModifier: CharacterRules.abilityModifier(abilityScore),
      ),
      slotProgression: slotProgression
          .map(
            (slot) => CharacterSpellSlotDomainModel(
              spellLevel: slot.spellLevel,
              slotsExpended: (slotUsageByLevel[slot.spellLevel] ?? 0).clamp(
                0,
                slot.slotsMax,
              ),
              slotsMax: slot.slotsMax,
            ),
          )
          .toList(growable: false),
    );
  }

  List<String> _extractBackgroundSkillLabels(CompendiumBackground background) {
    final skillBonus = background.bonuses.firstWhere(
      (bonus) => bonus.toLowerCase().startsWith('skills:'),
      orElse: () => '',
    );
    if (skillBonus.isEmpty) {
      return const <String>[];
    }

    return skillBonus
        .replaceFirst(RegExp(r'^skills:\s*', caseSensitive: false), '')
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }

  List<String> _extractBackgroundLanguageKeys(CompendiumBackground background) {
    final languageBonus = background.bonuses.firstWhere(
      (bonus) => bonus.toLowerCase().startsWith('languages:'),
      orElse: () => '',
    );
    if (languageBonus.isEmpty) {
      return const <String>[];
    }

    return languageBonus
        .replaceFirst(RegExp(r'^languages:\s*', caseSensitive: false), '')
        .split(',')
        .map((item) => _slugify(item))
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }

  List<String> _extractBackgroundNarrativeBonuses(
    CompendiumBackground background,
  ) {
    return background.bonuses
        .where((bonus) {
          final normalized = bonus.toLowerCase();
          return !normalized.startsWith('skills:') &&
              !normalized.startsWith('languages:') &&
              bonus.trim().isNotEmpty;
        })
        .toList(growable: false);
  }

  String _slugify(String raw) {
    return raw
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }

  String? _spellcastingAbilityForClass(String className) {
    return switch (_normalizeClassName(className)) {
      'bard' => 'CHA',
      'cleric' => 'WIS',
      'druid' => 'WIS',
      'paladin' => 'CHA',
      'ranger' => 'WIS',
      'sorcerer' => 'CHA',
      'warlock' => 'CHA',
      'wizard' => 'INT',
      _ => null,
    };
  }

  String _spellcastingAbilityLabel(String abilityKey) {
    return switch (abilityKey) {
      'STR' => 'Strength',
      'DEX' => 'Dexterity',
      'CON' => 'Constitution',
      'INT' => 'Intelligence',
      'WIS' => 'Wisdom',
      'CHA' => 'Charisma',
      _ => abilityKey,
    };
  }

  String _normalizeClassName(String raw) {
    return raw.trim().toLowerCase();
  }
}

class _InventoryItemSpec {
  const _InventoryItemSpec({required this.name, required this.quantity});

  final String name;
  final int quantity;
}
