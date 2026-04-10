import 'package:adventure_vault_character/src/features/characters/domain/character_combat_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const rules = CharacterCombatRules();

  group('armor class derivation', () {
    test('uses unarmored base with dexterity modifier', () {
      final result = rules.deriveArmorClass(
        dexterityModifier: 3,
        equippedItems: const <CharacterArmorProfile>[],
      );

      expect(result.armorClass, 13);
      expect(result.hasArmorConflict, isFalse);
    });

    test('applies light armor base plus full dexterity modifier', () {
      final result = rules.deriveArmorClass(
        dexterityModifier: 4,
        equippedItems: const <CharacterArmorProfile>[
          CharacterArmorProfile(name: 'Leather Armor', isEquipped: true),
        ],
      );

      expect(result.armorClass, 15);
      expect(result.hasArmorConflict, isFalse);
    });

    test('applies medium armor dexterity cap and shield bonus', () {
      final result = rules.deriveArmorClass(
        dexterityModifier: 4,
        equippedItems: const <CharacterArmorProfile>[
          CharacterArmorProfile(name: 'Half Plate', isEquipped: true),
          CharacterArmorProfile(name: 'Shield', isEquipped: true),
        ],
      );

      expect(result.armorClass, 19);
      expect(result.hasArmorConflict, isFalse);
    });

    test('uses heavy armor without dexterity modifier', () {
      final result = rules.deriveArmorClass(
        dexterityModifier: 5,
        equippedItems: const <CharacterArmorProfile>[
          CharacterArmorProfile(name: 'Chain Mail', isEquipped: true),
        ],
      );

      expect(result.armorClass, 16);
      expect(result.hasArmorConflict, isFalse);
    });

    test('flags multiple equipped body armors and uses highest result', () {
      final result = rules.deriveArmorClass(
        dexterityModifier: 2,
        equippedItems: const <CharacterArmorProfile>[
          CharacterArmorProfile(name: 'Leather Armor', isEquipped: true),
          CharacterArmorProfile(name: 'Chain Mail', isEquipped: true),
        ],
      );

      expect(result.armorClass, 16);
      expect(result.hasArmorConflict, isTrue);
    });
  });

  test('initiative derivation mirrors dexterity modifier', () {
    expect(rules.deriveInitiativeModifier(dexterityModifier: 3), 3);
    expect(rules.deriveInitiativeModifier(dexterityModifier: -1), -1);
  });

  group('weapon attack derivation', () {
    test('uses finesse weapon with the strongest modifier and proficiency', () {
      final attacks = rules.deriveWeaponAttacks(
        strengthModifier: 1,
        dexterityModifier: 3,
        proficiencyBonus: 2,
        weaponProficiencyKeys: const <String>{'simple-weapons'},
        equippedItems: const <CharacterWeaponProfile>[
          CharacterWeaponProfile(
            name: 'Dagger',
            isEquipped: true,
            category: 'weapon',
          ),
        ],
      );

      expect(attacks, hasLength(1));
      expect(attacks.first.attackAbilityKey, 'dex');
      expect(attacks.first.attackBonus, 5);
      expect(attacks.first.damageModifier, 3);
      expect(attacks.first.damageDice, '1d4');
      expect(attacks.first.damageType, 'piercing');
      expect(attacks.first.isProficient, isTrue);
    });

    test('uses ranged weapon with dexterity without proficiency bonus', () {
      final attacks = rules.deriveWeaponAttacks(
        strengthModifier: 4,
        dexterityModifier: 1,
        proficiencyBonus: 2,
        weaponProficiencyKeys: const <String>{'martial-weapons'},
        equippedItems: const <CharacterWeaponProfile>[
          CharacterWeaponProfile(
            name: 'Shortbow',
            isEquipped: true,
            category: 'weapon',
          ),
        ],
      );

      expect(attacks, hasLength(1));
      expect(attacks.first.attackAbilityKey, 'dex');
      expect(attacks.first.attackBonus, 1);
      expect(attacks.first.damageModifier, 1);
      expect(attacks.first.isProficient, isFalse);
    });

    test('applies explicit json attack and damage modifiers', () {
      final attacks = rules.deriveWeaponAttacks(
        strengthModifier: 0,
        dexterityModifier: 2,
        proficiencyBonus: 2,
        weaponProficiencyKeys: const <String>{'longsword'},
        equippedItems: const <CharacterWeaponProfile>[
          CharacterWeaponProfile(
            name: 'Longsword +1',
            isEquipped: true,
            category: 'weapon',
            weaponPropertiesJson:
                '{"damage_dice":"1d8","damage_type":"slashing","attack_bonus":1,"damage_bonus":1,"proficiency_key":"longsword","weapon_category":"martial"}',
          ),
        ],
      );

      expect(attacks, hasLength(1));
      expect(attacks.first.attackAbilityKey, 'str');
      expect(attacks.first.attackBonus, 3);
      expect(attacks.first.damageModifier, 1);
      expect(attacks.first.damageDice, '1d8');
      expect(attacks.first.isProficient, isTrue);
    });

    test('ignores unequipped weapons', () {
      final attacks = rules.deriveWeaponAttacks(
        strengthModifier: 2,
        dexterityModifier: 2,
        proficiencyBonus: 2,
        weaponProficiencyKeys: const <String>{'simple-weapons'},
        equippedItems: const <CharacterWeaponProfile>[
          CharacterWeaponProfile(name: 'Mace', isEquipped: false),
        ],
      );

      expect(attacks, isEmpty);
    });
  });
}
