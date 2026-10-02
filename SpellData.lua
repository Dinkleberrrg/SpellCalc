-- SpellCalc Spell & Talent Database
-- Schools: 2=Holy, 3=Fire, 4=Nature, 5=Frost, 6=Shadow, 7=Arcane
-- spellType: "damage", "heal", "dot", "hot", "dd+dot", "dd+hot", "ch_dmg", "ch_heal"
-- cd = cooldown in seconds (0 = no cooldown)
-- level = level the spell rank is learned (for sub-20 coefficient penalty)

SPELLCALC_SCHOOLS = {
    [2] = { name = "Holy",   color = {1.0, 0.9, 0.0} },
    [3] = { name = "Fire",   color = {1.0, 0.3, 0.0} },
    [4] = { name = "Nature", color = {0.2, 0.9, 0.2} },
    [5] = { name = "Frost",  color = {0.2, 0.7, 1.0} },
    [6] = { name = "Shadow", color = {0.6, 0.2, 0.9} },
    [7] = { name = "Arcane", color = {1.0, 0.4, 1.0} },
}
SPELLCALC_SCHOOL_HEAL = { name = "Heal", color = {0.2, 1.0, 0.4} }

-- Helper: S(name,rank,school,type,minD,maxD,mana,cast,coeff,cd,level, [dotTotal,dotDur,dotCoeff,isAoE])
local function S(t) return t end

SPELLCALC_SPELLS = {}

-- ============================================================================
-- MAGE
-- ============================================================================
SPELLCALC_SPELLS["MAGE"] = {
    -- FROSTBOLT  (no cooldown)
    S{name="Frostbolt",rank=1,school=5,spellType="damage",minDmg=18,maxDmg=20,manaCost=25,castTime=1.5,spCoeff=0.429,cd=0,level=4},
    S{name="Frostbolt",rank=2,school=5,spellType="damage",minDmg=31,maxDmg=35,manaCost=35,castTime=1.8,spCoeff=0.463,cd=0,level=8},
    S{name="Frostbolt",rank=3,school=5,spellType="damage",minDmg=51,maxDmg=57,manaCost=50,castTime=2.2,spCoeff=0.560,cd=0,level=14},
    S{name="Frostbolt",rank=4,school=5,spellType="damage",minDmg=74,maxDmg=82,manaCost=65,castTime=2.6,spCoeff=0.667,cd=0,level=20},
    S{name="Frostbolt",rank=5,school=5,spellType="damage",minDmg=126,maxDmg=137,manaCost=100,castTime=3.0,spCoeff=0.814,cd=0,level=26},
    S{name="Frostbolt",rank=6,school=5,spellType="damage",minDmg=174,maxDmg=189,manaCost=130,castTime=3.0,spCoeff=0.814,cd=0,level=32},
    S{name="Frostbolt",rank=7,school=5,spellType="damage",minDmg=227,maxDmg=246,manaCost=160,castTime=3.0,spCoeff=0.814,cd=0,level=38},
    S{name="Frostbolt",rank=8,school=5,spellType="damage",minDmg=292,maxDmg=316,manaCost=195,castTime=3.0,spCoeff=0.814,cd=0,level=44},
    S{name="Frostbolt",rank=9,school=5,spellType="damage",minDmg=356,maxDmg=383,manaCost=225,castTime=3.0,spCoeff=0.814,cd=0,level=50},
    S{name="Frostbolt",rank=10,school=5,spellType="damage",minDmg=429,maxDmg=463,manaCost=260,castTime=3.0,spCoeff=0.814,cd=0,level=56},
    S{name="Frostbolt",rank=11,school=5,spellType="damage",minDmg=515,maxDmg=555,manaCost=290,castTime=3.0,spCoeff=0.814,cd=0,level=60},

    -- FIREBALL (no cooldown, has DoT component)
    S{name="Fireball",rank=1,school=3,spellType="dd+dot",minDmg=14,maxDmg=22,manaCost=30,castTime=1.5,spCoeff=0.271,cd=0,level=1,dotTotal=2,dotDuration=4,dotCoeff=0.0},
    S{name="Fireball",rank=2,school=3,spellType="dd+dot",minDmg=32,maxDmg=43,manaCost=45,castTime=2.0,spCoeff=0.371,cd=0,level=6,dotTotal=3,dotDuration=6,dotCoeff=0.0},
    S{name="Fireball",rank=3,school=3,spellType="dd+dot",minDmg=53,maxDmg=68,manaCost=65,castTime=2.5,spCoeff=0.500,cd=0,level=12,dotTotal=6,dotDuration=6,dotCoeff=0.0},
    S{name="Fireball",rank=4,school=3,spellType="dd+dot",minDmg=84,maxDmg=105,manaCost=95,castTime=3.0,spCoeff=0.629,cd=0,level=18,dotTotal=12,dotDuration=8,dotCoeff=0.0},
    S{name="Fireball",rank=5,school=3,spellType="dd+dot",minDmg=127,maxDmg=156,manaCost=140,castTime=3.5,spCoeff=0.771,cd=0,level=24,dotTotal=20,dotDuration=8,dotCoeff=0.0},
    S{name="Fireball",rank=6,school=3,spellType="dd+dot",minDmg=176,maxDmg=213,manaCost=185,castTime=3.5,spCoeff=1.0,cd=0,level=30,dotTotal=28,dotDuration=8,dotCoeff=0.0},
    S{name="Fireball",rank=7,school=3,spellType="dd+dot",minDmg=233,maxDmg=278,manaCost=220,castTime=3.5,spCoeff=1.0,cd=0,level=36,dotTotal=36,dotDuration=8,dotCoeff=0.0},
    S{name="Fireball",rank=8,school=3,spellType="dd+dot",minDmg=295,maxDmg=350,manaCost=260,castTime=3.5,spCoeff=1.0,cd=0,level=42,dotTotal=44,dotDuration=8,dotCoeff=0.0},
    S{name="Fireball",rank=9,school=3,spellType="dd+dot",minDmg=365,maxDmg=431,manaCost=305,castTime=3.5,spCoeff=1.0,cd=0,level=48,dotTotal=52,dotDuration=8,dotCoeff=0.0},
    S{name="Fireball",rank=10,school=3,spellType="dd+dot",minDmg=440,maxDmg=516,manaCost=350,castTime=3.5,spCoeff=1.0,cd=0,level=54,dotTotal=60,dotDuration=8,dotCoeff=0.0},
    S{name="Fireball",rank=11,school=3,spellType="dd+dot",minDmg=510,maxDmg=600,manaCost=380,castTime=3.5,spCoeff=1.0,cd=0,level=58,dotTotal=72,dotDuration=8,dotCoeff=0.0},
    S{name="Fireball",rank=12,school=3,spellType="dd+dot",minDmg=596,maxDmg=760,manaCost=410,castTime=3.5,spCoeff=1.0,cd=0,level=60,dotTotal=84,dotDuration=8,dotCoeff=0.0},

    -- FIRE BLAST (8s cooldown)
    S{name="Fire Blast",rank=1,school=3,spellType="damage",minDmg=24,maxDmg=30,manaCost=40,castTime=0,spCoeff=0.429,cd=8,level=6},
    S{name="Fire Blast",rank=2,school=3,spellType="damage",minDmg=53,maxDmg=63,manaCost=75,castTime=0,spCoeff=0.429,cd=8,level=14},
    S{name="Fire Blast",rank=3,school=3,spellType="damage",minDmg=106,maxDmg=124,manaCost=115,castTime=0,spCoeff=0.429,cd=8,level=22},
    S{name="Fire Blast",rank=4,school=3,spellType="damage",minDmg=168,maxDmg=196,manaCost=165,castTime=0,spCoeff=0.429,cd=8,level=30},
    S{name="Fire Blast",rank=5,school=3,spellType="damage",minDmg=231,maxDmg=269,manaCost=220,castTime=0,spCoeff=0.429,cd=8,level=38},
    S{name="Fire Blast",rank=6,school=3,spellType="damage",minDmg=305,maxDmg=355,manaCost=280,castTime=0,spCoeff=0.429,cd=8,level=46},
    S{name="Fire Blast",rank=7,school=3,spellType="damage",minDmg=431,maxDmg=509,manaCost=340,castTime=0,spCoeff=0.429,cd=8,level=54},

    -- SCORCH (no cooldown)
    S{name="Scorch",rank=1,school=3,spellType="damage",minDmg=53,maxDmg=63,manaCost=50,castTime=1.5,spCoeff=0.429,cd=0,level=22},
    S{name="Scorch",rank=2,school=3,spellType="damage",minDmg=77,maxDmg=91,manaCost=65,castTime=1.5,spCoeff=0.429,cd=0,level=28},
    S{name="Scorch",rank=3,school=3,spellType="damage",minDmg=100,maxDmg=118,manaCost=80,castTime=1.5,spCoeff=0.429,cd=0,level=34},
    S{name="Scorch",rank=4,school=3,spellType="damage",minDmg=133,maxDmg=155,manaCost=100,castTime=1.5,spCoeff=0.429,cd=0,level=40},
    S{name="Scorch",rank=5,school=3,spellType="damage",minDmg=162,maxDmg=190,manaCost=115,castTime=1.5,spCoeff=0.429,cd=0,level=46},
    S{name="Scorch",rank=6,school=3,spellType="damage",minDmg=200,maxDmg=234,manaCost=135,castTime=1.5,spCoeff=0.429,cd=0,level=52},
    S{name="Scorch",rank=7,school=3,spellType="damage",minDmg=233,maxDmg=275,manaCost=150,castTime=1.5,spCoeff=0.429,cd=0,level=58},

    -- PYROBLAST (no cooldown, has DoT)
    S{name="Pyroblast",rank=1,school=3,spellType="dd+dot",minDmg=141,maxDmg=188,manaCost=125,castTime=6.0,spCoeff=1.0,cd=0,level=20,dotTotal=56,dotDuration=12,dotCoeff=0.15},
    S{name="Pyroblast",rank=2,school=3,spellType="dd+dot",minDmg=184,maxDmg=241,manaCost=160,castTime=6.0,spCoeff=1.0,cd=0,level=24,dotTotal=68,dotDuration=12,dotCoeff=0.15},
    S{name="Pyroblast",rank=3,school=3,spellType="dd+dot",minDmg=250,maxDmg=323,manaCost=210,castTime=6.0,spCoeff=1.0,cd=0,level=30,dotTotal=96,dotDuration=12,dotCoeff=0.15},
    S{name="Pyroblast",rank=4,school=3,spellType="dd+dot",minDmg=320,maxDmg=412,manaCost=260,castTime=6.0,spCoeff=1.0,cd=0,level=36,dotTotal=124,dotDuration=12,dotCoeff=0.15},
    S{name="Pyroblast",rank=5,school=3,spellType="dd+dot",minDmg=396,maxDmg=506,manaCost=315,castTime=6.0,spCoeff=1.0,cd=0,level=42,dotTotal=156,dotDuration=12,dotCoeff=0.15},
    S{name="Pyroblast",rank=6,school=3,spellType="dd+dot",minDmg=480,maxDmg=611,manaCost=370,castTime=6.0,spCoeff=1.0,cd=0,level=48,dotTotal=188,dotDuration=12,dotCoeff=0.15},
    S{name="Pyroblast",rank=7,school=3,spellType="dd+dot",minDmg=569,maxDmg=722,manaCost=430,castTime=6.0,spCoeff=1.0,cd=0,level=54,dotTotal=228,dotDuration=12,dotCoeff=0.15},
    S{name="Pyroblast",rank=8,school=3,spellType="dd+dot",minDmg=716,maxDmg=890,manaCost=500,castTime=6.0,spCoeff=1.0,cd=0,level=60,dotTotal=268,dotDuration=12,dotCoeff=0.15},

    -- FLAMESTRIKE (AoE, no cooldown, has DoT)
    S{name="Flamestrike",rank=1,school=3,spellType="dd+dot",minDmg=51,maxDmg=65,manaCost=140,castTime=3.0,spCoeff=0.329,cd=0,level=16,dotTotal=48,dotDuration=8,dotCoeff=0.039,isAoE=true},
    S{name="Flamestrike",rank=2,school=3,spellType="dd+dot",minDmg=93,maxDmg=117,manaCost=225,castTime=3.0,spCoeff=0.329,cd=0,level=24,dotTotal=88,dotDuration=8,dotCoeff=0.039,isAoE=true},
    S{name="Flamestrike",rank=3,school=3,spellType="dd+dot",minDmg=148,maxDmg=186,manaCost=330,castTime=3.0,spCoeff=0.329,cd=0,level=32,dotTotal=136,dotDuration=8,dotCoeff=0.039,isAoE=true},
    S{name="Flamestrike",rank=4,school=3,spellType="dd+dot",minDmg=211,maxDmg=265,manaCost=450,castTime=3.0,spCoeff=0.329,cd=0,level=40,dotTotal=196,dotDuration=8,dotCoeff=0.039,isAoE=true},
    S{name="Flamestrike",rank=5,school=3,spellType="dd+dot",minDmg=294,maxDmg=366,manaCost=590,castTime=3.0,spCoeff=0.329,cd=0,level=48,dotTotal=268,dotDuration=8,dotCoeff=0.039,isAoE=true},
    S{name="Flamestrike",rank=6,school=3,spellType="dd+dot",minDmg=380,maxDmg=472,manaCost=795,castTime=3.0,spCoeff=0.329,cd=0,level=56,dotTotal=356,dotDuration=8,dotCoeff=0.039,isAoE=true},

    -- CONE OF COLD (AoE, 10s cooldown)
    S{name="Cone of Cold",rank=1,school=5,spellType="damage",minDmg=98,maxDmg=109,manaCost=110,castTime=0,spCoeff=0.129,cd=10,level=26,isAoE=true},
    S{name="Cone of Cold",rank=2,school=5,spellType="damage",minDmg=146,maxDmg=161,manaCost=160,castTime=0,spCoeff=0.129,cd=10,level=34,isAoE=true},
    S{name="Cone of Cold",rank=3,school=5,spellType="damage",minDmg=203,maxDmg=223,manaCost=210,castTime=0,spCoeff=0.129,cd=10,level=42,isAoE=true},
    S{name="Cone of Cold",rank=4,school=5,spellType="damage",minDmg=264,maxDmg=290,manaCost=270,castTime=0,spCoeff=0.129,cd=10,level=50,isAoE=true},
    S{name="Cone of Cold",rank=5,school=5,spellType="damage",minDmg=335,maxDmg=365,manaCost=320,castTime=0,spCoeff=0.129,cd=10,level=58,isAoE=true},

    -- FROST NOVA (AoE, 25s cooldown)
    S{name="Frost Nova",rank=1,school=5,spellType="damage",minDmg=19,maxDmg=22,manaCost=55,castTime=0,spCoeff=0.032,cd=25,level=10,isAoE=true},
    S{name="Frost Nova",rank=2,school=5,spellType="damage",minDmg=33,maxDmg=38,manaCost=85,castTime=0,spCoeff=0.032,cd=25,level=26,isAoE=true},
    S{name="Frost Nova",rank=3,school=5,spellType="damage",minDmg=53,maxDmg=59,manaCost=115,castTime=0,spCoeff=0.032,cd=25,level=40,isAoE=true},
    S{name="Frost Nova",rank=4,school=5,spellType="damage",minDmg=71,maxDmg=79,manaCost=145,castTime=0,spCoeff=0.032,cd=25,level=54,isAoE=true},

    -- ARCANE MISSILES (channeled, no cooldown)
    S{name="Arcane Missiles",rank=1,school=7,spellType="ch_dmg",minDmg=72,maxDmg=72,manaCost=85,castTime=3.0,spCoeff=0.500,cd=0,level=8},
    S{name="Arcane Missiles",rank=2,school=7,spellType="ch_dmg",minDmg=140,maxDmg=140,manaCost=140,castTime=4.0,spCoeff=0.667,cd=0,level=16},
    S{name="Arcane Missiles",rank=3,school=7,spellType="ch_dmg",minDmg=210,maxDmg=210,manaCost=235,castTime=5.0,spCoeff=0.833,cd=0,level=24},
    S{name="Arcane Missiles",rank=4,school=7,spellType="ch_dmg",minDmg=280,maxDmg=280,manaCost=320,castTime=5.0,spCoeff=1.0,cd=0,level=32},
    S{name="Arcane Missiles",rank=5,school=7,spellType="ch_dmg",minDmg=360,maxDmg=360,manaCost=410,castTime=5.0,spCoeff=1.0,cd=0,level=40},
    S{name="Arcane Missiles",rank=6,school=7,spellType="ch_dmg",minDmg=445,maxDmg=445,manaCost=500,castTime=5.0,spCoeff=1.0,cd=0,level=48},
    S{name="Arcane Missiles",rank=7,school=7,spellType="ch_dmg",minDmg=540,maxDmg=540,manaCost=595,castTime=5.0,spCoeff=1.0,cd=0,level=56},
    S{name="Arcane Missiles",rank=8,school=7,spellType="ch_dmg",minDmg=653,maxDmg=653,manaCost=655,castTime=5.0,spCoeff=1.0,cd=0,level=60},

    -- ARCANE EXPLOSION (AoE, no cooldown, instant)
    S{name="Arcane Explosion",rank=1,school=7,spellType="damage",minDmg=34,maxDmg=37,manaCost=75,castTime=0,spCoeff=0.143,cd=0,level=14,isAoE=true},
    S{name="Arcane Explosion",rank=2,school=7,spellType="damage",minDmg=60,maxDmg=66,manaCost=120,castTime=0,spCoeff=0.143,cd=0,level=22,isAoE=true},
    S{name="Arcane Explosion",rank=3,school=7,spellType="damage",minDmg=101,maxDmg=110,manaCost=170,castTime=0,spCoeff=0.143,cd=0,level=30,isAoE=true},
    S{name="Arcane Explosion",rank=4,school=7,spellType="damage",minDmg=143,maxDmg=155,manaCost=225,castTime=0,spCoeff=0.143,cd=0,level=38,isAoE=true},
    S{name="Arcane Explosion",rank=5,school=7,spellType="damage",minDmg=192,maxDmg=209,manaCost=285,castTime=0,spCoeff=0.143,cd=0,level=46,isAoE=true},
    S{name="Arcane Explosion",rank=6,school=7,spellType="damage",minDmg=249,maxDmg=270,manaCost=390,castTime=0,spCoeff=0.143,cd=0,level=54,isAoE=true},

    -- BLIZZARD (AoE, channeled, no cooldown)
    S{name="Blizzard",rank=1,school=5,spellType="ch_dmg",minDmg=200,maxDmg=200,manaCost=320,castTime=8.0,spCoeff=0.333,cd=0,level=20,isAoE=true},
    S{name="Blizzard",rank=2,school=5,spellType="ch_dmg",minDmg=352,maxDmg=352,manaCost=520,castTime=8.0,spCoeff=0.333,cd=0,level=28,isAoE=true},
    S{name="Blizzard",rank=3,school=5,spellType="ch_dmg",minDmg=520,maxDmg=520,manaCost=720,castTime=8.0,spCoeff=0.333,cd=0,level=36,isAoE=true},
    S{name="Blizzard",rank=4,school=5,spellType="ch_dmg",minDmg=720,maxDmg=720,manaCost=870,castTime=8.0,spCoeff=0.333,cd=0,level=44,isAoE=true},
    S{name="Blizzard",rank=5,school=5,spellType="ch_dmg",minDmg=936,maxDmg=936,manaCost=1010,castTime=8.0,spCoeff=0.333,cd=0,level=52,isAoE=true},
    S{name="Blizzard",rank=6,school=5,spellType="ch_dmg",minDmg=1192,maxDmg=1192,manaCost=1160,castTime=8.0,spCoeff=0.333,cd=0,level=60,isAoE=true},
}

