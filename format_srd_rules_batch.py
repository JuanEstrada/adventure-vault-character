from __future__ import annotations

import re
from pathlib import Path


ROOT = Path(
    r"C:/Users/Mocy/Documents/Playground/Adventure Vault Character/local-assets/por ordenar/srd_rules"
)


def replace_block(text: str, old: str, new: str) -> str:
    return text.replace(old, new) if old in text else text


def apply_known_table_replacements(path: Path, text: str) -> str:
    replacements = {
        "character-creation/level-advancement.md": [
            (
                """Character Advancement

| Level | Experience Points | Proficiency Bonus |
| :---: | ---: | :---: |
| 1 | 0 | +2 |
| 2 | 300 | +2 |
| 3 | 900 | +2 |
| 4 | 2,700 | +2 |
| 5 | 6,500 | +3 |
| 6 | 14,000 | +3 |
| 7 | 23,000 | +3 |
| 8 | 34,000 | +3 |
| 9 | 48,000 | +4 |
| 10 | 64,000 | +4 |
| 11 | 85,000 | +4 |
| 12 | 100,000 | +4 |
| 13 | 120,000 | +5 |
| 14 | 140,000 | +5 |
| 15 | 165,000 | +5 |
| 16 | 195,000 | +5 |
| 17 | 225,000 | +6 |
| 18 | 265,000 | +6 |
| 19 | 305,000 | +6 |
| 20 | 355,000 | +6 |""",
                """## Character Advancement

| Level | Experience Points | Proficiency Bonus |
| :---: | ---: | :---: |
| 1 | 0 | +2 |
| 2 | 300 | +2 |
| 3 | 900 | +2 |
| 4 | 2,700 | +2 |
| 5 | 6,500 | +3 |
| 6 | 14,000 | +3 |
| 7 | 23,000 | +3 |
| 8 | 34,000 | +3 |
| 9 | 48,000 | +4 |
| 10 | 64,000 | +4 |
| 11 | 85,000 | +4 |
| 12 | 100,000 | +4 |
| 13 | 120,000 | +5 |
| 14 | 140,000 | +5 |
| 15 | 165,000 | +5 |
| 16 | 195,000 | +5 |
| 17 | 225,000 | +6 |
| 18 | 265,000 | +6 |
| 19 | 305,000 | +6 |
| 20 | 355,000 | +6 |""",
            ),
            (
                """Fixed Hit Points by Class

| Class | Hit Points per Level |
| --- | --- |
| Barbarian | 7 + Con. modifier |
| Fighter, Paladin, or Ranger | 6 + Con. modifier |
| Bard, Cleric, Druid, Monk, Rogue, or Warlock | 5 + Con. modifier |
| Sorcerer or Wizard | 4 + Con. modifier |""",
                """## Fixed Hit Points by Class

| Class | Hit Points per Level |
| --- | --- |
| Barbarian | 7 + Con. modifier |
| Fighter, Paladin, or Ranger | 6 + Con. modifier |
| Bard, Cleric, Druid, Monk, Rogue, or Warlock | 5 + Con. modifier |
| Sorcerer or Wizard | 4 + Con. modifier |""",
            ),
        ],
        "equipment/coins.md": [
            (
                """Coin Values
Coin Value in GP
Copper Piece (CP) 1/100
Silver Piece (SP) 1/10
Electrum Piece (EP) 1/2
Gold Piece (GP) 1
Platinum Piece (PP) 10""",
                """## Coin Values

| Coin | Value in GP |
| --- | ---: |
| Copper Piece (CP) | 1/100 |
| Silver Piece (SP) | 1/10 |
| Electrum Piece (EP) | 1/2 |
| Gold Piece (GP) | 1 |
| Platinum Piece (PP) | 10 |""",
            )
        ],
        "equipment/hirelings.md": [
            (
                """Hirelings
Service Cost
Skilled hireling 2 GP per day
Untrained hireling 2 SP per day
Messenger 2 CP per mile""",
                """## Hirelings

| Service | Cost |
| --- | ---: |
| Skilled hireling | 2 GP per day |
| Untrained hireling | 2 SP per day |
| Messenger | 2 CP per mile |""",
            )
        ],
        "equipment/spellcasting.md": [
            (
                """Spellcasting Services
Spell Level Availability Cost
Cantrip Village, town, or city 30 GP
1 Village, town, or city 50 GP
2 Village, town, or city 200 GP
3 Town or city only 300 GP
4–5 Town or city only 2,000 GP
6–8 City only 20,000 GP
9 City only 100,000 GP""",
                """## Spellcasting Services

| Spell Level | Availability | Cost |
| :---: | --- | ---: |
| Cantrip | Village, town, or city | 30 GP |
| 1 | Village, town, or city | 50 GP |
| 2 | Village, town, or city | 200 GP |
| 3 | Town or city only | 300 GP |
| 4–5 | Town or city only | 2,000 GP |
| 6–8 | City only | 20,000 GP |
| 9 | City only | 100,000 GP |""",
            )
        ],
        "equipment/scribing-spell-scrolls.md": [
            (
                """Spell Scroll Costs
Spell Level  Time  Cost
Cantrip 1 day 15 GP
1 1 day 25 GP
2 3 days 100 GP
3 5 days 150 GP
4 10 days 1,000 GP
5 25 days 1,500 GP
6 40 days 10,000 GP
7 50 days 12,500 GP
8 60 days 15,000 GP
9 120 days 50,000 GP""",
                """## Spell Scroll Costs

| Spell Level | Time | Cost |
| :---: | --- | ---: |
| Cantrip | 1 day | 15 GP |
| 1 | 1 day | 25 GP |
| 2 | 3 days | 100 GP |
| 3 | 5 days | 150 GP |
| 4 | 10 days | 1,000 GP |
| 5 | 25 days | 1,500 GP |
| 6 | 40 days | 10,000 GP |
| 7 | 50 days | 12,500 GP |
| 8 | 60 days | 15,000 GP |
| 9 | 120 days | 50,000 GP |""",
            )
        ],
        "character-origins/character-species/dragonborn.md": [
            (
                """Draconic Ancestors
Dragon Damage Type Dragon Damage Type
Black Acid Gold Fire
Blue Lightning Green Poison
Brass Fire Red Fire
Bronze Lightning Silver Cold
Copper Acid White Cold""",
                """## Draconic Ancestors

| Dragon | Damage Type | Dragon | Damage Type |
| --- | --- | --- | --- |
| Black | Acid | Gold | Fire |
| Blue | Lightning | Green | Poison |
| Brass | Fire | Red | Fire |
| Bronze | Lightning | Silver | Cold |
| Copper | Acid | White | Cold |""",
            )
        ],
        "character-origins/character-species/tiefling.md": [
            (
                """Fiendish Legacies
Legacy Level 1 Level 3 Level 5
Abyssal You have Resistance to Poison damage.
You also know the Poison Spray cantrip.
Ray of Sickness Hold Person
Chthonic You have Resistance to Necrotic damage.
You also know the Chill Touch cantrip.
False Life Ray of Enfeeblement
Infernal You have Resistance to Fire damage.
You also know the Fire Bolt cantrip.
Hellish Rebuke Darkness""",
                """## Fiendish Legacies

| Legacy | Level 1 | Level 3 | Level 5 |
| --- | --- | --- | --- |
| Abyssal | You have Resistance to Poison damage. You also know the Poison Spray cantrip. | Ray of Sickness | Hold Person |
| Chthonic | You have Resistance to Necrotic damage. You also know the Chill Touch cantrip. | False Life | Ray of Enfeeblement |
| Infernal | You have Resistance to Fire damage. You also know the Fire Bolt cantrip. | Hellish Rebuke | Darkness |""",
            )
        ],
        "playing-the-game/the-six-abilities.md": [
            (
                """Ability Descriptions
Ability Score Measures …
Strength Physical might
Dexterity Agility, reflexes, and balance
Constitution Health and stamina
Intelligence Reasoning and memory
Wisdom Perceptiveness and mental fortitude
Charisma Confidence, poise, and charm""",
                """## Ability Descriptions

| Ability Score | Measures … |
| --- | --- |
| Strength | Physical might |
| Dexterity | Agility, reflexes, and balance |
| Constitution | Health and stamina |
| Intelligence | Reasoning and memory |
| Wisdom | Perceptiveness and mental fortitude |
| Charisma | Confidence, poise, and charm |""",
            ),
            (
                """Ability Scores
Score Meaning
1 This is the lowest a score can normally go.
If an effect reduces a score to 0, that effect
explains what happens.
2–9 This represents a weak capability.
10 –11 This represents the human average.
12–19 This represents a strong capability.
20 This is the highest an adventurer’s score can
go unless a feature says otherwise.
21–29 This represents an extraordinary capability.
30 This is the highest a score can go.""",
                """## Ability Scores

| Score | Meaning |
| --- | --- |
| 1 | This is the lowest a score can normally go. If an effect reduces a score to 0, that effect explains what happens. |
| 2–9 | This represents a weak capability. |
| 10–11 | This represents the human average. |
| 12–19 | This represents a strong capability. |
| 20 | This is the highest an adventurer’s score can go unless a feature says otherwise. |
| 21–29 | This represents an extraordinary capability. |
| 30 | This is the highest a score can go. |""",
            ),
            (
                """Ability Modifiers
Score Modifier
1 −5
2–3 −4
4–5 −3
6–7 −2
8–9 −1
10 –11 +0
12–13 +1
14–15 +2
Score Modifier
16 –17 +3
18–19 +4
20–21 +5
22–23 +6
24–25 +7
26–27 +8
28–29 +9
30 +10""",
                """## Ability Modifiers

| Score | Modifier |
| --- | ---: |
| 1 | −5 |
| 2–3 | −4 |
| 4–5 | −3 |
| 6–7 | −2 |
| 8–9 | −1 |
| 10–11 | +0 |
| 12–13 | +1 |
| 14–15 | +2 |
| 16–17 | +3 |
| 18–19 | +4 |
| 20–21 | +5 |
| 22–23 | +6 |
| 24–25 | +7 |
| 26–27 | +8 |
| 28–29 | +9 |
| 30 | +10 |""",
            ),
        ],
        "spells/casting-spells.md": [
            (
                """Schools of Magic
School Typical Effects
Abjuration Prevents or reverses harmful effects
Conjuration Transports creatures or objects
Divination Reveals information
Enchantment Influences minds
Evocation Channels energy to create effects that
are often destructive
Illusion Deceives the mind or senses
Necromancy Manipulates life and death
Transmutation Transforms creatures or objects""",
                """## Schools of Magic

| School | Typical Effects |
| --- | --- |
| Abjuration | Prevents or reverses harmful effects |
| Conjuration | Transports creatures or objects |
| Divination | Reveals information |
| Enchantment | Influences minds |
| Evocation | Channels energy to create effects that are often destructive |
| Illusion | Deceives the mind or senses |
| Necromancy | Manipulates life and death |
| Transmutation | Transforms creatures or objects |""",
            )
        ],
        "magic-items/magic-item-rarity.md": [
            (
                """Magic Item Rarities and Values
Rarity Value* Rarity Value*
Common 100 GP Very Rare 40,000 GP
Uncommon 400 GP Legendary 200,000 GP
Rare 4,000 GP Artifact Priceless
*Halve the value for a consumable item other than a Spell Scroll .
The value of a Spell Scroll  is double what it costs to scribe the scroll
(as specified in the “Scribing Spell Scrolls” section of “Equipment”).""",
                """## Magic Item Rarities and Values

| Rarity | Value* | Rarity | Value* |
| --- | ---: | --- | ---: |
| Common | 100 GP | Very Rare | 40,000 GP |
| Uncommon | 400 GP | Legendary | 200,000 GP |
| Rare | 4,000 GP | Artifact | Priceless |

*Halve the value for a consumable item other than a Spell Scroll. The value of a Spell Scroll is double what it costs to scribe the scroll (as specified in the “Scribing Spell Scrolls” section of “Equipment”).*""",
            )
        ],
        "magic-items/magic-item-categories.md": [
            (
                """Magic Item Categories
Category Examples
Armor +1 Leather Armor, +1 Shield
Potions Potion of Healing
Rings Ring of Invisibility
Rods Immovable Rod
Scrolls Spell Scroll
Staffs Staff of Striking
Wands Wand of Fireballs
Weapons +1 Ammunition, +1 Longsword
Wondrous Items Bag of Holding, Boots of Elvenkind""",
                """## Magic Item Categories

| Category | Examples |
| --- | --- |
| Armor | +1 Leather Armor, +1 Shield |
| Potions | Potion of Healing |
| Rings | Ring of Invisibility |
| Rods | Immovable Rod |
| Scrolls | Spell Scroll |
| Staffs | Staff of Striking |
| Wands | Wand of Fireballs |
| Weapons | +1 Ammunition, +1 Longsword |
| Wondrous Items | Bag of Holding, Boots of Elvenkind |""",
            ),
            (
                """Potion Miscibility
1d100 Result
01 Both potions lose their effects, and the
mixture creates a magical explosion in a
5-foot-radius Sphere centered on itself.
Each creature in that area takes 4d10 Force
damage.
02–08 Both potions lose their effects, and the mix -
ture becomes an ingested poison of your
choice (see “Poison” in “Gameplay Toolbox”).
09–15 Both potions lose their effects.
16–25 One potion loses its effect.
26–35 Both potions work, but with their numerical
effects and durations halved. If a potion has
no numerical effect and no duration, it instead
loses its effect.
36–90 Both potions work normally.
91–99 Both potions work, but the numerical effects
and duration of one potion are doubled. If nei -
ther potion has anything to double in this way,
they work normally.
00 Only one potion works, but its effects are
permanent. Choose the simplest effect to
make permanent or the one that seems the
most fun. For example, a Potion of Healing
might increase the drinker’s Hit Point maxi-
mum by 2d4 + 2, or a Potion of Invisibility  might
give the drinker the Invisible condition indefi -
nitely. At your discretion, a Dispel Magic  spell
or similar magic might end this lasting effect.""",
                """## Potion Miscibility

| 1d100 | Result |
| --- | --- |
| 01 | Both potions lose their effects, and the mixture creates a magical explosion in a 5-foot-radius Sphere centered on itself. Each creature in that area takes 4d10 Force damage. |
| 02–08 | Both potions lose their effects, and the mixture becomes an ingested poison of your choice (see “Poison” in “Gameplay Toolbox”). |
| 09–15 | Both potions lose their effects. |
| 16–25 | One potion loses its effect. |
| 26–35 | Both potions work, but with their numerical effects and durations halved. If a potion has no numerical effect and no duration, it instead loses its effect. |
| 36–90 | Both potions work normally. |
| 91–99 | Both potions work, but the numerical effects and duration of one potion are doubled. If neither potion has anything to double in this way, they work normally. |
| 00 | Only one potion works, but its effects are permanent. Choose the simplest effect to make permanent or the one that seems the most fun. For example, a Potion of Healing might increase the drinker’s Hit Point maximum by 2d4 + 2, or a Potion of Invisibility might give the drinker the Invisible condition indefinitely. At your discretion, a Dispel Magic spell or similar magic might end this lasting effect. |""",
            ),
        ],
        "magic-items/sentient-magic-items.md": [
            (
                """Sentient Item’s Alignment
1d100 Alignment 1d100 Alignment
01–15 Lawful Good 74–85 Chaotic Neutral
16–35 Neutral Good 86–89 Lawful Evil
36–50 Chaotic Good 90–96 Neutral Evil
51–63 Lawful Neutral 97–00 Chaotic Evil
64–73 Neutral""",
                """## Sentient Item’s Alignment

| 1d100 | Alignment | 1d100 | Alignment |
| --- | --- | --- | --- |
| 01–15 | Lawful Good | 74–85 | Chaotic Neutral |
| 16–35 | Neutral Good | 86–89 | Lawful Evil |
| 36–50 | Chaotic Good | 90–96 | Neutral Evil |
| 51–63 | Lawful Neutral | 97–00 | Chaotic Evil |
| 64–73 | Neutral |  |  |""",
            ),
            (
                """Sentient Item’s Communication
1d10 Communication
1–6 The item communicates by transmitting emo -
tion to the creature carrying or wielding it.
7–9 The item speaks one or more languages.
10 The item speaks one or more languages. In ad -
dition, the item can communicate telepathically
with any creature that carries or wields it.""",
                """## Sentient Item’s Communication

| 1d10 | Communication |
| --- | --- |
| 1–6 | The item communicates by transmitting emotion to the creature carrying or wielding it. |
| 7–9 | The item speaks one or more languages. |
| 10 | The item speaks one or more languages. In addition, the item can communicate telepathically with any creature that carries or wields it. |""",
            ),
            (
                """Sentient Item’s Senses
1d4 Senses
1 Hearing and standard vision out to 30 feet
2 Hearing and standard vision out to 60 feet
3 Hearing and standard vision out to 120 feet
4 Hearing and Darkvision out to 120 feet""",
                """## Sentient Item’s Senses

| 1d4 | Senses |
| --- | --- |
| 1 | Hearing and standard vision out to 30 feet |
| 2 | Hearing and standard vision out to 60 feet |
| 3 | Hearing and standard vision out to 120 feet |
| 4 | Hearing and Darkvision out to 120 feet |""",
            ),
            (
                """Sentient Item’s Special Purpose
1d10 Special Purpose
1 Aligned. The item seeks to defeat or destroy
those of a diametrically opposed alignment.
Such an item is never Neutral.
2 Bane. The item seeks to thwart or destroy
creatures of a particular type, such as Con -
structs, Fiends, or Undead.
3 Creator Seeker. The item seeks its creator
and wants to understand why it was created.
4 Destiny Seeker. The item believes it and its
bearer have key roles to play in future events.
1d10 Special Purpose
5 Destroyer. The item craves destruction and
goads its user to fight arbitrarily.
6 Glory Seeker. The item seeks renown as the
greatest magic item in the world by winning
fame or notoriety for its user.
7 Lore Seeker. The item craves knowledge or is
determined to solve a mystery, learn a secret,
or unravel a cryptic prophecy.
8 Protector. The item seeks to defend a par -
ticular kind of creature, such as elves or
werewolves.
9 Soulmate Seeker. The item seeks another
sentient magic item, perhaps one that is similar
to itself.
10 Templar. The item seeks to defend the ser -
vants and interests of a particular deity.""",
                """## Sentient Item’s Special Purpose

| 1d10 | Special Purpose |
| --- | --- |
| 1 | Aligned. The item seeks to defeat or destroy those of a diametrically opposed alignment. Such an item is never Neutral. |
| 2 | Bane. The item seeks to thwart or destroy creatures of a particular type, such as Constructs, Fiends, or Undead. |
| 3 | Creator Seeker. The item seeks its creator and wants to understand why it was created. |
| 4 | Destiny Seeker. The item believes it and its bearer have key roles to play in future events. |
| 5 | Destroyer. The item craves destruction and goads its user to fight arbitrarily. |
| 6 | Glory Seeker. The item seeks renown as the greatest magic item in the world by winning fame or notoriety for its user. |
| 7 | Lore Seeker. The item craves knowledge or is determined to solve a mystery, learn a secret, or unravel a cryptic prophecy. |
| 8 | Protector. The item seeks to defend a particular kind of creature, such as elves or werewolves. |
| 9 | Soulmate Seeker. The item seeks another sentient magic item, perhaps one that is similar to itself. |
| 10 | Templar. The item seeks to defend the servants and interests of a particular deity. |""",
            ),
        ],
        "monsters/running-a-monster.md": [
            (
                """Hit Dice by Size
Monster Size Hit Die Average HP per Die
Tiny d4 2½
Small d6 3½
Medium d8 4½
Large d10 5½
Huge d12 6½
Gargantuan d20 10½""",
                """## Hit Dice by Size

| Monster Size | Hit Die | Average HP per Die |
| --- | :---: | ---: |
| Tiny | d4 | 2½ |
| Small | d6 | 3½ |
| Medium | d8 | 4½ |
| Large | d10 | 5½ |
| Huge | d12 | 6½ |
| Gargantuan | d20 | 10½ |""",
            ),
            (
                """Experience Points by Challenge Rating
CR XP CR XP
0 0 or 10 14 11, 50 0
1/8 25 15 13,000
1/4 50 16 15,000
1/2 100 17 18,000
1 200 18 20,000
2 450 19 22,000
3 700 20 25,000
4 1,100 21 33,000
5 1,800 22 41,000
6 2,300 23 50,000
7 2,900 24 62,000
8 3,900 25 75,000
9 5,000 26 90,000
10 5,900 27 105,000
CR XP CR XP
11 7,200 28 120,000
12 8,400 29 135,000
13 10,000 30 155,000""",
                """## Experience Points by Challenge Rating

| CR | XP | CR | XP |
| --- | ---: | --- | ---: |
| 0 | 0 or 10 | 14 | 11,500 |
| 1/8 | 25 | 15 | 13,000 |
| 1/4 | 50 | 16 | 15,000 |
| 1/2 | 100 | 17 | 18,000 |
| 1 | 200 | 18 | 20,000 |
| 2 | 450 | 19 | 22,000 |
| 3 | 700 | 20 | 25,000 |
| 4 | 1,100 | 21 | 33,000 |
| 5 | 1,800 | 22 | 41,000 |
| 6 | 2,300 | 23 | 50,000 |
| 7 | 2,900 | 24 | 62,000 |
| 8 | 3,900 | 25 | 75,000 |
| 9 | 5,000 | 26 | 90,000 |
| 10 | 5,900 | 27 | 105,000 |
| 11 | 7,200 | 28 | 120,000 |
| 12 | 8,400 | 29 | 135,000 |
| 13 | 10,000 | 30 | 155,000 |""",
            ),
            (
                """Proficiency Bonus by Challenge Rating
CR PB CR PB
0–4 +2 17–20 +6
5–8 +3 21–24 +7
9–12 +4 25–28 +8
13–16 +5 29–30 +9""",
                """## Proficiency Bonus by Challenge Rating

| CR | PB | CR | PB |
| --- | :---: | --- | :---: |
| 0–4 | +2 | 17–20 | +6 |
| 5–8 | +3 | 21–24 | +7 |
| 9–12 | +4 | 25–28 | +8 |
| 13–16 | +5 | 29–30 | +9 |""",
            ),
        ],
        "rules-glossary.md": [
            (
                """AC Armor Class
C Concentration
CE Chaotic Evil
CG Chaotic Good
Cha. Charisma
CN Chaotic Neutral
Con. Constitution
CP Copper Piece(s)
CR Challenge Rating
DC Difficulty Class
Dex. Dexterity
EP Electrum Piece(s)
GM Game Master
GP Gold Piece(s)
HP Hit Point(s)
Int. Intelligence
LE Lawful Evil
LG Lawful Good
LN Lawful Neutral
M Material
component
N Neutral
NE Neutral Evil
NG Neutral Good
NPC Nonplayer
character
PB Proficiency Bonus
PP Platinum Piece(s)
R Ritual
S Somatic
component
SP Silver Piece(s)
Str. Strength
V Verbal
component
Wis. Wisdom
XP Experience
Point(s)""",
                """## Abbreviations

| Abbreviation | Meaning |
| --- | --- |
| AC | Armor Class |
| C | Concentration |
| CE | Chaotic Evil |
| CG | Chaotic Good |
| Cha. | Charisma |
| CN | Chaotic Neutral |
| Con. | Constitution |
| CP | Copper Piece(s) |
| CR | Challenge Rating |
| DC | Difficulty Class |
| Dex. | Dexterity |
| EP | Electrum Piece(s) |
| GM | Game Master |
| GP | Gold Piece(s) |
| HP | Hit Point(s) |
| Int. | Intelligence |
| LE | Lawful Evil |
| LG | Lawful Good |
| LN | Lawful Neutral |
| M | Material component |
| N | Neutral |
| NE | Neutral Evil |
| NG | Neutral Good |
| NPC | Nonplayer character |
| PB | Proficiency Bonus |
| PP | Platinum Piece(s) |
| R | Ritual |
| S | Somatic component |
| SP | Silver Piece(s) |
| Str. | Strength |
| V | Verbal component |
| Wis. | Wisdom |
| XP | Experience Point(s) |""",
            )
        ],
        "equipment/armor.md": [
            (
                """Armor
Armor Armor Class (AC) Strength Stealth Weight Cost
Light Armor (1 Minute to Don or Doff)
Padded Armor 11 + Dex modifier — Disadvantage 8 lb. 5 GP
Leather Armor 11 + Dex modifier — — 10 lb. 10 GP
Studded Leather Armor 12 + Dex modifier — — 13 lb. 45 GP
Medium Armor (5 Minutes to Don and 1 Minute to Doff)
Hide Armor 12 + Dex modifier (max 2) — — 12 lb. 10 GP
Chain Shirt 13 + Dex modifier (max 2) — — 20 lb. 50 GP
Scale Mail 14 + Dex modifier (max 2) — Disadvantage 45 lb. 50 GP
Breastplate 14 + Dex modifier (max 2) — — 20 lb. 400 GP
Half Plate Armor 15 + Dex modifier (max 2) — Disadvantage 40 lb. 750 GP
Heavy Armor (10 Minutes to Don and 5 Minutes to Doff)
Ring Mail 14 — Disadvantage 40 lb. 30 GP
Chain Mail 16 Str 13 Disadvantage 55 lb. 75 GP
Splint Armor 17 Str 15 Disadvantage 60 lb. 200 GP
Plate Armor 18 Str 15 Disadvantage 65 lb. 1,500 GP
Shield (Utilize Action to Don or Doff)
Shield +2 — — 6 lb. 10 GP""",
                """## Armor

| Armor | Armor Class (AC) | Strength | Stealth | Weight | Cost |
| --- | --- | --- | --- | ---: | ---: |
| **Light Armor (1 Minute to Don or Doff)** |  |  |  |  |  |
| Padded Armor | 11 + Dex modifier | — | Disadvantage | 8 lb. | 5 GP |
| Leather Armor | 11 + Dex modifier | — | — | 10 lb. | 10 GP |
| Studded Leather Armor | 12 + Dex modifier | — | — | 13 lb. | 45 GP |
| **Medium Armor (5 Minutes to Don and 1 Minute to Doff)** |  |  |  |  |  |
| Hide Armor | 12 + Dex modifier (max 2) | — | — | 12 lb. | 10 GP |
| Chain Shirt | 13 + Dex modifier (max 2) | — | — | 20 lb. | 50 GP |
| Scale Mail | 14 + Dex modifier (max 2) | — | Disadvantage | 45 lb. | 50 GP |
| Breastplate | 14 + Dex modifier (max 2) | — | — | 20 lb. | 400 GP |
| Half Plate Armor | 15 + Dex modifier (max 2) | — | Disadvantage | 40 lb. | 750 GP |
| **Heavy Armor (10 Minutes to Don and 5 Minutes to Doff)** |  |  |  |  |  |
| Ring Mail | 14 | — | Disadvantage | 40 lb. | 30 GP |
| Chain Mail | 16 | Str 13 | Disadvantage | 55 lb. | 75 GP |
| Splint Armor | 17 | Str 15 | Disadvantage | 60 lb. | 200 GP |
| Plate Armor | 18 | Str 15 | Disadvantage | 65 lb. | 1,500 GP |
| **Shield (Utilize Action to Don or Doff)** |  |  |  |  |  |
| Shield | +2 | — | — | 6 lb. | 10 GP |""",
            )
        ],
    }

    rel = path.relative_to(ROOT).as_posix()
    for old, new in replacements.get(rel, []):
        text = replace_block(text, old, new)
    return text


