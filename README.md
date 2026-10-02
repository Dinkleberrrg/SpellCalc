# SpellCalc - Turtle WoW Addon

Spell damage/healing calculator for all caster classes in Turtle WoW (1.12 client).
Shows every rank of every spell with cooldown-aware efficiency metrics.

## Features

- **All ranks** of every damage and healing spell for your class
- **Average damage/healing per cast** (with SP/HP factored in)
- **Per Mana efficiency** (DPM / HPM)
- **Per Second output** (DPS / HPS) — **cooldowns are factored in**
  - Fire Blast with 8s CD shows true DPS = damage/8, not damage/1.5
  - Instants on cooldown use CD as effective cycle time
- **Automatic talent scanning** — known damage/heal modifiers applied
- **Spell Power & Healing Power** auto-detected from character stats
- **Sortable** by any column (click header)
- **Filterable**: All / Damage / Healing
- **Detailed tooltip** on hover with breakdown
- **Cooldown column** showing CD for each spell

## Supported Classes

Mage, Priest, Warlock, Druid, Shaman, Paladin — all caster spells, all ranks.

## Installation

1. Copy the `SpellCalc` folder to: `<WoW>/Interface/AddOns/SpellCalc/`
2. Restart WoW or `/reload`

## Commands

| Command       | Description                        |
|---------------|------------------------------------|
| `/sc`         | Toggle window                      |
| `/spellcalc`  | Toggle window (long form)          |
| `/sc sp 300`  | Manually set Spell Power to 300    |
| `/sc hp 400`  | Manually set Healing Power to 400  |
| `/sc reset`   | Clear manual overrides (auto mode) |
| `/sc help`    | Show help in chat                  |

## How /Sec is calculated

The per-second value uses the **longest** of cast time, GCD (1.5s), or cooldown:

- `Frostbolt R11` (3.0s cast, no CD) → DPS = damage / 3.0
- `Fire Blast R7` (instant, 8s CD) → DPS = damage / 8.0
- `Mind Blast R9` (1.5s cast, 8s CD) → DPS = damage / 8.0
- `Cone of Cold R5` (instant, 10s CD) → DPS = damage / 10.0
- `Shadow Bolt R10` (3.0s cast, no CD) → DPS = damage / 3.0
- DoTs: total damage / max(duration, cooldown)

## Columns

- **Spell**: Name and rank (green = heal, white = damage, [AoE] = area, * = DoT/HoT)
- **School**: Magic school with color coding
- **Avg Value**: Average total damage or healing per cast
- **/Mana**: Value per mana spent (efficiency)
- **/Sec**: Value per second (uses effective cycle time including cooldown)
- **Mana**: Mana cost
- **CD**: Cooldown duration (- = none)

## Extending

Edit `SpellData.lua` to add spells. Each entry follows this format:

```lua
S{name="Spell", rank=1, school=5, spellType="damage",
  minDmg=100, maxDmg=150, manaCost=200, castTime=2.5,
  spCoeff=0.714, cd=0, level=30},
```

Schools: 2=Holy, 3=Fire, 4=Nature, 5=Frost, 6=Shadow, 7=Arcane
Types: "damage", "heal", "dot", "hot", "dd+dot", "dd+hot", "ch_dmg", "ch_heal"