-- ============================================================================
-- PRIEST
-- ============================================================================
SPELLCALC_SPELLS["PRIEST"] = {
    -- SMITE
    S{name="Smite",rank=1,school=2,spellType="damage",minDmg=13,maxDmg=18,manaCost=20,castTime=1.5,spCoeff=0.123,cd=0,level=1},
    S{name="Smite",rank=2,school=2,spellType="damage",minDmg=25,maxDmg=32,manaCost=35,castTime=2.0,spCoeff=0.271,cd=0,level=6},
    S{name="Smite",rank=3,school=2,spellType="damage",minDmg=54,maxDmg=63,manaCost=60,castTime=2.5,spCoeff=0.554,cd=0,level=14},
    S{name="Smite",rank=4,school=2,spellType="damage",minDmg=91,maxDmg=104,manaCost=95,castTime=2.5,spCoeff=0.714,cd=0,level=22},
    S{name="Smite",rank=5,school=2,spellType="damage",minDmg=150,maxDmg=170,manaCost=140,castTime=2.5,spCoeff=0.714,cd=0,level=30},
    S{name="Smite",rank=6,school=2,spellType="damage",minDmg=212,maxDmg=240,manaCost=185,castTime=2.5,spCoeff=0.714,cd=0,level=38},
    S{name="Smite",rank=7,school=2,spellType="damage",minDmg=287,maxDmg=323,manaCost=230,castTime=2.5,spCoeff=0.714,cd=0,level=46},
    S{name="Smite",rank=8,school=2,spellType="damage",minDmg=549,maxDmg=616,manaCost=280,castTime=2.5,spCoeff=0.714,cd=0,level=54},

    -- HOLY FIRE (dd+dot, no cooldown)
    S{name="Holy Fire",rank=1,school=2,spellType="dd+dot",minDmg=83,maxDmg=107,manaCost=85,castTime=3.5,spCoeff=0.75,cd=0,level=20,dotTotal=33,dotDuration=10,dotCoeff=0.167},
    S{name="Holy Fire",rank=2,school=2,spellType="dd+dot",minDmg=103,maxDmg=131,manaCost=95,castTime=3.5,spCoeff=0.75,cd=0,level=24,dotTotal=42,dotDuration=10,dotCoeff=0.167},
    S{name="Holy Fire",rank=3,school=2,spellType="dd+dot",minDmg=127,maxDmg=161,manaCost=110,castTime=3.5,spCoeff=0.75,cd=0,level=30,dotTotal=54,dotDuration=10,dotCoeff=0.167},
    S{name="Holy Fire",rank=4,school=2,spellType="dd+dot",minDmg=152,maxDmg=193,manaCost=125,castTime=3.5,spCoeff=0.75,cd=0,level=36,dotTotal=66,dotDuration=10,dotCoeff=0.167},
    S{name="Holy Fire",rank=5,school=2,spellType="dd+dot",minDmg=197,maxDmg=250,manaCost=145,castTime=3.5,spCoeff=0.75,cd=0,level=42,dotTotal=87,dotDuration=10,dotCoeff=0.167},
    S{name="Holy Fire",rank=6,school=2,spellType="dd+dot",minDmg=230,maxDmg=291,manaCost=165,castTime=3.5,spCoeff=0.75,cd=0,level=48,dotTotal=102,dotDuration=10,dotCoeff=0.167},
    S{name="Holy Fire",rank=7,school=2,spellType="dd+dot",minDmg=271,maxDmg=343,manaCost=185,castTime=3.5,spCoeff=0.75,cd=0,level=54,dotTotal=126,dotDuration=10,dotCoeff=0.167},
    S{name="Holy Fire",rank=8,school=2,spellType="dd+dot",minDmg=355,maxDmg=449,manaCost=255,castTime=3.5,spCoeff=0.75,cd=0,level=60,dotTotal=165,dotDuration=10,dotCoeff=0.167},

    -- MIND BLAST (8s cooldown)
    S{name="Mind Blast",rank=1,school=6,spellType="damage",minDmg=39,maxDmg=43,manaCost=50,castTime=1.5,spCoeff=0.429,cd=8,level=10},
    S{name="Mind Blast",rank=2,school=6,spellType="damage",minDmg=72,maxDmg=78,manaCost=80,castTime=1.5,spCoeff=0.429,cd=8,level=16},
    S{name="Mind Blast",rank=3,school=6,spellType="damage",minDmg=112,maxDmg=120,manaCost=110,castTime=1.5,spCoeff=0.429,cd=8,level=22},
    S{name="Mind Blast",rank=4,school=6,spellType="damage",minDmg=157,maxDmg=167,manaCost=150,castTime=1.5,spCoeff=0.429,cd=8,level=28},
    S{name="Mind Blast",rank=5,school=6,spellType="damage",minDmg=200,maxDmg=212,manaCost=185,castTime=1.5,spCoeff=0.429,cd=8,level=34},
    S{name="Mind Blast",rank=6,school=6,spellType="damage",minDmg=253,maxDmg=267,manaCost=225,castTime=1.5,spCoeff=0.429,cd=8,level=40},
    S{name="Mind Blast",rank=7,school=6,spellType="damage",minDmg=305,maxDmg=323,manaCost=265,castTime=1.5,spCoeff=0.429,cd=8,level=46},
    S{name="Mind Blast",rank=8,school=6,spellType="damage",minDmg=370,maxDmg=392,manaCost=310,castTime=1.5,spCoeff=0.429,cd=8,level=52},
    S{name="Mind Blast",rank=9,school=6,spellType="damage",minDmg=508,maxDmg=537,manaCost=350,castTime=1.5,spCoeff=0.429,cd=8,level=58},

    -- SHADOW WORD: PAIN (DoT, no cooldown)
    S{name="Shadow Word: Pain",rank=1,school=6,spellType="dot",manaCost=25,castTime=0,cd=0,level=4,dotTotal=30,dotDuration=18,dotCoeff=0.667},
    S{name="Shadow Word: Pain",rank=2,school=6,spellType="dot",manaCost=50,castTime=0,cd=0,level=10,dotTotal=66,dotDuration=18,dotCoeff=0.667},
    S{name="Shadow Word: Pain",rank=3,school=6,spellType="dot",manaCost=85,castTime=0,cd=0,level=18,dotTotal=132,dotDuration=18,dotCoeff=0.667},
    S{name="Shadow Word: Pain",rank=4,school=6,spellType="dot",manaCost=110,castTime=0,cd=0,level=24,dotTotal=204,dotDuration=18,dotCoeff=0.833},
    S{name="Shadow Word: Pain",rank=5,school=6,spellType="dot",manaCost=155,castTime=0,cd=0,level=30,dotTotal=294,dotDuration=18,dotCoeff=1.0},
    S{name="Shadow Word: Pain",rank=6,school=6,spellType="dot",manaCost=200,castTime=0,cd=0,level=36,dotTotal=390,dotDuration=24,dotCoeff=1.0},
    S{name="Shadow Word: Pain",rank=7,school=6,spellType="dot",manaCost=255,castTime=0,cd=0,level=42,dotTotal=510,dotDuration=24,dotCoeff=1.0},
    S{name="Shadow Word: Pain",rank=8,school=6,spellType="dot",manaCost=385,castTime=0,cd=0,level=58,dotTotal=852,dotDuration=24,dotCoeff=1.0},

    -- MIND FLAY (channeled, no cooldown)
    S{name="Mind Flay",rank=1,school=6,spellType="ch_dmg",minDmg=75,maxDmg=75,manaCost=45,castTime=3.0,spCoeff=0.429,cd=0,level=20},
    S{name="Mind Flay",rank=2,school=6,spellType="ch_dmg",minDmg=126,maxDmg=126,manaCost=70,castTime=3.0,spCoeff=0.429,cd=0,level=28},
    S{name="Mind Flay",rank=3,school=6,spellType="ch_dmg",minDmg=186,maxDmg=186,manaCost=100,castTime=3.0,spCoeff=0.429,cd=0,level=36},
    S{name="Mind Flay",rank=4,school=6,spellType="ch_dmg",minDmg=261,maxDmg=261,manaCost=135,castTime=3.0,spCoeff=0.429,cd=0,level=44},
    S{name="Mind Flay",rank=5,school=6,spellType="ch_dmg",minDmg=330,maxDmg=330,manaCost=165,castTime=3.0,spCoeff=0.429,cd=0,level=52},
    S{name="Mind Flay",rank=6,school=6,spellType="ch_dmg",minDmg=426,maxDmg=426,manaCost=205,castTime=3.0,spCoeff=0.429,cd=0,level=60},

    -- DEVOURING PLAGUE (DoT, 3min cooldown - Undead racial)
    S{name="Devouring Plague",rank=1,school=6,spellType="dot",manaCost=215,castTime=0,cd=180,level=20,dotTotal=152,dotDuration=24,dotCoeff=1.0},
    S{name="Devouring Plague",rank=2,school=6,spellType="dot",manaCost=350,castTime=0,cd=180,level=28,dotTotal=272,dotDuration=24,dotCoeff=1.0},
    S{name="Devouring Plague",rank=3,school=6,spellType="dot",manaCost=495,castTime=0,cd=180,level=36,dotTotal=400,dotDuration=24,dotCoeff=1.0},
    S{name="Devouring Plague",rank=4,school=6,spellType="dot",manaCost=645,castTime=0,cd=180,level=44,dotTotal=544,dotDuration=24,dotCoeff=1.0},
    S{name="Devouring Plague",rank=5,school=6,spellType="dot",manaCost=790,castTime=0,cd=180,level=52,dotTotal=712,dotDuration=24,dotCoeff=1.0},
    S{name="Devouring Plague",rank=6,school=6,spellType="dot",manaCost=985,castTime=0,cd=180,level=60,dotTotal=904,dotDuration=24,dotCoeff=1.0},

    -- FLASH HEAL
    S{name="Flash Heal",rank=1,school=2,spellType="heal",minDmg=193,maxDmg=237,manaCost=125,castTime=1.5,hpCoeff=0.429,cd=0,level=20},
    S{name="Flash Heal",rank=2,school=2,spellType="heal",minDmg=258,maxDmg=314,manaCost=155,castTime=1.5,hpCoeff=0.429,cd=0,level=26},
    S{name="Flash Heal",rank=3,school=2,spellType="heal",minDmg=327,maxDmg=393,manaCost=185,castTime=1.5,hpCoeff=0.429,cd=0,level=32},
    S{name="Flash Heal",rank=4,school=2,spellType="heal",minDmg=400,maxDmg=478,manaCost=215,castTime=1.5,hpCoeff=0.429,cd=0,level=38},
    S{name="Flash Heal",rank=5,school=2,spellType="heal",minDmg=518,maxDmg=616,manaCost=265,castTime=1.5,hpCoeff=0.429,cd=0,level=44},
    S{name="Flash Heal",rank=6,school=2,spellType="heal",minDmg=644,maxDmg=764,manaCost=315,castTime=1.5,hpCoeff=0.429,cd=0,level=50},
    S{name="Flash Heal",rank=7,school=2,spellType="heal",minDmg=828,maxDmg=957,manaCost=380,castTime=1.5,hpCoeff=0.429,cd=0,level=56},

    -- GREATER HEAL
    S{name="Greater Heal",rank=1,school=2,spellType="heal",minDmg=899,maxDmg=1013,manaCost=370,castTime=3.0,hpCoeff=0.857,cd=0,level=40},
    S{name="Greater Heal",rank=2,school=2,spellType="heal",minDmg=1149,maxDmg=1289,manaCost=455,castTime=3.0,hpCoeff=0.857,cd=0,level=46},
    S{name="Greater Heal",rank=3,school=2,spellType="heal",minDmg=1437,maxDmg=1609,manaCost=545,castTime=3.0,hpCoeff=0.857,cd=0,level=52},
    S{name="Greater Heal",rank=4,school=2,spellType="heal",minDmg=1735,maxDmg=1935,manaCost=620,castTime=3.0,hpCoeff=0.857,cd=0,level=56},
    S{name="Greater Heal",rank=5,school=2,spellType="heal",minDmg=1966,maxDmg=2194,manaCost=710,castTime=3.0,hpCoeff=0.857,cd=0,level=60},

    -- HEAL
    S{name="Heal",rank=1,school=2,spellType="heal",minDmg=307,maxDmg=353,manaCost=155,castTime=3.0,hpCoeff=0.857,cd=0,level=16},
    S{name="Heal",rank=2,school=2,spellType="heal",minDmg=445,maxDmg=507,manaCost=205,castTime=3.0,hpCoeff=0.857,cd=0,level=22},
    S{name="Heal",rank=3,school=2,spellType="heal",minDmg=586,maxDmg=662,manaCost=255,castTime=3.0,hpCoeff=0.857,cd=0,level=28},
    S{name="Heal",rank=4,school=2,spellType="heal",minDmg=734,maxDmg=828,manaCost=305,castTime=3.0,hpCoeff=0.857,cd=0,level=34},

    -- LESSER HEAL
    S{name="Lesser Heal",rank=1,school=2,spellType="heal",minDmg=47,maxDmg=58,manaCost=30,castTime=1.5,hpCoeff=0.123,cd=0,level=1},
    S{name="Lesser Heal",rank=2,school=2,spellType="heal",minDmg=76,maxDmg=91,manaCost=45,castTime=2.0,hpCoeff=0.271,cd=0,level=4},
    S{name="Lesser Heal",rank=3,school=2,spellType="heal",minDmg=143,maxDmg=165,manaCost=75,castTime=2.5,hpCoeff=0.554,cd=0,level=10},

    -- RENEW (HoT)
    S{name="Renew",rank=1,school=2,spellType="hot",manaCost=30,castTime=0,cd=0,level=8,dotTotal=45,dotDuration=15,dotCoeff=1.0},
    S{name="Renew",rank=2,school=2,spellType="hot",manaCost=65,castTime=0,cd=0,level=14,dotTotal=100,dotDuration=15,dotCoeff=1.0},
    S{name="Renew",rank=3,school=2,spellType="hot",manaCost=105,castTime=0,cd=0,level=20,dotTotal=175,dotDuration=15,dotCoeff=1.0},
    S{name="Renew",rank=4,school=2,spellType="hot",manaCost=140,castTime=0,cd=0,level=26,dotTotal=245,dotDuration=15,dotCoeff=1.0},
    S{name="Renew",rank=5,school=2,spellType="hot",manaCost=170,castTime=0,cd=0,level=32,dotTotal=315,dotDuration=15,dotCoeff=1.0},
    S{name="Renew",rank=6,school=2,spellType="hot",manaCost=205,castTime=0,cd=0,level=38,dotTotal=400,dotDuration=15,dotCoeff=1.0},
    S{name="Renew",rank=7,school=2,spellType="hot",manaCost=250,castTime=0,cd=0,level=44,dotTotal=510,dotDuration=15,dotCoeff=1.0},
    S{name="Renew",rank=8,school=2,spellType="hot",manaCost=305,castTime=0,cd=0,level=50,dotTotal=650,dotDuration=15,dotCoeff=1.0},
    S{name="Renew",rank=9,school=2,spellType="hot",manaCost=365,castTime=0,cd=0,level=56,dotTotal=810,dotDuration=15,dotCoeff=1.0},
    S{name="Renew",rank=10,school=2,spellType="hot",manaCost=410,castTime=0,cd=0,level=60,dotTotal=970,dotDuration=15,dotCoeff=1.0},

    -- PRAYER OF HEALING (AoE heal)
    S{name="Prayer of Healing",rank=1,school=2,spellType="heal",minDmg=301,maxDmg=321,manaCost=410,castTime=3.0,hpCoeff=0.286,cd=0,level=30,isAoE=true},
    S{name="Prayer of Healing",rank=2,school=2,spellType="heal",minDmg=444,maxDmg=472,manaCost=560,castTime=3.0,hpCoeff=0.286,cd=0,level=40,isAoE=true},
    S{name="Prayer of Healing",rank=3,school=2,spellType="heal",minDmg=657,maxDmg=695,manaCost=770,castTime=3.0,hpCoeff=0.286,cd=0,level=50,isAoE=true},
    S{name="Prayer of Healing",rank=4,school=2,spellType="heal",minDmg=939,maxDmg=991,manaCost=1030,castTime=3.0,hpCoeff=0.286,cd=0,level=60,isAoE=true},

    -- [patch] POWER WORD: SHIELD (Absorb, 30s Dauer, 4s Cooldown)
    -- Der Absorb-Betrag ist fix, deshalb minDmg = maxDmg.
    -- Koeffizient: Absorbs sind in 1.12 hart auf 10% Bonusheilung gedeckelt,
    -- nicht auf die ueblichen 1.5/3.5 = 0.4286. Falls Octo davon abweicht,
    -- hier hpCoeff anpassen (0.1 -> z.B. 0.2).
    S{name="Power Word: Shield",rank=1,school=2,spellType="heal",minDmg=44,maxDmg=44,manaCost=45,castTime=0,hpCoeff=0.1,cd=4,level=6},
    S{name="Power Word: Shield",rank=2,school=2,spellType="heal",minDmg=88,maxDmg=88,manaCost=80,castTime=0,hpCoeff=0.1,cd=4,level=12},
    S{name="Power Word: Shield",rank=3,school=2,spellType="heal",minDmg=158,maxDmg=158,manaCost=130,castTime=0,hpCoeff=0.1,cd=4,level=18},
    S{name="Power Word: Shield",rank=4,school=2,spellType="heal",minDmg=234,maxDmg=234,manaCost=175,castTime=0,hpCoeff=0.1,cd=4,level=24},
    S{name="Power Word: Shield",rank=5,school=2,spellType="heal",minDmg=301,maxDmg=301,manaCost=210,castTime=0,hpCoeff=0.1,cd=4,level=30},
    S{name="Power Word: Shield",rank=6,school=2,spellType="heal",minDmg=381,maxDmg=381,manaCost=250,castTime=0,hpCoeff=0.1,cd=4,level=36},
    S{name="Power Word: Shield",rank=7,school=2,spellType="heal",minDmg=484,maxDmg=484,manaCost=300,castTime=0,hpCoeff=0.1,cd=4,level=42},
    S{name="Power Word: Shield",rank=8,school=2,spellType="heal",minDmg=605,maxDmg=605,manaCost=365,castTime=0,hpCoeff=0.1,cd=4,level=48},
    S{name="Power Word: Shield",rank=9,school=2,spellType="heal",minDmg=763,maxDmg=763,manaCost=440,castTime=0,hpCoeff=0.1,cd=4,level=54},
    S{name="Power Word: Shield",rank=10,school=2,spellType="heal",minDmg=942,maxDmg=942,manaCost=500,castTime=0,hpCoeff=0.1,cd=4,level=60},
}