def is_heading_like(line: str) -> bool:
    stripped = line.strip()
    if not stripped:
        return False
    if stripped.startswith(("#", "-", "|", "•")):
        return False
    if re.match(r"^\d+:", stripped):
        return False
    if stripped.endswith(":"):
        return False
    if len(stripped) > 90:
        return False
    if any(ch in stripped for ch in ".!?"):
        return False
    if not stripped[0].isupper():
        return False
    words = stripped.split()
    if len(words) > 8:
        return False
    capitalized = sum(1 for word in words if word[:1].isupper() or word[:1].isdigit())
    if capitalized < max(1, len(words) - 1):
        return False
    return True


def is_structural(line: str) -> bool:
    stripped = line.strip()
    return (
        not stripped
        or stripped.startswith(("#", "-", "|", "•"))
        or re.match(r"^\d+:", stripped) is not None
        or stripped.startswith("## Referencias")
    )


def normalize_text(text: str) -> str:
    text = text.replace("\r\n", "\n").replace("\r", "\n")
    text = re.sub(r"([A-Za-z])\s*-\n([A-Za-z])", r"\1\2", text)
    text = re.sub(r"[ \t]+\n", "\n", text)
    while True:
        updated = re.sub(r"([^\n.!?:|#-])\n\n([a-z(“\"'])", r"\1 \2", text)
        if updated == text:
            break
        text = updated
    lines = text.split("\n")

    out: list[str] = []
    i = 0
    while i < len(lines):
        line = lines[i].strip()
        if not line:
            prev_nonblank = ""
            next_nonblank = ""
            for j in range(i - 1, -1, -1):
                if lines[j].strip():
                    prev_nonblank = lines[j].strip()
                    break
            for j in range(i + 1, len(lines)):
                if lines[j].strip():
                    next_nonblank = lines[j].strip()
                    break
            if (
                prev_nonblank
                and next_nonblank
                and not is_structural(prev_nonblank)
                and not is_structural(next_nonblank)
                and not is_heading_like(prev_nonblank)
                and not is_heading_like(next_nonblank)
                and not prev_nonblank.endswith((".", "!", "?", ":", ";"))
            ):
                i += 1
                continue
            if out and out[-1] != "":
                out.append("")
            i += 1
            continue

        if line.startswith("|") or line.startswith("#") or line.startswith("- ") or line.startswith("•"):
            out.append(line)
            i += 1
            continue

        if re.match(r"^\d+:", line):
            parts = [line]
            i += 1
            while i < len(lines):
                nxt = lines[i].strip()
                if not nxt or is_structural(nxt) or is_heading_like(nxt):
                    break
                parts.append(nxt)
                i += 1
            out.append(" ".join(parts))
            out.append("")
            continue

        if is_heading_like(line):
            if out and out[-1] != "":
                out.append("")
            out.append(line)
            out.append("")
            i += 1
            continue

        parts = [line]
        i += 1
        while i < len(lines):
            nxt = lines[i].strip()
            if not nxt or is_structural(nxt) or is_heading_like(nxt):
                break
            parts.append(nxt)
            i += 1
        paragraph = " ".join(parts)
        paragraph = re.sub(r"\s{2,}", " ", paragraph)
        out.append(paragraph)
        out.append("")

    result = "\n".join(out)
    result = re.sub(r"\n{3,}", "\n\n", result).strip() + "\n"
    return result


def main() -> None:
    changed = 0
    for path in sorted(ROOT.rglob("*.md")):
        original = path.read_text(encoding="utf-8")
        updated = apply_known_table_replacements(path, original)
        updated = normalize_text(updated)
        if updated != original:
            path.write_text(updated, encoding="utf-8")
            changed += 1
    print(f"Updated {changed} files")


if __name__ == "__main__":
    main()