-- ============================================================================
-- WARLOCK
-- ============================================================================
SPELLCALC_SPELLS["WARLOCK"] = {
    -- SHADOW BOLT
    S{name="Shadow Bolt",rank=1,school=6,spellType="damage",minDmg=13,maxDmg=18,manaCost=25,castTime=1.7,spCoeff=0.286,cd=0,level=1},
    S{name="Shadow Bolt",rank=2,school=6,spellType="damage",minDmg=26,maxDmg=32,manaCost=40,castTime=2.2,spCoeff=0.429,cd=0,level=6},
    S{name="Shadow Bolt",rank=3,school=6,spellType="damage",minDmg=52,maxDmg=61,manaCost=70,castTime=2.8,spCoeff=0.571,cd=0,level=12},
    S{name="Shadow Bolt",rank=4,school=6,spellType="damage",minDmg=92,maxDmg=104,manaCost=110,castTime=3.0,spCoeff=0.857,cd=0,level=20},
    S{name="Shadow Bolt",rank=5,school=6,spellType="damage",minDmg=143,maxDmg=162,manaCost=160,castTime=3.0,spCoeff=0.857,cd=0,level=28},
    S{name="Shadow Bolt",rank=6,school=6,spellType="damage",minDmg=204,maxDmg=228,manaCost=210,castTime=3.0,spCoeff=0.857,cd=0,level=34},
    S{name="Shadow Bolt",rank=7,school=6,spellType="damage",minDmg=271,maxDmg=302,manaCost=265,castTime=3.0,spCoeff=0.857,cd=0,level=42},
    S{name="Shadow Bolt",rank=8,school=6,spellType="damage",minDmg=340,maxDmg=378,manaCost=300,castTime=3.0,spCoeff=0.857,cd=0,level=48},
    S{name="Shadow Bolt",rank=9,school=6,spellType="damage",minDmg=402,maxDmg=447,manaCost=335,castTime=3.0,spCoeff=0.857,cd=0,level=54},
    S{name="Shadow Bolt",rank=10,school=6,spellType="damage",minDmg=482,maxDmg=538,manaCost=370,castTime=3.0,spCoeff=0.857,cd=0,level=60},

    -- CORRUPTION (DoT, no cooldown)
    S{name="Corruption",rank=1,school=6,spellType="dot",manaCost=35,castTime=0,cd=0,level=4,dotTotal=40,dotDuration=12,dotCoeff=0.8},
    S{name="Corruption",rank=2,school=6,spellType="dot",manaCost=55,castTime=0,cd=0,level=14,dotTotal=90,dotDuration=15,dotCoeff=1.0},
    S{name="Corruption",rank=3,school=6,spellType="dot",manaCost=100,castTime=0,cd=0,level=24,dotTotal=222,dotDuration=18,dotCoeff=1.0},
    S{name="Corruption",rank=4,school=6,spellType="dot",manaCost=160,castTime=0,cd=0,level=34,dotTotal=324,dotDuration=18,dotCoeff=1.0},
    S{name="Corruption",rank=5,school=6,spellType="dot",manaCost=225,castTime=0,cd=0,level=44,dotTotal=486,dotDuration=18,dotCoeff=1.0},
    S{name="Corruption",rank=6,school=6,spellType="dot",manaCost=290,castTime=0,cd=0,level=54,dotTotal=666,dotDuration=18,dotCoeff=1.0},
    S{name="Corruption",rank=7,school=6,spellType="dot",manaCost=340,castTime=0,cd=0,level=60,dotTotal=822,dotDuration=18,dotCoeff=1.0},

    -- CURSE OF AGONY (DoT, no cooldown)
    S{name="Curse of Agony",rank=1,school=6,spellType="dot",manaCost=25,castTime=0,cd=0,level=8,dotTotal=84,dotDuration=24,dotCoeff=1.0},
    S{name="Curse of Agony",rank=2,school=6,spellType="dot",manaCost=50,castTime=0,cd=0,level=18,dotTotal=180,dotDuration=24,dotCoeff=1.0},
    S{name="Curse of Agony",rank=3,school=6,spellType="dot",manaCost=90,castTime=0,cd=0,level=28,dotTotal=324,dotDuration=24,dotCoeff=1.0},
    S{name="Curse of Agony",rank=4,school=6,spellType="dot",manaCost=130,castTime=0,cd=0,level=38,dotTotal=504,dotDuration=24,dotCoeff=1.0},
    S{name="Curse of Agony",rank=5,school=6,spellType="dot",manaCost=170,castTime=0,cd=0,level=48,dotTotal=780,dotDuration=24,dotCoeff=1.0},
    S{name="Curse of Agony",rank=6,school=6,spellType="dot",manaCost=215,castTime=0,cd=0,level=58,dotTotal=1044,dotDuration=24,dotCoeff=1.0},

    -- IMMOLATE (dd+dot, no cooldown)
    S{name="Immolate",rank=1,school=3,spellType="dd+dot",minDmg=11,maxDmg=11,manaCost=25,castTime=2.0,spCoeff=0.157,cd=0,level=1,dotTotal=20,dotDuration=15,dotCoeff=0.651},
    S{name="Immolate",rank=2,school=3,spellType="dd+dot",minDmg=22,maxDmg=22,manaCost=45,castTime=2.0,spCoeff=0.157,cd=0,level=10,dotTotal=40,dotDuration=15,dotCoeff=0.651},
    S{name="Immolate",rank=3,school=3,spellType="dd+dot",minDmg=45,maxDmg=45,manaCost=90,castTime=2.0,spCoeff=0.157,cd=0,level=20,dotTotal=90,dotDuration=15,dotCoeff=0.651},
    S{name="Immolate",rank=4,school=3,spellType="dd+dot",minDmg=86,maxDmg=86,manaCost=145,castTime=2.0,spCoeff=0.157,cd=0,level=30,dotTotal=165,dotDuration=15,dotCoeff=0.651},
    S{name="Immolate",rank=5,school=3,spellType="dd+dot",minDmg=131,maxDmg=131,manaCost=200,castTime=2.0,spCoeff=0.157,cd=0,level=38,dotTotal=255,dotDuration=15,dotCoeff=0.651},
    S{name="Immolate",rank=6,school=3,spellType="dd+dot",minDmg=183,maxDmg=183,manaCost=255,castTime=2.0,spCoeff=0.157,cd=0,level=46,dotTotal=345,dotDuration=15,dotCoeff=0.651},
    S{name="Immolate",rank=7,school=3,spellType="dd+dot",minDmg=231,maxDmg=231,manaCost=310,castTime=2.0,spCoeff=0.157,cd=0,level=54,dotTotal=435,dotDuration=15,dotCoeff=0.651},
    S{name="Immolate",rank=8,school=3,spellType="dd+dot",minDmg=279,maxDmg=279,manaCost=370,castTime=2.0,spCoeff=0.157,cd=0,level=60,dotTotal=510,dotDuration=15,dotCoeff=0.651},

    -- SEARING PAIN (no cooldown)
    S{name="Searing Pain",rank=1,school=3,spellType="damage",minDmg=34,maxDmg=42,manaCost=30,castTime=1.5,spCoeff=0.429,cd=0,level=18},
    S{name="Searing Pain",rank=2,school=3,spellType="damage",minDmg=58,maxDmg=70,manaCost=45,castTime=1.5,spCoeff=0.429,cd=0,level=26},
    S{name="Searing Pain",rank=3,school=3,spellType="damage",minDmg=87,maxDmg=103,manaCost=65,castTime=1.5,spCoeff=0.429,cd=0,level=34},
    S{name="Searing Pain",rank=4,school=3,spellType="damage",minDmg=112,maxDmg=132,manaCost=85,castTime=1.5,spCoeff=0.429,cd=0,level=42},
    S{name="Searing Pain",rank=5,school=3,spellType="damage",minDmg=158,maxDmg=188,manaCost=110,castTime=1.5,spCoeff=0.429,cd=0,level=50},
    S{name="Searing Pain",rank=6,school=3,spellType="damage",minDmg=204,maxDmg=240,manaCost=141,castTime=1.5,spCoeff=0.429,cd=0,level=58},

    -- SOUL FIRE (no cooldown)
    S{name="Soul Fire",rank=1,school=3,spellType="damage",minDmg=623,maxDmg=783,manaCost=250,castTime=6.0,spCoeff=1.0,cd=0,level=48},
    S{name="Soul Fire",rank=2,school=3,spellType="damage",minDmg=1003,maxDmg=1257,manaCost=335,castTime=6.0,spCoeff=1.0,cd=0,level=56},

    -- DEATH COIL (2min cooldown)
    S{name="Death Coil",rank=1,school=6,spellType="damage",minDmg=225,maxDmg=225,manaCost=430,castTime=0,spCoeff=0.214,cd=120,level=42},
    S{name="Death Coil",rank=2,school=6,spellType="damage",minDmg=305,maxDmg=305,manaCost=495,castTime=0,spCoeff=0.214,cd=120,level=50},
    S{name="Death Coil",rank=3,school=6,spellType="damage",minDmg=400,maxDmg=400,manaCost=565,castTime=0,spCoeff=0.214,cd=120,level=58},

    -- CONFLAGRATE (10s cooldown)
    S{name="Conflagrate",rank=1,school=3,spellType="damage",minDmg=249,maxDmg=316,manaCost=165,castTime=0,spCoeff=0.429,cd=10,level=40},
    S{name="Conflagrate",rank=2,school=3,spellType="damage",minDmg=319,maxDmg=400,manaCost=200,castTime=0,spCoeff=0.429,cd=10,level=48},
    S{name="Conflagrate",rank=3,school=3,spellType="damage",minDmg=383,maxDmg=480,manaCost=230,castTime=0,spCoeff=0.429,cd=10,level=54},
    S{name="Conflagrate",rank=4,school=3,spellType="damage",minDmg=447,maxDmg=557,manaCost=305,castTime=0,spCoeff=0.429,cd=10,level=60},

    -- DRAIN LIFE (channeled, no cooldown)
    S{name="Drain Life",rank=1,school=6,spellType="ch_dmg",minDmg=10,maxDmg=10,manaCost=55,castTime=5.0,spCoeff=0.714,cd=0,level=14},
    S{name="Drain Life",rank=2,school=6,spellType="ch_dmg",minDmg=55,maxDmg=55,manaCost=85,castTime=5.0,spCoeff=0.714,cd=0,level=22},
    S{name="Drain Life",rank=3,school=6,spellType="ch_dmg",minDmg=155,maxDmg=155,manaCost=135,castTime=5.0,spCoeff=0.714,cd=0,level=30},
    S{name="Drain Life",rank=4,school=6,spellType="ch_dmg",minDmg=205,maxDmg=205,manaCost=170,castTime=5.0,spCoeff=0.714,cd=0,level=38},
    S{name="Drain Life",rank=5,school=6,spellType="ch_dmg",minDmg=305,maxDmg=305,manaCost=215,castTime=5.0,spCoeff=0.714,cd=0,level=46},
    S{name="Drain Life",rank=6,school=6,spellType="ch_dmg",minDmg=410,maxDmg=410,manaCost=265,castTime=5.0,spCoeff=0.714,cd=0,level=54},
    S{name="Drain Life",rank=7,school=6,spellType="ch_dmg",minDmg=540,maxDmg=540,manaCost=300,castTime=5.0,spCoeff=0.714,cd=0,level=60},

    -- RAIN OF FIRE (AoE channeled, no cooldown)
    S{name="Rain of Fire",rank=1,school=3,spellType="ch_dmg",minDmg=228,maxDmg=228,manaCost=370,castTime=8.0,spCoeff=0.333,cd=0,level=20,isAoE=true},
    S{name="Rain of Fire",rank=2,school=3,spellType="ch_dmg",minDmg=412,maxDmg=412,manaCost=605,castTime=8.0,spCoeff=0.333,cd=0,level=34,isAoE=true},
    S{name="Rain of Fire",rank=3,school=3,spellType="ch_dmg",minDmg=644,maxDmg=644,manaCost=885,castTime=8.0,spCoeff=0.333,cd=0,level=46,isAoE=true},
    S{name="Rain of Fire",rank=4,school=3,spellType="ch_dmg",minDmg=904,maxDmg=904,manaCost=1185,castTime=8.0,spCoeff=0.333,cd=0,level=58,isAoE=true},

    -- HELLFIRE (AoE channeled, no cooldown, damages self)
    S{name="Hellfire",rank=1,school=3,spellType="ch_dmg",minDmg=285,maxDmg=285,manaCost=325,castTime=15.0,spCoeff=0.333,cd=0,level=24,isAoE=true},
    S{name="Hellfire",rank=2,school=3,spellType="ch_dmg",minDmg=536,maxDmg=536,manaCost=485,castTime=15.0,spCoeff=0.333,cd=0,level=40,isAoE=true},
    S{name="Hellfire",rank=3,school=3,spellType="ch_dmg",minDmg=838,maxDmg=838,manaCost=645,castTime=15.0,spCoeff=0.333,cd=0,level=56,isAoE=true},
}

-- ============================================================================
-- DRUID
-- ============================================================================
SPELLCALC_SPELLS["DRUID"] = {
    -- WRATH
    S{name="Wrath",rank=1,school=4,spellType="damage",minDmg=13,maxDmg=16,manaCost=20,castTime=1.5,spCoeff=0.123,cd=0,level=1},
    S{name="Wrath",rank=2,school=4,spellType="damage",minDmg=28,maxDmg=33,manaCost=35,castTime=1.7,spCoeff=0.271,cd=0,level=6},
    S{name="Wrath",rank=3,school=4,spellType="damage",minDmg=48,maxDmg=57,manaCost=55,castTime=2.0,spCoeff=0.500,cd=0,level=14},
    S{name="Wrath",rank=4,school=4,spellType="damage",minDmg=69,maxDmg=79,manaCost=70,castTime=2.0,spCoeff=0.571,cd=0,level=22},
    S{name="Wrath",rank=5,school=4,spellType="damage",minDmg=108,maxDmg=123,manaCost=100,castTime=2.0,spCoeff=0.571,cd=0,level=30},
    S{name="Wrath",rank=6,school=4,spellType="damage",minDmg=148,maxDmg=167,manaCost=125,castTime=2.0,spCoeff=0.571,cd=0,level=38},
    S{name="Wrath",rank=7,school=4,spellType="damage",minDmg=198,maxDmg=221,manaCost=155,castTime=2.0,spCoeff=0.571,cd=0,level=46},
    S{name="Wrath",rank=8,school=4,spellType="damage",minDmg=292,maxDmg=328,manaCost=180,castTime=2.0,spCoeff=0.571,cd=0,level=54},

    -- STARFIRE
    S{name="Starfire",rank=1,school=7,spellType="damage",minDmg=95,maxDmg=115,manaCost=95,castTime=3.5,spCoeff=1.0,cd=0,level=20},
    S{name="Starfire",rank=2,school=7,spellType="damage",minDmg=146,maxDmg=177,manaCost=135,castTime=3.5,spCoeff=1.0,cd=0,level=26},
    S{name="Starfire",rank=3,school=7,spellType="damage",minDmg=212,maxDmg=253,manaCost=180,castTime=3.5,spCoeff=1.0,cd=0,level=34},
    S{name="Starfire",rank=4,school=7,spellType="damage",minDmg=275,maxDmg=327,manaCost=220,castTime=3.5,spCoeff=1.0,cd=0,level=40},
    S{name="Starfire",rank=5,school=7,spellType="damage",minDmg=348,maxDmg=413,manaCost=265,castTime=3.5,spCoeff=1.0,cd=0,level=48},
    S{name="Starfire",rank=6,school=7,spellType="damage",minDmg=409,maxDmg=485,manaCost=295,castTime=3.5,spCoeff=1.0,cd=0,level=54},
    S{name="Starfire",rank=7,school=7,spellType="damage",minDmg=496,maxDmg=584,manaCost=315,castTime=3.5,spCoeff=1.0,cd=0,level=60},

    -- MOONFIRE (dd+dot)
    S{name="Moonfire",rank=1,school=7,spellType="dd+dot",minDmg=9,maxDmg=9,manaCost=25,castTime=0,spCoeff=0.15,cd=0,level=4,dotTotal=12,dotDuration=9,dotCoeff=0.13},
    S{name="Moonfire",rank=2,school=7,spellType="dd+dot",minDmg=17,maxDmg=17,manaCost=50,castTime=0,spCoeff=0.15,cd=0,level=10,dotTotal=32,dotDuration=12,dotCoeff=0.17},
    S{name="Moonfire",rank=3,school=7,spellType="dd+dot",minDmg=30,maxDmg=30,manaCost=75,castTime=0,spCoeff=0.15,cd=0,level=16,dotTotal=52,dotDuration=12,dotCoeff=0.17},
    S{name="Moonfire",rank=4,school=7,spellType="dd+dot",minDmg=47,maxDmg=47,manaCost=105,castTime=0,spCoeff=0.15,cd=0,level=22,dotTotal=80,dotDuration=12,dotCoeff=0.22},
    S{name="Moonfire",rank=5,school=7,spellType="dd+dot",minDmg=64,maxDmg=64,manaCost=140,castTime=0,spCoeff=0.15,cd=0,level=28,dotTotal=104,dotDuration=12,dotCoeff=0.26},
    S{name="Moonfire",rank=6,school=7,spellType="dd+dot",minDmg=91,maxDmg=91,manaCost=190,castTime=0,spCoeff=0.15,cd=0,level=34,dotTotal=152,dotDuration=12,dotCoeff=0.33},
    S{name="Moonfire",rank=7,school=7,spellType="dd+dot",minDmg=117,maxDmg=117,manaCost=235,castTime=0,spCoeff=0.15,cd=0,level=40,dotTotal=200,dotDuration=12,dotCoeff=0.39},
    S{name="Moonfire",rank=8,school=7,spellType="dd+dot",minDmg=141,maxDmg=141,manaCost=280,castTime=0,spCoeff=0.15,cd=0,level=46,dotTotal=252,dotDuration=12,dotCoeff=0.44},
    S{name="Moonfire",rank=9,school=7,spellType="dd+dot",minDmg=172,maxDmg=172,manaCost=325,castTime=0,spCoeff=0.15,cd=0,level=52,dotTotal=320,dotDuration=12,dotCoeff=0.50},
    S{name="Moonfire",rank=10,school=7,spellType="dd+dot",minDmg=195,maxDmg=195,manaCost=375,castTime=0,spCoeff=0.15,cd=0,level=58,dotTotal=384,dotDuration=12,dotCoeff=0.52},

    -- INSECT SWARM (DoT)
    S{name="Insect Swarm",rank=1,school=4,spellType="dot",manaCost=45,castTime=0,cd=0,level=20,dotTotal=108,dotDuration=12,dotCoeff=0.8},
    S{name="Insect Swarm",rank=2,school=4,spellType="dot",manaCost=75,castTime=0,cd=0,level=30,dotTotal=192,dotDuration=12,dotCoeff=0.8},
    S{name="Insect Swarm",rank=3,school=4,spellType="dot",manaCost=105,castTime=0,cd=0,level=40,dotTotal=288,dotDuration=12,dotCoeff=0.8},
    S{name="Insect Swarm",rank=4,school=4,spellType="dot",manaCost=135,castTime=0,cd=0,level=50,dotTotal=360,dotDuration=12,dotCoeff=0.8},
    S{name="Insect Swarm",rank=5,school=4,spellType="dot",manaCost=175,castTime=0,cd=0,level=60,dotTotal=432,dotDuration=12,dotCoeff=0.8},

    -- HURRICANE (AoE channeled)
    S{name="Hurricane",rank=1,school=4,spellType="ch_dmg",minDmg=365,maxDmg=365,manaCost=730,castTime=10.0,spCoeff=0.333,cd=60,level=40,isAoE=true},
    S{name="Hurricane",rank=2,school=4,spellType="ch_dmg",minDmg=595,maxDmg=595,manaCost=935,castTime=10.0,spCoeff=0.333,cd=60,level=50,isAoE=true},
    S{name="Hurricane",rank=3,school=4,spellType="ch_dmg",minDmg=880,maxDmg=880,manaCost=1180,castTime=10.0,spCoeff=0.333,cd=60,level=60,isAoE=true},

    -- HEALING TOUCH
    S{name="Healing Touch",rank=1,school=4,spellType="heal",minDmg=37,maxDmg=52,manaCost=25,castTime=1.5,hpCoeff=0.123,cd=0,level=1},
    S{name="Healing Touch",rank=2,school=4,spellType="heal",minDmg=88,maxDmg=112,manaCost=55,castTime=2.0,hpCoeff=0.271,cd=0,level=8},
    S{name="Healing Touch",rank=3,school=4,spellType="heal",minDmg=195,maxDmg=243,manaCost=110,castTime=2.5,hpCoeff=0.554,cd=0,level=14},
    S{name="Healing Touch",rank=4,school=4,spellType="heal",minDmg=363,maxDmg=445,manaCost=185,castTime=3.0,hpCoeff=0.857,cd=0,level=20},
    S{name="Healing Touch",rank=5,school=4,spellType="heal",minDmg=490,maxDmg=594,manaCost=240,castTime=3.5,hpCoeff=1.0,cd=0,level=26},
    S{name="Healing Touch",rank=6,school=4,spellType="heal",minDmg=636,maxDmg=766,manaCost=290,castTime=3.5,hpCoeff=1.0,cd=0,level=32},
    S{name="Healing Touch",rank=7,school=4,spellType="heal",minDmg=802,maxDmg=960,manaCost=340,castTime=3.5,hpCoeff=1.0,cd=0,level=38},
    S{name="Healing Touch",rank=8,school=4,spellType="heal",minDmg=948,maxDmg=1130,manaCost=380,castTime=3.5,hpCoeff=1.0,cd=0,level=44},
    S{name="Healing Touch",rank=9,school=4,spellType="heal",minDmg=1099,maxDmg=1313,manaCost=430,castTime=3.5,hpCoeff=1.0,cd=0,level=50},
    S{name="Healing Touch",rank=10,school=4,spellType="heal",minDmg=1299,maxDmg=1539,manaCost=495,castTime=3.5,hpCoeff=1.0,cd=0,level=56},
    S{name="Healing Touch",rank=11,school=4,spellType="heal",minDmg=1516,maxDmg=1796,manaCost=620,castTime=3.5,hpCoeff=1.0,cd=0,level=60},

    -- REGROWTH (dd+hot)
    S{name="Regrowth",rank=1,school=4,spellType="dd+hot",minDmg=84,maxDmg=99,manaCost=80,castTime=2.0,hpCoeff=0.3,cd=0,level=12,dotTotal=98,dotDuration=21,dotCoeff=0.7},
    S{name="Regrowth",rank=2,school=4,spellType="dd+hot",minDmg=164,maxDmg=188,manaCost=135,castTime=2.0,hpCoeff=0.3,cd=0,level=18,dotTotal=175,dotDuration=21,dotCoeff=0.7},
    S{name="Regrowth",rank=3,school=4,spellType="dd+hot",minDmg=240,maxDmg=275,manaCost=185,castTime=2.0,hpCoeff=0.3,cd=0,level=24,dotTotal=259,dotDuration=21,dotCoeff=0.7},
    S{name="Regrowth",rank=4,school=4,spellType="dd+hot",minDmg=318,maxDmg=361,manaCost=230,castTime=2.0,hpCoeff=0.3,cd=0,level=30,dotTotal=343,dotDuration=21,dotCoeff=0.7},
    S{name="Regrowth",rank=5,school=4,spellType="dd+hot",minDmg=405,maxDmg=458,manaCost=275,castTime=2.0,hpCoeff=0.3,cd=0,level=36,dotTotal=427,dotDuration=21,dotCoeff=0.7},
    S{name="Regrowth",rank=6,school=4,spellType="dd+hot",minDmg=521,maxDmg=586,manaCost=335,castTime=2.0,hpCoeff=0.3,cd=0,level=42,dotTotal=546,dotDuration=21,dotCoeff=0.7},
    S{name="Regrowth",rank=7,school=4,spellType="dd+hot",minDmg=646,maxDmg=724,manaCost=405,castTime=2.0,hpCoeff=0.3,cd=0,level=48,dotTotal=686,dotDuration=21,dotCoeff=0.7},
    S{name="Regrowth",rank=8,school=4,spellType="dd+hot",minDmg=786,maxDmg=876,manaCost=485,castTime=2.0,hpCoeff=0.3,cd=0,level=54,dotTotal=861,dotDuration=21,dotCoeff=0.7},
    S{name="Regrowth",rank=9,school=4,spellType="dd+hot",minDmg=1003,maxDmg=1120,manaCost=675,castTime=2.0,hpCoeff=0.3,cd=0,level=60,dotTotal=1064,dotDuration=21,dotCoeff=0.7},

    -- REJUVENATION (HoT)
    S{name="Rejuvenation",rank=1,school=4,spellType="hot",manaCost=25,castTime=0,cd=0,level=4,dotTotal=32,dotDuration=12,dotCoeff=0.8},
    S{name="Rejuvenation",rank=2,school=4,spellType="hot",manaCost=40,castTime=0,cd=0,level=10,dotTotal=56,dotDuration=12,dotCoeff=0.8},
    S{name="Rejuvenation",rank=3,school=4,spellType="hot",manaCost=75,castTime=0,cd=0,level=16,dotTotal=116,dotDuration=12,dotCoeff=0.8},
    S{name="Rejuvenation",rank=4,school=4,spellType="hot",manaCost=105,castTime=0,cd=0,level=22,dotTotal=180,dotDuration=12,dotCoeff=0.8},
    S{name="Rejuvenation",rank=5,school=4,spellType="hot",manaCost=135,castTime=0,cd=0,level=28,dotTotal=244,dotDuration=12,dotCoeff=0.8},
    S{name="Rejuvenation",rank=6,school=4,spellType="hot",manaCost=160,castTime=0,cd=0,level=34,dotTotal=304,dotDuration=12,dotCoeff=0.8},
    S{name="Rejuvenation",rank=7,school=4,spellType="hot",manaCost=195,castTime=0,cd=0,level=40,dotTotal=388,dotDuration=12,dotCoeff=0.8},
    S{name="Rejuvenation",rank=8,school=4,spellType="hot",manaCost=235,castTime=0,cd=0,level=46,dotTotal=488,dotDuration=12,dotCoeff=0.8},
    S{name="Rejuvenation",rank=9,school=4,spellType="hot",manaCost=280,castTime=0,cd=0,level=52,dotTotal=608,dotDuration=12,dotCoeff=0.8},
    S{name="Rejuvenation",rank=10,school=4,spellType="hot",manaCost=335,castTime=0,cd=0,level=56,dotTotal=756,dotDuration=12,dotCoeff=0.8},
    S{name="Rejuvenation",rank=11,school=4,spellType="hot",manaCost=360,castTime=0,cd=0,level=60,dotTotal=1060,dotDuration=12,dotCoeff=0.8},

    -- TRANQUILITY (AoE channeled heal, 5min cooldown)
    S{name="Tranquility",rank=1,school=4,spellType="ch_heal",minDmg=490,maxDmg=490,manaCost=475,castTime=10.0,hpCoeff=0.333,cd=300,level=30,isAoE=true},
    S{name="Tranquility",rank=2,school=4,spellType="ch_heal",minDmg=930,maxDmg=930,manaCost=695,castTime=10.0,hpCoeff=0.333,cd=300,level=40,isAoE=true},
    S{name="Tranquility",rank=3,school=4,spellType="ch_heal",minDmg=1668,maxDmg=1668,manaCost=925,castTime=10.0,hpCoeff=0.333,cd=300,level=50,isAoE=true},
    S{name="Tranquility",rank=4,school=4,spellType="ch_heal",minDmg=3108,maxDmg=3108,manaCost=1175,castTime=10.0,hpCoeff=0.333,cd=300,level=60,isAoE=true},
}

-- ============================================================================
-- SHAMAN
-- ============================================================================
SPELLCALC_SPELLS["SHAMAN"] = {
    -- LIGHTNING BOLT
    S{name="Lightning Bolt",rank=1,school=4,spellType="damage",minDmg=13,maxDmg=15,manaCost=15,castTime=1.5,spCoeff=0.123,cd=0,level=1},
    S{name="Lightning Bolt",rank=2,school=4,spellType="damage",minDmg=26,maxDmg=31,manaCost=30,castTime=2.0,spCoeff=0.314,cd=0,level=8},
    S{name="Lightning Bolt",rank=3,school=4,spellType="damage",minDmg=47,maxDmg=54,manaCost=45,castTime=2.5,spCoeff=0.554,cd=0,level=14},
    S{name="Lightning Bolt",rank=4,school=4,spellType="damage",minDmg=88,maxDmg=98,manaCost=75,castTime=3.0,spCoeff=0.857,cd=0,level=20},
    S{name="Lightning Bolt",rank=5,school=4,spellType="damage",minDmg=131,maxDmg=148,manaCost=105,castTime=3.0,spCoeff=0.857,cd=0,level=26},
    S{name="Lightning Bolt",rank=6,school=4,spellType="damage",minDmg=186,maxDmg=210,manaCost=135,castTime=3.0,spCoeff=0.857,cd=0,level=32},
    S{name="Lightning Bolt",rank=7,school=4,spellType="damage",minDmg=248,maxDmg=280,manaCost=170,castTime=3.0,spCoeff=0.857,cd=0,level=38},
    S{name="Lightning Bolt",rank=8,school=4,spellType="damage",minDmg=315,maxDmg=355,manaCost=205,castTime=3.0,spCoeff=0.857,cd=0,level=44},
    S{name="Lightning Bolt",rank=9,school=4,spellType="damage",minDmg=399,maxDmg=449,manaCost=230,castTime=3.0,spCoeff=0.857,cd=0,level=50},
    S{name="Lightning Bolt",rank=10,school=4,spellType="damage",minDmg=563,maxDmg=643,manaCost=265,castTime=3.0,spCoeff=0.857,cd=0,level=56},

    -- CHAIN LIGHTNING (6s cooldown)
    S{name="Chain Lightning",rank=1,school=4,spellType="damage",minDmg=200,maxDmg=227,manaCost=280,castTime=2.5,spCoeff=0.714,cd=6,level=32},
    S{name="Chain Lightning",rank=2,school=4,spellType="damage",minDmg=281,maxDmg=320,manaCost=350,castTime=2.5,spCoeff=0.714,cd=6,level=40},
    S{name="Chain Lightning",rank=3,school=4,spellType="damage",minDmg=383,maxDmg=431,manaCost=405,castTime=2.5,spCoeff=0.714,cd=6,level=48},
    S{name="Chain Lightning",rank=4,school=4,spellType="damage",minDmg=493,maxDmg=551,manaCost=440,castTime=2.5,spCoeff=0.714,cd=6,level=56},

    -- EARTH SHOCK (6s shared cooldown)
    S{name="Earth Shock",rank=1,school=4,spellType="damage",minDmg=19,maxDmg=22,manaCost=30,castTime=0,spCoeff=0.386,cd=6,level=4},
    S{name="Earth Shock",rank=2,school=4,spellType="damage",minDmg=34,maxDmg=38,manaCost=50,castTime=0,spCoeff=0.386,cd=6,level=8},
    S{name="Earth Shock",rank=3,school=4,spellType="damage",minDmg=60,maxDmg=65,manaCost=85,castTime=0,spCoeff=0.386,cd=6,level=14},
    S{name="Earth Shock",rank=4,school=4,spellType="damage",minDmg=119,maxDmg=127,manaCost=145,castTime=0,spCoeff=0.386,cd=6,level=24},
    S{name="Earth Shock",rank=5,school=4,spellType="damage",minDmg=225,maxDmg=237,manaCost=210,castTime=0,spCoeff=0.386,cd=6,level=36},
    S{name="Earth Shock",rank=6,school=4,spellType="damage",minDmg=359,maxDmg=381,manaCost=270,castTime=0,spCoeff=0.386,cd=6,level=48},
    S{name="Earth Shock",rank=7,school=4,spellType="damage",minDmg=517,maxDmg=545,manaCost=345,castTime=0,spCoeff=0.386,cd=6,level=60},

    -- FLAME SHOCK (dd+dot, 6s shared cooldown)
    S{name="Flame Shock",rank=1,school=3,spellType="dd+dot",minDmg=21,maxDmg=21,manaCost=55,castTime=0,spCoeff=0.214,cd=6,level=10,dotTotal=28,dotDuration=12,dotCoeff=0.52},
    S{name="Flame Shock",rank=2,school=3,spellType="dd+dot",minDmg=51,maxDmg=51,manaCost=95,castTime=0,spCoeff=0.214,cd=6,level=18,dotTotal=60,dotDuration=12,dotCoeff=0.52},
    S{name="Flame Shock",rank=3,school=3,spellType="dd+dot",minDmg=95,maxDmg=95,manaCost=160,castTime=0,spCoeff=0.214,cd=6,level=28,dotTotal=120,dotDuration=12,dotCoeff=0.52},
    S{name="Flame Shock",rank=4,school=3,spellType="dd+dot",minDmg=164,maxDmg=164,manaCost=240,castTime=0,spCoeff=0.214,cd=6,level=40,dotTotal=224,dotDuration=12,dotCoeff=0.52},
    S{name="Flame Shock",rank=5,school=3,spellType="dd+dot",minDmg=292,maxDmg=292,manaCost=345,castTime=0,spCoeff=0.214,cd=6,level=52,dotTotal=420,dotDuration=12,dotCoeff=0.52},

    -- FROST SHOCK (6s shared cooldown)
    S{name="Frost Shock",rank=1,school=5,spellType="damage",minDmg=89,maxDmg=95,manaCost=115,castTime=0,spCoeff=0.386,cd=6,level=20},
    S{name="Frost Shock",rank=2,school=5,spellType="damage",minDmg=151,maxDmg=163,manaCost=165,castTime=0,spCoeff=0.386,cd=6,level=34},
    S{name="Frost Shock",rank=3,school=5,spellType="damage",minDmg=230,maxDmg=246,manaCost=215,castTime=0,spCoeff=0.386,cd=6,level=46},
    S{name="Frost Shock",rank=4,school=5,spellType="damage",minDmg=333,maxDmg=353,manaCost=285,castTime=0,spCoeff=0.386,cd=6,level=58},

    -- HEALING WAVE
    S{name="Healing Wave",rank=1,school=4,spellType="heal",minDmg=34,maxDmg=44,manaCost=25,castTime=1.5,hpCoeff=0.123,cd=0,level=1},
    S{name="Healing Wave",rank=2,school=4,spellType="heal",minDmg=64,maxDmg=78,manaCost=45,castTime=2.0,hpCoeff=0.271,cd=0,level=6},
    S{name="Healing Wave",rank=3,school=4,spellType="heal",minDmg=129,maxDmg=155,manaCost=80,castTime=2.5,hpCoeff=0.554,cd=0,level=12},
    S{name="Healing Wave",rank=4,school=4,spellType="heal",minDmg=268,maxDmg=316,manaCost=155,castTime=3.0,hpCoeff=0.857,cd=0,level=18},
    S{name="Healing Wave",rank=5,school=4,spellType="heal",minDmg=389,maxDmg=454,manaCost=200,castTime=3.0,hpCoeff=0.857,cd=0,level=24},
    S{name="Healing Wave",rank=6,school=4,spellType="heal",minDmg=552,maxDmg=639,manaCost=265,castTime=3.0,hpCoeff=0.857,cd=0,level=32},
    S{name="Healing Wave",rank=7,school=4,spellType="heal",minDmg=759,maxDmg=874,manaCost=340,castTime=3.0,hpCoeff=0.857,cd=0,level=40},
    S{name="Healing Wave",rank=8,school=4,spellType="heal",minDmg=1017,maxDmg=1167,manaCost=440,castTime=3.0,hpCoeff=0.857,cd=0,level=48},
    S{name="Healing Wave",rank=9,school=4,spellType="heal",minDmg=1367,maxDmg=1561,manaCost=560,castTime=3.0,hpCoeff=0.857,cd=0,level=56},
    S{name="Healing Wave",rank=10,school=4,spellType="heal",minDmg=1620,maxDmg=1850,manaCost=620,castTime=3.0,hpCoeff=0.857,cd=0,level=60},

    -- LESSER HEALING WAVE
    S{name="Lesser Healing Wave",rank=1,school=4,spellType="heal",minDmg=162,maxDmg=186,manaCost=105,castTime=1.5,hpCoeff=0.429,cd=0,level=20},
    S{name="Lesser Healing Wave",rank=2,school=4,spellType="heal",minDmg=247,maxDmg=281,manaCost=145,castTime=1.5,hpCoeff=0.429,cd=0,level=28},
    S{name="Lesser Healing Wave",rank=3,school=4,spellType="heal",minDmg=337,maxDmg=383,manaCost=185,castTime=1.5,hpCoeff=0.429,cd=0,level=36},
    S{name="Lesser Healing Wave",rank=4,school=4,spellType="heal",minDmg=458,maxDmg=514,manaCost=235,castTime=1.5,hpCoeff=0.429,cd=0,level=44},
    S{name="Lesser Healing Wave",rank=5,school=4,spellType="heal",minDmg=538,maxDmg=608,manaCost=265,castTime=1.5,hpCoeff=0.429,cd=0,level=52},
    S{name="Lesser Healing Wave",rank=6,school=4,spellType="heal",minDmg=649,maxDmg=735,manaCost=290,castTime=1.5,hpCoeff=0.429,cd=0,level=60},

    -- CHAIN HEAL
    S{name="Chain Heal",rank=1,school=4,spellType="heal",minDmg=332,maxDmg=381,manaCost=260,castTime=2.5,hpCoeff=0.714,cd=0,level=40},
    S{name="Chain Heal",rank=2,school=4,spellType="heal",minDmg=650,maxDmg=748,manaCost=315,castTime=2.5,hpCoeff=0.714,cd=0,level=50},
    S{name="Chain Heal",rank=3,school=4,spellType="heal",minDmg=1055,maxDmg=1205,manaCost=405,castTime=2.5,hpCoeff=0.714,cd=0,level=60},
}

-- ============================================================================
-- PALADIN
-- ============================================================================
SPELLCALC_SPELLS["PALADIN"] = {
    -- HOLY SHOCK (damage, 30s cooldown)
    S{name="Holy Shock",rank=1,school=2,spellType="damage",minDmg=204,maxDmg=220,manaCost=225,castTime=0,spCoeff=0.429,cd=30,level=40},
    S{name="Holy Shock",rank=2,school=2,spellType="damage",minDmg=279,maxDmg=301,manaCost=275,castTime=0,spCoeff=0.429,cd=30,level=48},
    S{name="Holy Shock",rank=3,school=2,spellType="damage",minDmg=365,maxDmg=395,manaCost=325,castTime=0,spCoeff=0.429,cd=30,level=56},

    -- HOLY SHOCK (heal version, 30s cooldown shared)
    S{name="Holy Shock (Heal)",rank=1,school=2,spellType="heal",minDmg=204,maxDmg=220,manaCost=225,castTime=0,hpCoeff=0.429,cd=30,level=40},
    S{name="Holy Shock (Heal)",rank=2,school=2,spellType="heal",minDmg=279,maxDmg=301,manaCost=275,castTime=0,hpCoeff=0.429,cd=30,level=48},
    S{name="Holy Shock (Heal)",rank=3,school=2,spellType="heal",minDmg=365,maxDmg=395,manaCost=325,castTime=0,hpCoeff=0.429,cd=30,level=56},

    -- CONSECRATION (DoT-like AoE, 8s cooldown)
    S{name="Consecration",rank=1,school=2,spellType="dot",manaCost=135,castTime=0,cd=8,level=20,dotTotal=64,dotDuration=8,dotCoeff=0.533,isAoE=true},
    S{name="Consecration",rank=2,school=2,spellType="dot",manaCost=235,castTime=0,cd=8,level=30,dotTotal=120,dotDuration=8,dotCoeff=0.533,isAoE=true},
    S{name="Consecration",rank=3,school=2,spellType="dot",manaCost=320,castTime=0,cd=8,level=40,dotTotal=192,dotDuration=8,dotCoeff=0.533,isAoE=true},
    S{name="Consecration",rank=4,school=2,spellType="dot",manaCost=435,castTime=0,cd=8,level=50,dotTotal=280,dotDuration=8,dotCoeff=0.533,isAoE=true},
    S{name="Consecration",rank=5,school=2,spellType="dot",manaCost=565,castTime=0,cd=8,level=60,dotTotal=384,dotDuration=8,dotCoeff=0.533,isAoE=true},

    -- EXORCISM (no cooldown, Undead/Demon only)
    S{name="Exorcism",rank=1,school=2,spellType="damage",minDmg=84,maxDmg=96,manaCost=85,castTime=1.5,spCoeff=0.429,cd=0,level=20},
    S{name="Exorcism",rank=2,school=2,spellType="damage",minDmg=152,maxDmg=172,manaCost=135,castTime=1.5,spCoeff=0.429,cd=0,level=28},
    S{name="Exorcism",rank=3,school=2,spellType="damage",minDmg=217,maxDmg=245,manaCost=180,castTime=1.5,spCoeff=0.429,cd=0,level=36},
    S{name="Exorcism",rank=4,school=2,spellType="damage",minDmg=304,maxDmg=342,manaCost=235,castTime=1.5,spCoeff=0.429,cd=0,level=44},
    S{name="Exorcism",rank=5,school=2,spellType="damage",minDmg=393,maxDmg=439,manaCost=260,castTime=1.5,spCoeff=0.429,cd=0,level=52},
    S{name="Exorcism",rank=6,school=2,spellType="damage",minDmg=505,maxDmg=563,manaCost=295,castTime=1.5,spCoeff=0.429,cd=0,level=60},

    -- HAMMER OF WRATH (6s cooldown, target below 20%)
    S{name="Hammer of Wrath",rank=1,school=2,spellType="damage",minDmg=304,maxDmg=336,manaCost=295,castTime=1.0,spCoeff=0.286,cd=6,level=44},
    S{name="Hammer of Wrath",rank=2,school=2,spellType="damage",minDmg=398,maxDmg=438,manaCost=360,castTime=1.0,spCoeff=0.286,cd=6,level=52},
    S{name="Hammer of Wrath",rank=3,school=2,spellType="damage",minDmg=504,maxDmg=556,manaCost=425,castTime=1.0,spCoeff=0.286,cd=6,level=60},

    -- FLASH OF LIGHT
    S{name="Flash of Light",rank=1,school=2,spellType="heal",minDmg=62,maxDmg=73,manaCost=35,castTime=1.5,hpCoeff=0.429,cd=0,level=20},
    S{name="Flash of Light",rank=2,school=2,spellType="heal",minDmg=96,maxDmg=110,manaCost=50,castTime=1.5,hpCoeff=0.429,cd=0,level=26},
    S{name="Flash of Light",rank=3,school=2,spellType="heal",minDmg=143,maxDmg=163,manaCost=70,castTime=1.5,hpCoeff=0.429,cd=0,level=34},
    S{name="Flash of Light",rank=4,school=2,spellType="heal",minDmg=197,maxDmg=222,manaCost=90,castTime=1.5,hpCoeff=0.429,cd=0,level=42},
    S{name="Flash of Light",rank=5,school=2,spellType="heal",minDmg=267,maxDmg=299,manaCost=115,castTime=1.5,hpCoeff=0.429,cd=0,level=50},
    S{name="Flash of Light",rank=6,school=2,spellType="heal",minDmg=448,maxDmg=503,manaCost=180,castTime=1.5,hpCoeff=0.429,cd=0,level=58},

    -- HOLY LIGHT
    S{name="Holy Light",rank=1,school=2,spellType="heal",minDmg=39,maxDmg=47,manaCost=35,castTime=2.5,hpCoeff=0.229,cd=0,level=1},
    S{name="Holy Light",rank=2,school=2,spellType="heal",minDmg=76,maxDmg=90,manaCost=60,castTime=2.5,hpCoeff=0.343,cd=0,level=6},
    S{name="Holy Light",rank=3,school=2,spellType="heal",minDmg=159,maxDmg=187,manaCost=110,castTime=2.5,hpCoeff=0.554,cd=0,level=14},
    S{name="Holy Light",rank=4,school=2,spellType="heal",minDmg=310,maxDmg=356,manaCost=190,castTime=2.5,hpCoeff=0.714,cd=0,level=22},
    S{name="Holy Light",rank=5,school=2,spellType="heal",minDmg=491,maxDmg=557,manaCost=275,castTime=2.5,hpCoeff=0.714,cd=0,level=30},
    S{name="Holy Light",rank=6,school=2,spellType="heal",minDmg=698,maxDmg=780,manaCost=365,castTime=2.5,hpCoeff=0.714,cd=0,level=38},
    S{name="Holy Light",rank=7,school=2,spellType="heal",minDmg=945,maxDmg=1053,manaCost=465,castTime=2.5,hpCoeff=0.714,cd=0,level=46},
    S{name="Holy Light",rank=8,school=2,spellType="heal",minDmg=1246,maxDmg=1388,manaCost=580,castTime=2.5,hpCoeff=0.714,cd=0,level=54},
    S{name="Holy Light",rank=9,school=2,spellType="heal",minDmg=1777,maxDmg=1978,manaCost=660,castTime=2.5,hpCoeff=0.714,cd=0,level=60},
}


-- ============================================================================
-- TALENT MODIFIERS
-- ============================================================================

SPELLCALC_TALENTS = {}

SPELLCALC_TALENTS["MAGE"] = {
    { name="Fire Power",         perRank=0.02, maxRank=5, affectType="damage", affectSchool={3} },
    { name="Piercing Ice",       perRank=0.02, maxRank=5, affectType="damage", affectSchool={5} },
    { name="Arcane Instability", perRank=0.01, maxRank=3, affectType="damage", affectSchool="all" },
}

SPELLCALC_TALENTS["PRIEST"] = {
    { name="Darkness",           perRank=0.02, maxRank=5, affectType="damage", affectSchool={6} },
    { name="Shadowform",         perRank=0.15, maxRank=1, affectType="damage", affectSchool={6} },
    { name="Force of Will",      perRank=0.01, maxRank=5, affectType="damage", affectSchool="all" },
    { name="Searing Light",      perRank=0.05, maxRank=2, affectType="damage", affectSpells={"Smite","Holy Fire"} },
    { name="Spiritual Healing",  perRank=0.02, maxRank=5, affectType="healing", affectSchool="all" },
    { name="Improved Renew",     perRank=0.05, maxRank=3, affectType="healing", affectSpells={"Renew"} },
    -- [patch] Verbesserte Machtwort: Schild - +5% Absorb pro Rang
    { name="Improved Power Word: Shield", perRank=0.05, maxRank=3, affectType="healing", affectSpells={"Power Word: Shield"} },
}

SPELLCALC_TALENTS["WARLOCK"] = {
    { name="Shadow Mastery",     perRank=0.02, maxRank=5, affectType="damage", affectSchool={6} },
    { name="Emberstorm",         perRank=0.02, maxRank=5, affectType="damage", affectSchool={3} },
}

SPELLCALC_TALENTS["DRUID"] = {
    { name="Moonfury",           perRank=0.02, maxRank=5, affectType="damage", affectSpells={"Wrath","Starfire","Moonfire"} },
    { name="Gift of Nature",     perRank=0.02, maxRank=5, affectType="healing", affectSchool="all" },
    { name="Improved Rejuvenation", perRank=0.05, maxRank=3, affectType="healing", affectSpells={"Rejuvenation"} },
}

SPELLCALC_TALENTS["SHAMAN"] = {
    { name="Concussion",         perRank=0.01, maxRank=5, affectType="damage",
      affectSpells={"Lightning Bolt","Chain Lightning","Earth Shock","Flame Shock","Frost Shock"} },
    { name="Call of Flame",      perRank=0.05, maxRank=3, affectType="damage", affectSpells={"Flame Shock"} },
    { name="Purification",       perRank=0.02, maxRank=5, affectType="healing", affectSchool="all" },
}

SPELLCALC_TALENTS["PALADIN"] = {
    { name="Healing Light",      perRank=0.04, maxRank=3, affectType="healing",
      affectSpells={"Flash of Light","Holy Light","Holy Shock (Heal)"} },
}
