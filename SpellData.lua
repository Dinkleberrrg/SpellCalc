-- SpellCalc Spell & Talent Database
-- Schools: 2=Holy, 3=Fire, 4=Nature, 5=Frost, 6=Shadow, 7=Arcane
-- spellType: "damage", "heal", "dot", "hot", "dd+dot", "dd+hot", "ch_dmg", "ch_heal"
-- cd = cooldown in seconds (0 = no cooldown)
--
-- [patch] Zauberdaten automatisch aus dem OctoWoW-Client erzeugt
-- (Spell.dbc aus patch-O.mpq, SkillLineAbility.dbc, Stand 2026-10-02).
-- Werte, Mana, Zauberzeit, Cooldown, Dauer und Lernlevel stammen 1:1 aus
-- dem Client. id = Zauber-ID im Client.
-- Koeffizienten stehen NICHT im Client (serverseitig). Sie basieren auf den
-- bekannten Classic-Werten des hoechsten Rangs, werden je Rang ueber
-- Zauberzeit bzw. Dauer skaliert und enthalten den Abzug fuer Zauber unter
-- Level 20 (x(1 - (20 - Level) * 0.0375)). "geschaetzt" = OctoWoW-eigene
-- Zauber oder geaenderte Dauer, ohne bekannten Referenzwert.
-- manaPct = Kosten in Prozent des Grundmanas (statt manaCost).
-- Kanalisierte Zauber: minDmg/maxDmg = Gesamtwert, castTime = Kanaldauer.

SPELLCALC_SCHOOLS = {
    [2] = { name = "Holy",   color = {1.0, 0.9, 0.0} },
    [3] = { name = "Fire",   color = {1.0, 0.3, 0.0} },
    [4] = { name = "Nature", color = {0.2, 0.9, 0.2} },
    [5] = { name = "Frost",  color = {0.2, 0.7, 1.0} },
    [6] = { name = "Shadow", color = {0.6, 0.2, 0.9} },
    [7] = { name = "Arcane", color = {1.0, 0.4, 1.0} },
}
SPELLCALC_SCHOOL_HEAL = { name = "Heal", color = {0.2, 1.0, 0.4} }

local function S(t) return t end

SPELLCALC_SPELLS = {}

-- ============================================================================
-- MAGE
-- ============================================================================
SPELLCALC_SPELLS["MAGE"] = {
    -- FROSTBOLT
    S{name="Frostbolt",rank=1,school=5,spellType="damage",minDmg=18,maxDmg=20,manaCost=25,castTime=1.5,spCoeff=0.163,cd=0,level=4,id=116},
    S{name="Frostbolt",rank=2,school=5,spellType="damage",minDmg=31,maxDmg=35,manaCost=35,castTime=1.8,spCoeff=0.269,cd=0,level=8,id=205},
    S{name="Frostbolt",rank=3,school=5,spellType="damage",minDmg=51,maxDmg=57,manaCost=50,castTime=2.2,spCoeff=0.463,cd=0,level=14,id=837},
    S{name="Frostbolt",rank=4,school=5,spellType="damage",minDmg=74,maxDmg=82,manaCost=65,castTime=2.6,spCoeff=0.705,cd=0,level=20,id=7322},
    S{name="Frostbolt",rank=5,school=5,spellType="damage",minDmg=126,maxDmg=138,manaCost=100,castTime=3,spCoeff=0.814,cd=0,level=26,id=8406},
    S{name="Frostbolt",rank=6,school=5,spellType="damage",minDmg=174,maxDmg=190,manaCost=130,castTime=3,spCoeff=0.814,cd=0,level=32,id=8407},
    S{name="Frostbolt",rank=7,school=5,spellType="damage",minDmg=227,maxDmg=247,manaCost=160,castTime=3,spCoeff=0.814,cd=0,level=38,id=8408},
    S{name="Frostbolt",rank=8,school=5,spellType="damage",minDmg=292,maxDmg=316,manaCost=195,castTime=3,spCoeff=0.814,cd=0,level=44,id=10179},
    S{name="Frostbolt",rank=9,school=5,spellType="damage",minDmg=353,maxDmg=383,manaCost=225,castTime=3,spCoeff=0.814,cd=0,level=50,id=10180},
    S{name="Frostbolt",rank=10,school=5,spellType="damage",minDmg=429,maxDmg=463,manaCost=260,castTime=3,spCoeff=0.814,cd=0,level=56,id=10181},
    S{name="Frostbolt",rank=11,school=5,spellType="damage",minDmg=515,maxDmg=555,manaCost=290,castTime=3,spCoeff=0.814,cd=0,level=60,id=25304},

    -- FIREBALL
    S{name="Fireball",rank=1,school=3,spellType="dd+dot",minDmg=14,maxDmg=22,manaCost=30,castTime=1.5,spCoeff=0.123,dotTotal=2,dotDuration=4,dotCoeff=0,cd=0,level=1,id=133},
    S{name="Fireball",rank=2,school=3,spellType="dd+dot",minDmg=31,maxDmg=45,manaCost=45,castTime=2,spCoeff=0.271,dotTotal=3,dotDuration=6,dotCoeff=0,cd=0,level=6,id=143},
    S{name="Fireball",rank=3,school=3,spellType="dd+dot",minDmg=53,maxDmg=73,manaCost=60,castTime=2.5,spCoeff=0.5,dotTotal=6,dotDuration=6,dotCoeff=0,cd=0,level=12,id=145},
    S{name="Fireball",rank=4,school=3,spellType="dd+dot",minDmg=84,maxDmg=116,manaCost=85,castTime=3,spCoeff=0.793,dotTotal=12,dotDuration=8,dotCoeff=0,cd=0,level=18,id=3140},
    S{name="Fireball",rank=5,school=3,spellType="dd+dot",minDmg=139,maxDmg=187,manaCost=120,castTime=3.5,spCoeff=1,dotTotal=20,dotDuration=8,dotCoeff=0,cd=0,level=24,id=8400},
    S{name="Fireball",rank=6,school=3,spellType="dd+dot",minDmg=199,maxDmg=265,manaCost=160,castTime=3.5,spCoeff=1,dotTotal=28,dotDuration=8,dotCoeff=0,cd=0,level=30,id=8401},
    S{name="Fireball",rank=7,school=3,spellType="dd+dot",minDmg=255,maxDmg=335,manaCost=190,castTime=3.5,spCoeff=1,dotTotal=32,dotDuration=8,dotCoeff=0,cd=0,level=36,id=8402},
    S{name="Fireball",rank=8,school=3,spellType="dd+dot",minDmg=318,maxDmg=414,manaCost=220,castTime=3.5,spCoeff=1,dotTotal=40,dotDuration=8,dotCoeff=0,cd=0,level=42,id=10148},
    S{name="Fireball",rank=9,school=3,spellType="dd+dot",minDmg=392,maxDmg=506,manaCost=245,castTime=3.5,spCoeff=1,dotTotal=52,dotDuration=8,dotCoeff=0,cd=0,level=48,id=10149},
    S{name="Fireball",rank=10,school=3,spellType="dd+dot",minDmg=475,maxDmg=609,manaCost=265,castTime=3.5,spCoeff=1,dotTotal=60,dotDuration=8,dotCoeff=0,cd=0,level=54,id=10150},
    S{name="Fireball",rank=11,school=3,spellType="dd+dot",minDmg=561,maxDmg=715,manaCost=275,castTime=3.5,spCoeff=1,dotTotal=72,dotDuration=8,dotCoeff=0,cd=0,level=60,id=10151},
    S{name="Fireball",rank=12,school=3,spellType="dd+dot",minDmg=596,maxDmg=760,manaCost=295,castTime=3.5,spCoeff=1,dotTotal=76,dotDuration=8,dotCoeff=0,cd=0,level=60,id=25306},

    -- FIRE BLAST
    S{name="Fire Blast",rank=1,school=3,spellType="damage",minDmg=24,maxDmg=32,manaCost=40,castTime=0,spCoeff=0.204,cd=8,level=6,id=2136},
    S{name="Fire Blast",rank=2,school=3,spellType="damage",minDmg=57,maxDmg=71,manaCost=75,castTime=0,spCoeff=0.332,cd=8,level=14,id=2137},
    S{name="Fire Blast",rank=3,school=3,spellType="damage",minDmg=103,maxDmg=127,manaCost=115,castTime=0,spCoeff=0.429,cd=8,level=22,id=2138},
    S{name="Fire Blast",rank=4,school=3,spellType="damage",minDmg=168,maxDmg=202,manaCost=165,castTime=0,spCoeff=0.429,cd=8,level=30,id=8412},
    S{name="Fire Blast",rank=5,school=3,spellType="damage",minDmg=242,maxDmg=290,manaCost=220,castTime=0,spCoeff=0.429,cd=8,level=38,id=8413},
    S{name="Fire Blast",rank=6,school=3,spellType="damage",minDmg=332,maxDmg=394,manaCost=280,castTime=0,spCoeff=0.429,cd=8,level=46,id=10197},
    S{name="Fire Blast",rank=7,school=3,spellType="damage",minDmg=431,maxDmg=509,manaCost=340,castTime=0,spCoeff=0.429,cd=8,level=54,id=10199},

    -- SCORCH
    S{name="Scorch",rank=1,school=3,spellType="damage",minDmg=53,maxDmg=65,manaCost=50,castTime=1.5,spCoeff=0.429,cd=0,level=22,id=2948},
    S{name="Scorch",rank=2,school=3,spellType="damage",minDmg=77,maxDmg=93,manaCost=65,castTime=1.5,spCoeff=0.429,cd=0,level=28,id=8444},
    S{name="Scorch",rank=3,school=3,spellType="damage",minDmg=100,maxDmg=120,manaCost=80,castTime=1.5,spCoeff=0.429,cd=0,level=34,id=8445},
    S{name="Scorch",rank=4,school=3,spellType="damage",minDmg=133,maxDmg=159,manaCost=100,castTime=1.5,spCoeff=0.429,cd=0,level=40,id=8446},
    S{name="Scorch",rank=5,school=3,spellType="damage",minDmg=162,maxDmg=192,manaCost=115,castTime=1.5,spCoeff=0.429,cd=0,level=46,id=10205},
    S{name="Scorch",rank=6,school=3,spellType="damage",minDmg=200,maxDmg=239,manaCost=135,castTime=1.5,spCoeff=0.429,cd=0,level=52,id=10206},
    S{name="Scorch",rank=7,school=3,spellType="damage",minDmg=233,maxDmg=275,manaCost=150,castTime=1.5,spCoeff=0.429,cd=0,level=58,id=10207},

    -- PYROBLAST
    S{name="Pyroblast",rank=1,school=3,spellType="dd+dot",minDmg=141,maxDmg=187,manaCost=125,castTime=6,spCoeff=1,dotTotal=56,dotDuration=12,dotCoeff=0.15,cd=0,level=20,id=11366},
    S{name="Pyroblast",rank=2,school=3,spellType="dd+dot",minDmg=180,maxDmg=236,manaCost=150,castTime=6,spCoeff=1,dotTotal=72,dotDuration=12,dotCoeff=0.15,cd=0,level=24,id=12505},
    S{name="Pyroblast",rank=3,school=3,spellType="dd+dot",minDmg=255,maxDmg=327,manaCost=195,castTime=6,spCoeff=1,dotTotal=96,dotDuration=12,dotCoeff=0.15,cd=0,level=30,id=12522},
    S{name="Pyroblast",rank=4,school=3,spellType="dd+dot",minDmg=329,maxDmg=419,manaCost=240,castTime=6,spCoeff=1,dotTotal=124,dotDuration=12,dotCoeff=0.15,cd=0,level=36,id=12523},
    S{name="Pyroblast",rank=5,school=3,spellType="dd+dot",minDmg=407,maxDmg=515,manaCost=285,castTime=6,spCoeff=1,dotTotal=156,dotDuration=12,dotCoeff=0.15,cd=0,level=42,id=12524},
    S{name="Pyroblast",rank=6,school=3,spellType="dd+dot",minDmg=503,maxDmg=631,manaCost=335,castTime=6,spCoeff=1,dotTotal=188,dotDuration=12,dotCoeff=0.15,cd=0,level=48,id=12525},
    S{name="Pyroblast",rank=7,school=3,spellType="dd+dot",minDmg=600,maxDmg=750,manaCost=385,castTime=6,spCoeff=1,dotTotal=228,dotDuration=12,dotCoeff=0.15,cd=0,level=54,id=12526},
    S{name="Pyroblast",rank=8,school=3,spellType="dd+dot",minDmg=716,maxDmg=890,manaCost=440,castTime=6,spCoeff=1,dotTotal=268,dotDuration=12,dotCoeff=0.15,cd=0,level=60,id=18809},

    -- FLAMESTRIKE
    S{name="Flamestrike",rank=1,school=3,spellType="dd+dot",minDmg=52,maxDmg=68,manaCost=195,castTime=2.5,spCoeff=0.233,dotTotal=48,dotDuration=8,dotCoeff=0.033,cd=0,level=16,isAoE=true,id=2120},
    S{name="Flamestrike",rank=2,school=3,spellType="dd+dot",minDmg=96,maxDmg=122,manaCost=250,castTime=2.5,spCoeff=0.274,dotTotal=88,dotDuration=8,dotCoeff=0.039,cd=0,level=24,isAoE=true,id=2121},
    S{name="Flamestrike",rank=3,school=3,spellType="dd+dot",minDmg=154,maxDmg=192,manaCost=360,castTime=2.5,spCoeff=0.274,dotTotal=140,dotDuration=8,dotCoeff=0.039,cd=0,level=32,isAoE=true,id=8422},
    S{name="Flamestrike",rank=4,school=3,spellType="dd+dot",minDmg=220,maxDmg=272,manaCost=470,castTime=2.5,spCoeff=0.274,dotTotal=196,dotDuration=8,dotCoeff=0.039,cd=0,level=40,isAoE=true,id=8423},
    S{name="Flamestrike",rank=5,school=3,spellType="dd+dot",minDmg=291,maxDmg=359,manaCost=580,castTime=2.5,spCoeff=0.274,dotTotal=264,dotDuration=8,dotCoeff=0.039,cd=0,level=48,isAoE=true,id=10215},
    S{name="Flamestrike",rank=6,school=3,spellType="dd+dot",minDmg=375,maxDmg=459,manaCost=680,castTime=2.5,spCoeff=0.274,dotTotal=340,dotDuration=8,dotCoeff=0.039,cd=0,level=56,isAoE=true,id=10216},

    -- BLAST WAVE
    S{name="Blast Wave",rank=1,school=3,spellType="damage",minDmg=154,maxDmg=186,manaCost=215,castTime=0,spCoeff=0.136,cd=30,level=30,isAoE=true,id=11113},
    S{name="Blast Wave",rank=2,school=3,spellType="damage",minDmg=201,maxDmg=241,manaCost=270,castTime=0,spCoeff=0.136,cd=30,level=36,isAoE=true,id=13018},
    S{name="Blast Wave",rank=3,school=3,spellType="damage",minDmg=277,maxDmg=329,manaCost=355,castTime=0,spCoeff=0.136,cd=30,level=44,isAoE=true,id=13019},
    S{name="Blast Wave",rank=4,school=3,spellType="damage",minDmg=365,maxDmg=433,manaCost=450,castTime=0,spCoeff=0.136,cd=30,level=52,isAoE=true,id=13020},
    S{name="Blast Wave",rank=5,school=3,spellType="damage",minDmg=462,maxDmg=544,manaCost=545,castTime=0,spCoeff=0.136,cd=30,level=60,isAoE=true,id=13021},

    -- CONE OF COLD
    S{name="Cone of Cold",rank=1,school=5,spellType="damage",minDmg=98,maxDmg=108,manaCost=210,castTime=0,spCoeff=0.129,cd=10,level=26,isAoE=true,id=120},
    S{name="Cone of Cold",rank=2,school=5,spellType="damage",minDmg=146,maxDmg=160,manaCost=290,castTime=0,spCoeff=0.129,cd=10,level=34,isAoE=true,id=8492},
    S{name="Cone of Cold",rank=3,school=5,spellType="damage",minDmg=203,maxDmg=223,manaCost=380,castTime=0,spCoeff=0.129,cd=10,level=42,isAoE=true,id=10159},
    S{name="Cone of Cold",rank=4,school=5,spellType="damage",minDmg=264,maxDmg=290,manaCost=465,castTime=0,spCoeff=0.129,cd=10,level=50,isAoE=true,id=10160},
    S{name="Cone of Cold",rank=5,school=5,spellType="damage",minDmg=335,maxDmg=365,manaCost=555,castTime=0,spCoeff=0.129,cd=10,level=58,isAoE=true,id=10161},

    -- FROST NOVA
    S{name="Frost Nova",rank=1,school=5,spellType="damage",minDmg=19,maxDmg=21,manaCost=55,castTime=0,spCoeff=0.02,cd=25,level=10,isAoE=true,id=122},
    S{name="Frost Nova",rank=2,school=5,spellType="damage",minDmg=33,maxDmg=37,manaCost=85,castTime=0,spCoeff=0.032,cd=25,level=26,isAoE=true,id=865},
    S{name="Frost Nova",rank=3,school=5,spellType="damage",minDmg=52,maxDmg=58,manaCost=115,castTime=0,spCoeff=0.032,cd=25,level=40,isAoE=true,id=6131},
    S{name="Frost Nova",rank=4,school=5,spellType="damage",minDmg=71,maxDmg=79,manaCost=145,castTime=0,spCoeff=0.032,cd=25,level=54,isAoE=true,id=10230},

    -- ARCANE MISSILES
    S{name="Arcane Missiles",rank=1,school=7,spellType="ch_dmg",minDmg=72,maxDmg=72,manaCost=85,castTime=3,spCoeff=0.33,cd=0,level=8,id=5143},
    S{name="Arcane Missiles",rank=2,school=7,spellType="ch_dmg",minDmg=144,maxDmg=144,manaCost=140,castTime=4,spCoeff=0.68,cd=0,level=16,id=5144},
    S{name="Arcane Missiles",rank=3,school=7,spellType="ch_dmg",minDmg=280,maxDmg=280,manaCost=235,castTime=5,spCoeff=1,cd=0,level=24,id=5145},
    S{name="Arcane Missiles",rank=4,school=7,spellType="ch_dmg",minDmg=415,maxDmg=415,manaCost=320,castTime=5,spCoeff=1,cd=0,level=32,id=8416},
    S{name="Arcane Missiles",rank=5,school=7,spellType="ch_dmg",minDmg=575,maxDmg=575,manaCost=410,castTime=5,spCoeff=1,cd=0,level=40,id=8417},
    S{name="Arcane Missiles",rank=6,school=7,spellType="ch_dmg",minDmg=755,maxDmg=755,manaCost=500,castTime=5,spCoeff=1,cd=0,level=48,id=10211},
    S{name="Arcane Missiles",rank=7,school=7,spellType="ch_dmg",minDmg=960,maxDmg=960,manaCost=595,castTime=5,spCoeff=1,cd=0,level=56,id=10212},
    S{name="Arcane Missiles",rank=8,school=7,spellType="ch_dmg",minDmg=1150,maxDmg=1150,manaCost=655,castTime=5,spCoeff=1,cd=0,level=56,id=25345},

    -- ARCANE EXPLOSION
    S{name="Arcane Explosion",rank=1,school=7,spellType="damage",minDmg=32,maxDmg=36,manaCost=75,castTime=0,spCoeff=0.111,cd=0,level=14,isAoE=true,id=1449},
    S{name="Arcane Explosion",rank=2,school=7,spellType="damage",minDmg=57,maxDmg=63,manaCost=120,castTime=0,spCoeff=0.143,cd=0,level=22,isAoE=true,id=8437},
    S{name="Arcane Explosion",rank=3,school=7,spellType="damage",minDmg=97,maxDmg=105,manaCost=185,castTime=0,spCoeff=0.143,cd=0,level=30,isAoE=true,id=8438},
    S{name="Arcane Explosion",rank=4,school=7,spellType="damage",minDmg=139,maxDmg=151,manaCost=250,castTime=0,spCoeff=0.143,cd=0,level=38,isAoE=true,id=8439},
    S{name="Arcane Explosion",rank=5,school=7,spellType="damage",minDmg=186,maxDmg=202,manaCost=315,castTime=0,spCoeff=0.143,cd=0,level=46,isAoE=true,id=10201},
    S{name="Arcane Explosion",rank=6,school=7,spellType="damage",minDmg=243,maxDmg=263,manaCost=390,castTime=0,spCoeff=0.143,cd=0,level=54,isAoE=true,id=10202},

    -- ARCANE RUPTURE  (Koeffizient geschaetzt)
    S{name="Arcane Rupture",rank=1,school=7,spellType="damage",minDmg=101,maxDmg=114,manaCost=80,castTime=2.5,spCoeff=0.714,cd=15,level=20,id=51949},
    S{name="Arcane Rupture",rank=2,school=7,spellType="damage",minDmg=171,maxDmg=190,manaCost=145,castTime=2.5,spCoeff=0.714,cd=15,level=28,id=51950},
    S{name="Arcane Rupture",rank=3,school=7,spellType="damage",minDmg=302,maxDmg=333,manaCost=210,castTime=2.5,spCoeff=0.714,cd=15,level=36,id=51951},
    S{name="Arcane Rupture",rank=4,school=7,spellType="damage",minDmg=375,maxDmg=433,manaCost=270,castTime=2.5,spCoeff=0.714,cd=15,level=44,id=51952},
    S{name="Arcane Rupture",rank=5,school=7,spellType="damage",minDmg=528,maxDmg=576,manaCost=320,castTime=2.5,spCoeff=0.714,cd=15,level=52,id=51953},
    S{name="Arcane Rupture",rank=6,school=7,spellType="damage",minDmg=703,maxDmg=765,manaCost=390,castTime=2.5,spCoeff=0.714,cd=15,level=60,id=51954},

    -- ARCANE SURGE  (Koeffizient geschaetzt)
    S{name="Arcane Surge",rank=1,school=7,spellType="damage",minDmg=202,maxDmg=244,manaCost=85,castTime=0,spCoeff=0.429,cd=8,level=32,id=51933},
    S{name="Arcane Surge",rank=2,school=7,spellType="damage",minDmg=290,maxDmg=349,manaCost=110,castTime=0,spCoeff=0.429,cd=8,level=40,id=51934},
    S{name="Arcane Surge",rank=3,school=7,spellType="damage",minDmg=398,maxDmg=474,manaCost=140,castTime=0,spCoeff=0.429,cd=8,level=48,id=51935},
    S{name="Arcane Surge",rank=4,school=7,spellType="damage",minDmg=517,maxDmg=612,manaCost=170,castTime=0,spCoeff=0.429,cd=8,level=56,id=51936},

    -- BLIZZARD
    S{name="Blizzard",rank=1,school=5,spellType="ch_dmg",minDmg=200,maxDmg=200,manaCost=320,castTime=8,spCoeff=0.333,cd=0,level=20,isAoE=true,id=10},
    S{name="Blizzard",rank=2,school=5,spellType="ch_dmg",minDmg=352,maxDmg=352,manaCost=520,castTime=8,spCoeff=0.333,cd=0,level=28,isAoE=true,id=6141},
    S{name="Blizzard",rank=3,school=5,spellType="ch_dmg",minDmg=520,maxDmg=520,manaCost=720,castTime=8,spCoeff=0.333,cd=0,level=36,isAoE=true,id=8427},
    S{name="Blizzard",rank=4,school=5,spellType="ch_dmg",minDmg=720,maxDmg=720,manaCost=935,castTime=8,spCoeff=0.333,cd=0,level=44,isAoE=true,id=10185},
    S{name="Blizzard",rank=5,school=5,spellType="ch_dmg",minDmg=936,maxDmg=936,manaCost=1160,castTime=8,spCoeff=0.333,cd=0,level=52,isAoE=true,id=10186},
    S{name="Blizzard",rank=6,school=5,spellType="ch_dmg",minDmg=1192,maxDmg=1192,manaCost=1400,castTime=8,spCoeff=0.333,cd=0,level=60,isAoE=true,id=10187},
}

-- ============================================================================
-- PRIEST
-- ============================================================================
SPELLCALC_SPELLS["PRIEST"] = {
    -- SMITE
    S{name="Smite",rank=1,school=2,spellType="damage",minDmg=13,maxDmg=17,manaCost=20,castTime=1.5,spCoeff=0.123,cd=0,level=1,id=585},
    S{name="Smite",rank=2,school=2,spellType="damage",minDmg=25,maxDmg=31,manaCost=30,castTime=2,spCoeff=0.271,cd=0,level=6,id=591},
    S{name="Smite",rank=3,school=2,spellType="damage",minDmg=54,maxDmg=62,manaCost=40,castTime=2.5,spCoeff=0.553,cd=0,level=14,id=598},
    S{name="Smite",rank=4,school=2,spellType="damage",minDmg=91,maxDmg=105,manaCost=60,castTime=2.5,spCoeff=0.714,cd=0,level=22,id=984},
    S{name="Smite",rank=5,school=2,spellType="damage",minDmg=150,maxDmg=170,manaCost=105,castTime=2.5,spCoeff=0.714,cd=0,level=30,id=1004},
    S{name="Smite",rank=6,school=2,spellType="damage",minDmg=212,maxDmg=240,manaCost=135,castTime=2.5,spCoeff=0.714,cd=0,level=38,id=6060},
    S{name="Smite",rank=7,school=2,spellType="damage",minDmg=287,maxDmg=323,manaCost=165,castTime=2.5,spCoeff=0.714,cd=0,level=46,id=10933},
    S{name="Smite",rank=8,school=2,spellType="damage",minDmg=371,maxDmg=415,manaCost=210,castTime=2.5,spCoeff=0.714,cd=0,level=54,id=10934},
    S{name="Smite",rank=9,school=2,spellType="damage",minDmg=405,maxDmg=453,manaCost=225,castTime=2.5,spCoeff=0.714,cd=0,level=60,id=45968},

    -- HOLY FIRE
    S{name="Holy Fire",rank=1,school=2,spellType="dd+dot",minDmg=86,maxDmg=106,manaCost=85,castTime=3.5,spCoeff=0.75,dotTotal=35,dotDuration=10,dotCoeff=0.167,cd=0,level=20,id=14914},
    S{name="Holy Fire",rank=2,school=2,spellType="dd+dot",minDmg=106,maxDmg=130,manaCost=95,castTime=3.5,spCoeff=0.75,dotTotal=45,dotDuration=10,dotCoeff=0.167,cd=0,level=24,id=15262},
    S{name="Holy Fire",rank=3,school=2,spellType="dd+dot",minDmg=145,maxDmg=179,manaCost=125,castTime=3.5,spCoeff=0.75,dotTotal=60,dotDuration=10,dotCoeff=0.167,cd=0,level=30,id=15263},
    S{name="Holy Fire",rank=4,school=2,spellType="dd+dot",minDmg=181,maxDmg=225,manaCost=145,castTime=3.5,spCoeff=0.75,dotTotal=70,dotDuration=10,dotCoeff=0.167,cd=0,level=36,id=15264},
    S{name="Holy Fire",rank=5,school=2,spellType="dd+dot",minDmg=224,maxDmg=278,manaCost=170,castTime=3.5,spCoeff=0.75,dotTotal=95,dotDuration=10,dotCoeff=0.167,cd=0,level=42,id=15265},
    S{name="Holy Fire",rank=6,school=2,spellType="dd+dot",minDmg=279,maxDmg=347,manaCost=200,castTime=3.5,spCoeff=0.75,dotTotal=110,dotDuration=10,dotCoeff=0.167,cd=0,level=48,id=15266},
    S{name="Holy Fire",rank=7,school=2,spellType="dd+dot",minDmg=334,maxDmg=416,manaCost=230,castTime=3.5,spCoeff=0.75,dotTotal=135,dotDuration=10,dotCoeff=0.167,cd=0,level=54,id=15267},
    S{name="Holy Fire",rank=8,school=2,spellType="dd+dot",minDmg=390,maxDmg=484,manaCost=255,castTime=3.5,spCoeff=0.75,dotTotal=160,dotDuration=10,dotCoeff=0.167,cd=0,level=60,id=15261},

    -- HOLY NOVA
    S{name="Holy Nova",rank=1,school=2,spellType="damage",minDmg=26,maxDmg=30,manaCost=130,castTime=0,spCoeff=0.107,cd=0,level=20,isAoE=true,id=15237},
    S{name="Holy Nova",rank=2,school=2,spellType="damage",minDmg=47,maxDmg=55,manaCost=180,castTime=0,spCoeff=0.107,cd=0,level=28,isAoE=true,id=15430},
    S{name="Holy Nova",rank=3,school=2,spellType="damage",minDmg=72,maxDmg=84,manaCost=240,castTime=0,spCoeff=0.107,cd=0,level=36,isAoE=true,id=15431},
    S{name="Holy Nova",rank=4,school=2,spellType="damage",minDmg=101,maxDmg=117,manaCost=310,castTime=0,spCoeff=0.107,cd=0,level=44,isAoE=true,id=27799},
    S{name="Holy Nova",rank=5,school=2,spellType="damage",minDmg=133,maxDmg=155,manaCost=390,castTime=0,spCoeff=0.107,cd=0,level=52,isAoE=true,id=27800},
    S{name="Holy Nova",rank=6,school=2,spellType="damage",minDmg=172,maxDmg=200,manaCost=480,castTime=0,spCoeff=0.107,cd=0,level=60,isAoE=true,id=27801},

    -- CHASTISE  (Koeffizient geschaetzt)
    S{name="Chastise",rank=1,school=2,spellType="damage",minDmg=139,maxDmg=160,manaCost=0,castTime=0,spCoeff=0.429,manaPct=6,cd=40,level=35,id=51478},
    S{name="Chastise",rank=2,school=2,spellType="damage",minDmg=209,maxDmg=240,manaCost=0,castTime=0,spCoeff=0.429,manaPct=6,cd=40,level=45,id=51479},
    S{name="Chastise",rank=3,school=2,spellType="damage",minDmg=278,maxDmg=321,manaCost=0,castTime=0,spCoeff=0.429,manaPct=6,cd=40,level=55,id=51480},

    -- MIND BLAST
    S{name="Mind Blast",rank=1,school=6,spellType="damage",minDmg=39,maxDmg=43,manaCost=50,castTime=1.5,spCoeff=0.268,cd=8,level=10,id=8092},
    S{name="Mind Blast",rank=2,school=6,spellType="damage",minDmg=72,maxDmg=78,manaCost=80,castTime=1.5,spCoeff=0.365,cd=8,level=16,id=8102},
    S{name="Mind Blast",rank=3,school=6,spellType="damage",minDmg=112,maxDmg=120,manaCost=110,castTime=1.5,spCoeff=0.429,cd=8,level=22,id=8103},
    S{name="Mind Blast",rank=4,school=6,spellType="damage",minDmg=167,maxDmg=177,manaCost=150,castTime=1.5,spCoeff=0.429,cd=8,level=28,id=8104},
    S{name="Mind Blast",rank=5,school=6,spellType="damage",minDmg=217,maxDmg=231,manaCost=185,castTime=1.5,spCoeff=0.429,cd=8,level=34,id=8105},
    S{name="Mind Blast",rank=6,school=6,spellType="damage",minDmg=279,maxDmg=297,manaCost=225,castTime=1.5,spCoeff=0.429,cd=8,level=40,id=8106},
    S{name="Mind Blast",rank=7,school=6,spellType="damage",minDmg=346,maxDmg=366,manaCost=265,castTime=1.5,spCoeff=0.429,cd=8,level=46,id=10945},
    S{name="Mind Blast",rank=8,school=6,spellType="damage",minDmg=425,maxDmg=449,manaCost=310,castTime=1.5,spCoeff=0.429,cd=8,level=52,id=10946},
    S{name="Mind Blast",rank=9,school=6,spellType="damage",minDmg=503,maxDmg=531,manaCost=350,castTime=1.5,spCoeff=0.429,cd=8,level=58,id=10947},

    -- PAIN SPIKE  (Koeffizient geschaetzt)
    S{name="Pain Spike",rank=1,school=6,spellType="damage",minDmg=66,maxDmg=85,manaCost=80,castTime=0,spCoeff=0.429,cd=30,level=30,id=45555},
    S{name="Pain Spike",rank=2,school=6,spellType="damage",minDmg=149,maxDmg=172,manaCost=140,castTime=0,spCoeff=0.429,cd=30,level=40,id=57701},
    S{name="Pain Spike",rank=3,school=6,spellType="damage",minDmg=209,maxDmg=240,manaCost=185,castTime=0,spCoeff=0.429,cd=30,level=50,id=57704},
    S{name="Pain Spike",rank=4,school=6,spellType="damage",minDmg=333,maxDmg=378,manaCost=265,castTime=0,spCoeff=0.429,cd=30,level=60,id=57707},

    -- SHADOW WORD: PAIN
    S{name="Shadow Word: Pain",rank=1,school=6,spellType="dot",manaCost=25,castTime=0,dotTotal=30,dotDuration=18,dotCoeff=0.4,cd=0,level=4,id=589},
    S{name="Shadow Word: Pain",rank=2,school=6,spellType="dot",manaCost=50,castTime=0,dotTotal=66,dotDuration=18,dotCoeff=0.625,cd=0,level=10,id=594},
    S{name="Shadow Word: Pain",rank=3,school=6,spellType="dot",manaCost=95,castTime=0,dotTotal=132,dotDuration=18,dotCoeff=0.925,cd=0,level=18,id=970},
    S{name="Shadow Word: Pain",rank=4,school=6,spellType="dot",manaCost=155,castTime=0,dotTotal=234,dotDuration=18,dotCoeff=1,cd=0,level=26,id=992},
    S{name="Shadow Word: Pain",rank=5,school=6,spellType="dot",manaCost=230,castTime=0,dotTotal=366,dotDuration=18,dotCoeff=1,cd=0,level=34,id=2767},
    S{name="Shadow Word: Pain",rank=6,school=6,spellType="dot",manaCost=305,castTime=0,dotTotal=510,dotDuration=18,dotCoeff=1,cd=0,level=42,id=10892},
    S{name="Shadow Word: Pain",rank=7,school=6,spellType="dot",manaCost=385,castTime=0,dotTotal=672,dotDuration=18,dotCoeff=1,cd=0,level=50,id=10893},
    S{name="Shadow Word: Pain",rank=8,school=6,spellType="dot",manaCost=470,castTime=0,dotTotal=852,dotDuration=18,dotCoeff=1,cd=0,level=58,id=10894},

    -- MIND FLAY
    S{name="Mind Flay",rank=1,school=6,spellType="ch_dmg",minDmg=75,maxDmg=75,manaCost=45,castTime=3,spCoeff=0.429,cd=0,level=20,id=15407},
    S{name="Mind Flay",rank=2,school=6,spellType="ch_dmg",minDmg=126,maxDmg=126,manaCost=70,castTime=3,spCoeff=0.429,cd=0,level=28,id=17311},
    S{name="Mind Flay",rank=3,school=6,spellType="ch_dmg",minDmg=186,maxDmg=186,manaCost=100,castTime=3,spCoeff=0.429,cd=0,level=36,id=17312},
    S{name="Mind Flay",rank=4,school=6,spellType="ch_dmg",minDmg=261,maxDmg=261,manaCost=135,castTime=3,spCoeff=0.429,cd=0,level=44,id=17313},
    S{name="Mind Flay",rank=5,school=6,spellType="ch_dmg",minDmg=330,maxDmg=330,manaCost=165,castTime=3,spCoeff=0.429,cd=0,level=52,id=17314},
    S{name="Mind Flay",rank=6,school=6,spellType="ch_dmg",minDmg=426,maxDmg=426,manaCost=205,castTime=3,spCoeff=0.429,cd=0,level=60,id=18807},

    -- DEVOURING PLAGUE
    S{name="Devouring Plague",rank=1,school=6,spellType="dot",manaCost=215,castTime=0,dotTotal=152,dotDuration=24,dotCoeff=1,cd=180,level=20,id=2944},
    S{name="Devouring Plague",rank=2,school=6,spellType="dot",manaCost=350,castTime=0,dotTotal=272,dotDuration=24,dotCoeff=1,cd=180,level=28,id=19276},
    S{name="Devouring Plague",rank=3,school=6,spellType="dot",manaCost=495,castTime=0,dotTotal=400,dotDuration=24,dotCoeff=1,cd=180,level=36,id=19277},
    S{name="Devouring Plague",rank=4,school=6,spellType="dot",manaCost=645,castTime=0,dotTotal=544,dotDuration=24,dotCoeff=1,cd=180,level=44,id=19278},
    S{name="Devouring Plague",rank=5,school=6,spellType="dot",manaCost=810,castTime=0,dotTotal=712,dotDuration=24,dotCoeff=1,cd=180,level=52,id=19279},
    S{name="Devouring Plague",rank=6,school=6,spellType="dot",manaCost=985,castTime=0,dotTotal=904,dotDuration=24,dotCoeff=1,cd=180,level=60,id=19280},

    -- STARSHARDS
    S{name="Starshards",rank=1,school=7,spellType="ch_dmg",minDmg=198,maxDmg=198,manaCost=100,castTime=6,spCoeff=0.522,cd=30,level=10,id=10797},
    S{name="Starshards",rank=2,school=7,spellType="ch_dmg",minDmg=324,maxDmg=324,manaCost=170,castTime=6,spCoeff=0.772,cd=30,level=18,id=19296},
    S{name="Starshards",rank=3,school=7,spellType="ch_dmg",minDmg=564,maxDmg=564,manaCost=280,castTime=6,spCoeff=0.835,cd=30,level=26,id=19299},
    S{name="Starshards",rank=4,school=7,spellType="ch_dmg",minDmg=852,maxDmg=852,manaCost=380,castTime=6,spCoeff=0.835,cd=30,level=34,id=19302},
    S{name="Starshards",rank=5,school=7,spellType="ch_dmg",minDmg=1176,maxDmg=1176,manaCost=490,castTime=6,spCoeff=0.835,cd=30,level=42,id=19303},
    S{name="Starshards",rank=6,school=7,spellType="ch_dmg",minDmg=1536,maxDmg=1536,manaCost=600,castTime=6,spCoeff=0.835,cd=30,level=50,id=19304},
    S{name="Starshards",rank=7,school=7,spellType="ch_dmg",minDmg=1938,maxDmg=1938,manaCost=700,castTime=6,spCoeff=0.835,cd=30,level=58,id=19305},

    -- FLASH HEAL
    S{name="Flash Heal",rank=1,school=2,spellType="heal",minDmg=193,maxDmg=237,manaCost=125,castTime=1.5,hpCoeff=0.429,cd=0,level=20,id=2061},
    S{name="Flash Heal",rank=2,school=2,spellType="heal",minDmg=258,maxDmg=314,manaCost=155,castTime=1.5,hpCoeff=0.429,cd=0,level=26,id=9472},
    S{name="Flash Heal",rank=3,school=2,spellType="heal",minDmg=297,maxDmg=357,manaCost=185,castTime=1.5,hpCoeff=0.429,cd=0,level=32,id=9473},
    S{name="Flash Heal",rank=4,school=2,spellType="heal",minDmg=364,maxDmg=434,manaCost=215,castTime=1.5,hpCoeff=0.429,cd=0,level=38,id=9474},
    S{name="Flash Heal",rank=5,school=2,spellType="heal",minDmg=471,maxDmg=560,manaCost=265,castTime=1.5,hpCoeff=0.429,cd=0,level=44,id=10915},
    S{name="Flash Heal",rank=6,school=2,spellType="heal",minDmg=586,maxDmg=696,manaCost=315,castTime=1.5,hpCoeff=0.429,cd=0,level=50,id=10916},
    S{name="Flash Heal",rank=7,school=2,spellType="heal",minDmg=738,maxDmg=871,manaCost=380,castTime=1.5,hpCoeff=0.429,cd=0,level=56,id=10917},

    -- GREATER HEAL
    S{name="Greater Heal",rank=1,school=2,spellType="heal",minDmg=840,maxDmg=947,manaCost=370,castTime=3,hpCoeff=0.857,cd=0,level=40,id=2060},
    S{name="Greater Heal",rank=2,school=2,spellType="heal",minDmg=1075,maxDmg=1206,manaCost=455,castTime=3,hpCoeff=0.857,cd=0,level=46,id=10963},
    S{name="Greater Heal",rank=3,school=2,spellType="heal",minDmg=1344,maxDmg=1505,manaCost=545,castTime=3,hpCoeff=0.857,cd=0,level=52,id=10964},
    S{name="Greater Heal",rank=4,school=2,spellType="heal",minDmg=1681,maxDmg=1876,manaCost=655,castTime=3,hpCoeff=0.857,cd=0,level=58,id=10965},
    S{name="Greater Heal",rank=5,school=2,spellType="heal",minDmg=1881,maxDmg=2052,manaCost=710,castTime=3,hpCoeff=0.857,cd=0,level=60,id=25314},

    -- HEAL
    S{name="Heal",rank=1,school=2,spellType="heal",minDmg=295,maxDmg=341,manaCost=155,castTime=3,hpCoeff=0.728,cd=0,level=16,id=2054},
    S{name="Heal",rank=2,school=2,spellType="heal",minDmg=429,maxDmg=491,manaCost=205,castTime=3,hpCoeff=0.857,cd=0,level=22,id=2055},
    S{name="Heal",rank=3,school=2,spellType="heal",minDmg=566,maxDmg=642,manaCost=255,castTime=3,hpCoeff=0.857,cd=0,level=28,id=6063},
    S{name="Heal",rank=4,school=2,spellType="heal",minDmg=703,maxDmg=793,manaCost=305,castTime=3,hpCoeff=0.857,cd=0,level=34,id=6064},

    -- LESSER HEAL
    S{name="Lesser Heal",rank=1,school=2,spellType="heal",minDmg=46,maxDmg=56,manaCost=30,castTime=1.5,hpCoeff=0.123,cd=0,level=1,id=2050},
    S{name="Lesser Heal",rank=2,school=2,spellType="heal",minDmg=71,maxDmg=85,manaCost=45,castTime=2,hpCoeff=0.228,cd=0,level=4,id=2052},
    S{name="Lesser Heal",rank=3,school=2,spellType="heal",minDmg=135,maxDmg=157,manaCost=75,castTime=2.5,hpCoeff=0.446,cd=0,level=10,id=2053},

    -- RENEW
    S{name="Renew",rank=1,school=2,spellType="hot",manaCost=30,castTime=0,dotTotal=45,dotDuration=15,dotCoeff=0.55,cd=0,level=8,id=139},
    S{name="Renew",rank=2,school=2,spellType="hot",manaCost=65,castTime=0,dotTotal=100,dotDuration=15,dotCoeff=0.775,cd=0,level=14,id=6074},
    S{name="Renew",rank=3,school=2,spellType="hot",manaCost=105,castTime=0,dotTotal=175,dotDuration=15,dotCoeff=1,cd=0,level=20,id=6075},
    S{name="Renew",rank=4,school=2,spellType="hot",manaCost=140,castTime=0,dotTotal=245,dotDuration=15,dotCoeff=1,cd=0,level=26,id=6076},
    S{name="Renew",rank=5,school=2,spellType="hot",manaCost=170,castTime=0,dotTotal=270,dotDuration=15,dotCoeff=1,cd=0,level=32,id=6077},
    S{name="Renew",rank=6,school=2,spellType="hot",manaCost=205,castTime=0,dotTotal=340,dotDuration=15,dotCoeff=1,cd=0,level=38,id=6078},
    S{name="Renew",rank=7,school=2,spellType="hot",manaCost=250,castTime=0,dotTotal=435,dotDuration=15,dotCoeff=1,cd=0,level=44,id=10927},
    S{name="Renew",rank=8,school=2,spellType="hot",manaCost=305,castTime=0,dotTotal=555,dotDuration=15,dotCoeff=1,cd=0,level=50,id=10928},
    S{name="Renew",rank=9,school=2,spellType="hot",manaCost=365,castTime=0,dotTotal=690,dotDuration=15,dotCoeff=1,cd=0,level=56,id=10929},
    S{name="Renew",rank=10,school=2,spellType="hot",manaCost=410,castTime=0,dotTotal=825,dotDuration=15,dotCoeff=1,cd=0,level=60,id=25315},

    -- PRAYER OF HEALING
    S{name="Prayer of Healing",rank=1,school=2,spellType="heal",minDmg=301,maxDmg=321,manaCost=410,castTime=3,hpCoeff=0.286,cd=0,level=30,isAoE=true,id=596},
    S{name="Prayer of Healing",rank=2,school=2,spellType="heal",minDmg=378,maxDmg=402,manaCost=560,castTime=3,hpCoeff=0.286,cd=0,level=40,isAoE=true,id=996},
    S{name="Prayer of Healing",rank=3,school=2,spellType="heal",minDmg=559,maxDmg=591,manaCost=770,castTime=3,hpCoeff=0.286,cd=0,level=50,isAoE=true,id=10960},
    S{name="Prayer of Healing",rank=4,school=2,spellType="heal",minDmg=798,maxDmg=842,manaCost=1030,castTime=3,hpCoeff=0.286,cd=0,level=60,isAoE=true,id=10961},
    S{name="Prayer of Healing",rank=5,school=2,spellType="heal",minDmg=885,maxDmg=934,manaCost=1070,castTime=3,hpCoeff=0.286,cd=0,level=60,isAoE=true,id=25316},

    -- HOLY NOVA (HEAL)
    S{name="Holy Nova (Heal)",rank=1,school=2,spellType="heal",minDmg=52,maxDmg=60,manaCost=130,castTime=0,hpCoeff=0.161,cd=0,level=20,isAoE=true,id=23455},
    S{name="Holy Nova (Heal)",rank=2,school=2,spellType="heal",minDmg=86,maxDmg=98,manaCost=180,castTime=0,hpCoeff=0.161,cd=0,level=28,isAoE=true,id=23458},
    S{name="Holy Nova (Heal)",rank=3,school=2,spellType="heal",minDmg=121,maxDmg=139,manaCost=240,castTime=0,hpCoeff=0.161,cd=0,level=36,isAoE=true,id=23459},
    S{name="Holy Nova (Heal)",rank=4,school=2,spellType="heal",minDmg=161,maxDmg=187,manaCost=310,castTime=0,hpCoeff=0.161,cd=0,level=44,isAoE=true,id=27803},
    S{name="Holy Nova (Heal)",rank=5,school=2,spellType="heal",minDmg=235,maxDmg=271,manaCost=390,castTime=0,hpCoeff=0.161,cd=0,level=52,isAoE=true,id=27804},
    S{name="Holy Nova (Heal)",rank=6,school=2,spellType="heal",minDmg=302,maxDmg=350,manaCost=480,castTime=0,hpCoeff=0.161,cd=0,level=60,isAoE=true,id=27805},

    -- DESPERATE PRAYER
    S{name="Desperate Prayer",rank=1,school=2,spellType="heal",minDmg=134,maxDmg=170,manaCost=0,castTime=0,hpCoeff=0.268,cd=600,level=10,id=13908},
    S{name="Desperate Prayer",rank=2,school=2,spellType="heal",minDmg=263,maxDmg=325,manaCost=0,castTime=0,hpCoeff=0.397,cd=600,level=18,id=19236},
    S{name="Desperate Prayer",rank=3,school=2,spellType="heal",minDmg=447,maxDmg=543,manaCost=0,castTime=0,hpCoeff=0.429,cd=600,level=26,id=19238},
    S{name="Desperate Prayer",rank=4,school=2,spellType="heal",minDmg=500,maxDmg=602,manaCost=0,castTime=0,hpCoeff=0.429,cd=600,level=34,id=19240},
    S{name="Desperate Prayer",rank=5,school=2,spellType="heal",minDmg=709,maxDmg=845,manaCost=0,castTime=0,hpCoeff=0.429,cd=600,level=42,id=19241},
    S{name="Desperate Prayer",rank=6,school=2,spellType="heal",minDmg=936,maxDmg=1109,manaCost=0,castTime=0,hpCoeff=0.429,cd=600,level=50,id=19242},
    S{name="Desperate Prayer",rank=7,school=2,spellType="heal",minDmg=1126,maxDmg=1328,manaCost=0,castTime=0,hpCoeff=0.429,cd=600,level=58,id=19243},

    -- POWER WORD: SHIELD
    S{name="Power Word: Shield",rank=1,school=2,spellType="heal",minDmg=44,maxDmg=44,manaCost=45,castTime=0,hpCoeff=0.048,cd=4,level=6,id=17},
    S{name="Power Word: Shield",rank=2,school=2,spellType="heal",minDmg=88,maxDmg=88,manaCost=80,castTime=0,hpCoeff=0.07,cd=4,level=12,id=592},
    S{name="Power Word: Shield",rank=3,school=2,spellType="heal",minDmg=158,maxDmg=158,manaCost=130,castTime=0,hpCoeff=0.093,cd=4,level=18,id=600},
    S{name="Power Word: Shield",rank=4,school=2,spellType="heal",minDmg=234,maxDmg=234,manaCost=175,castTime=0,hpCoeff=0.1,cd=4,level=24,id=3747},
    S{name="Power Word: Shield",rank=5,school=2,spellType="heal",minDmg=301,maxDmg=301,manaCost=210,castTime=0,hpCoeff=0.1,cd=4,level=30,id=6065},
    S{name="Power Word: Shield",rank=6,school=2,spellType="heal",minDmg=381,maxDmg=381,manaCost=250,castTime=0,hpCoeff=0.1,cd=4,level=36,id=6066},
    S{name="Power Word: Shield",rank=7,school=2,spellType="heal",minDmg=484,maxDmg=484,manaCost=300,castTime=0,hpCoeff=0.1,cd=4,level=42,id=10898},
    S{name="Power Word: Shield",rank=8,school=2,spellType="heal",minDmg=605,maxDmg=605,manaCost=355,castTime=0,hpCoeff=0.1,cd=4,level=48,id=10899},
    S{name="Power Word: Shield",rank=9,school=2,spellType="heal",minDmg=763,maxDmg=763,manaCost=425,castTime=0,hpCoeff=0.1,cd=4,level=54,id=10900},
    S{name="Power Word: Shield",rank=10,school=2,spellType="heal",minDmg=942,maxDmg=942,manaCost=500,castTime=0,hpCoeff=0.1,cd=4,level=60,id=10901},
}

-- ============================================================================
-- WARLOCK
-- ============================================================================
SPELLCALC_SPELLS["WARLOCK"] = {
    -- SHADOW BOLT
    S{name="Shadow Bolt",rank=1,school=6,spellType="damage",minDmg=12,maxDmg=16,manaCost=25,castTime=1.7,spCoeff=0.14,cd=0,level=1,id=686},
    S{name="Shadow Bolt",rank=2,school=6,spellType="damage",minDmg=23,maxDmg=29,manaCost=40,castTime=2.2,spCoeff=0.299,cd=0,level=6,id=695},
    S{name="Shadow Bolt",rank=3,school=6,spellType="damage",minDmg=48,maxDmg=56,manaCost=70,castTime=2.8,spCoeff=0.56,cd=0,level=12,id=705},
    S{name="Shadow Bolt",rank=4,school=6,spellType="damage",minDmg=86,maxDmg=98,manaCost=110,castTime=3,spCoeff=0.857,cd=0,level=20,id=1088},
    S{name="Shadow Bolt",rank=5,school=6,spellType="damage",minDmg=142,maxDmg=162,manaCost=160,castTime=3,spCoeff=0.857,cd=0,level=28,id=1106},
    S{name="Shadow Bolt",rank=6,school=6,spellType="damage",minDmg=204,maxDmg=230,manaCost=210,castTime=3,spCoeff=0.857,cd=0,level=36,id=7641},
    S{name="Shadow Bolt",rank=7,school=6,spellType="damage",minDmg=281,maxDmg=315,manaCost=265,castTime=3,spCoeff=0.857,cd=0,level=44,id=11659},
    S{name="Shadow Bolt",rank=8,school=6,spellType="damage",minDmg=360,maxDmg=402,manaCost=315,castTime=3,spCoeff=0.857,cd=0,level=52,id=11660},
    S{name="Shadow Bolt",rank=9,school=6,spellType="damage",minDmg=455,maxDmg=507,manaCost=370,castTime=3,spCoeff=0.857,cd=0,level=60,id=11661},
    S{name="Shadow Bolt",rank=10,school=6,spellType="damage",minDmg=482,maxDmg=538,manaCost=380,castTime=3,spCoeff=0.857,cd=0,level=60,id=25307},

    -- CORRUPTION
    S{name="Corruption",rank=1,school=6,spellType="dot",manaCost=35,castTime=1.5,dotTotal=40,dotDuration=12,dotCoeff=0.267,cd=0,level=4,id=172},
    S{name="Corruption",rank=2,school=6,spellType="dot",manaCost=55,castTime=1.5,dotTotal=90,dotDuration=15,dotCoeff=0.646,cd=0,level=14,id=6222},
    S{name="Corruption",rank=3,school=6,spellType="dot",manaCost=100,castTime=1.5,dotTotal=222,dotDuration=18,dotCoeff=1,cd=0,level=24,id=6223},
    S{name="Corruption",rank=4,school=6,spellType="dot",manaCost=160,castTime=1.5,dotTotal=324,dotDuration=18,dotCoeff=1,cd=0,level=34,id=7648},
    S{name="Corruption",rank=5,school=6,spellType="dot",manaCost=225,castTime=1.5,dotTotal=486,dotDuration=18,dotCoeff=1,cd=0,level=44,id=11671},
    S{name="Corruption",rank=6,school=6,spellType="dot",manaCost=290,castTime=1.5,dotTotal=666,dotDuration=18,dotCoeff=1,cd=0,level=54,id=11672},
    S{name="Corruption",rank=7,school=6,spellType="dot",manaCost=340,castTime=1.5,dotTotal=822,dotDuration=18,dotCoeff=1,cd=0,level=60,id=25311},

    -- CURSE OF AGONY
    S{name="Curse of Agony",rank=1,school=6,spellType="dot",manaCost=25,castTime=0,dotTotal=84,dotDuration=24,dotCoeff=0.55,cd=0,level=8,id=980},
    S{name="Curse of Agony",rank=2,school=6,spellType="dot",manaCost=50,castTime=0,dotTotal=180,dotDuration=24,dotCoeff=0.925,cd=0,level=18,id=1014},
    S{name="Curse of Agony",rank=3,school=6,spellType="dot",manaCost=90,castTime=0,dotTotal=324,dotDuration=24,dotCoeff=1,cd=0,level=28,id=6217},
    S{name="Curse of Agony",rank=4,school=6,spellType="dot",manaCost=130,castTime=0,dotTotal=504,dotDuration=24,dotCoeff=1,cd=0,level=38,id=11711},
    S{name="Curse of Agony",rank=5,school=6,spellType="dot",manaCost=170,castTime=0,dotTotal=780,dotDuration=24,dotCoeff=1,cd=0,level=48,id=11712},
    S{name="Curse of Agony",rank=6,school=6,spellType="dot",manaCost=215,castTime=0,dotTotal=1044,dotDuration=24,dotCoeff=1,cd=0,level=58,id=11713},

    -- SIPHON LIFE
    S{name="Siphon Life",rank=1,school=6,spellType="dot",manaCost=150,castTime=0,dotTotal=150,dotDuration=30,dotCoeff=0.5,cd=0,level=30,id=18265},
    S{name="Siphon Life",rank=2,school=6,spellType="dot",manaCost=205,castTime=0,dotTotal=220,dotDuration=30,dotCoeff=0.5,cd=0,level=38,id=18879},
    S{name="Siphon Life",rank=3,school=6,spellType="dot",manaCost=285,castTime=0,dotTotal=330,dotDuration=30,dotCoeff=0.5,cd=0,level=48,id=18880},
    S{name="Siphon Life",rank=4,school=6,spellType="dot",manaCost=365,castTime=0,dotTotal=450,dotDuration=30,dotCoeff=0.5,cd=0,level=58,id=18881},

    -- IMMOLATE
    S{name="Immolate",rank=1,school=3,spellType="dd+dot",minDmg=8,maxDmg=8,manaCost=25,castTime=2,spCoeff=0.045,dotTotal=20,dotDuration=15,dotCoeff=0.187,cd=0,level=1,id=348},
    S{name="Immolate",rank=2,school=3,spellType="dd+dot",minDmg=19,maxDmg=19,manaCost=45,castTime=2,spCoeff=0.098,dotTotal=40,dotDuration=15,dotCoeff=0.407,cd=0,level=10,id=707},
    S{name="Immolate",rank=3,school=3,spellType="dd+dot",minDmg=45,maxDmg=45,manaCost=90,castTime=2,spCoeff=0.157,dotTotal=90,dotDuration=15,dotCoeff=0.651,cd=0,level=20,id=1094},
    S{name="Immolate",rank=4,school=3,spellType="dd+dot",minDmg=90,maxDmg=90,manaCost=155,castTime=2,spCoeff=0.157,dotTotal=165,dotDuration=15,dotCoeff=0.651,cd=0,level=30,id=2941},
    S{name="Immolate",rank=5,school=3,spellType="dd+dot",minDmg=134,maxDmg=134,manaCost=220,castTime=2,spCoeff=0.157,dotTotal=255,dotDuration=15,dotCoeff=0.651,cd=0,level=40,id=11665},
    S{name="Immolate",rank=6,school=3,spellType="dd+dot",minDmg=192,maxDmg=192,manaCost=295,castTime=2,spCoeff=0.157,dotTotal=365,dotDuration=15,dotCoeff=0.651,cd=0,level=50,id=11667},
    S{name="Immolate",rank=7,school=3,spellType="dd+dot",minDmg=258,maxDmg=258,manaCost=370,castTime=2,spCoeff=0.157,dotTotal=485,dotDuration=15,dotCoeff=0.651,cd=0,level=60,id=11668},
    S{name="Immolate",rank=8,school=3,spellType="dd+dot",minDmg=279,maxDmg=279,manaCost=380,castTime=2,spCoeff=0.157,dotTotal=510,dotDuration=15,dotCoeff=0.651,cd=0,level=60,id=25309},

    -- SEARING PAIN
    S{name="Searing Pain",rank=1,school=3,spellType="damage",minDmg=49,maxDmg=57,manaCost=45,castTime=2,spCoeff=0.528,cd=0,level=18,id=5676},
    S{name="Searing Pain",rank=2,school=3,spellType="damage",minDmg=85,maxDmg=97,manaCost=68,castTime=2,spCoeff=0.571,cd=0,level=26,id=17919},
    S{name="Searing Pain",rank=3,school=3,spellType="damage",minDmg=124,maxDmg=142,manaCost=91,castTime=2,spCoeff=0.571,cd=0,level=34,id=17920},
    S{name="Searing Pain",rank=4,school=3,spellType="damage",minDmg=175,maxDmg=199,manaCost=118,castTime=2,spCoeff=0.571,cd=0,level=42,id=17921},
    S{name="Searing Pain",rank=5,school=3,spellType="damage",minDmg=227,maxDmg=257,manaCost=141,castTime=2,spCoeff=0.571,cd=0,level=50,id=17922},
    S{name="Searing Pain",rank=6,school=3,spellType="damage",minDmg=292,maxDmg=328,manaCost=168,castTime=2,spCoeff=0.571,cd=0,level=58,id=17923},

    -- SOUL FIRE
    S{name="Soul Fire",rank=1,school=3,spellType="damage",minDmg=454,maxDmg=571,manaCost=175,castTime=6,spCoeff=1,cd=30,level=30,id=6353},
    S{name="Soul Fire",rank=2,school=3,spellType="damage",minDmg=545,maxDmg=685,manaCost=260,castTime=6,spCoeff=1,cd=30,level=38,id=17924},
    S{name="Soul Fire",rank=3,school=3,spellType="damage",minDmg=623,maxDmg=783,manaCost=305,castTime=6,spCoeff=1,cd=30,level=46,id=51683},
    S{name="Soul Fire",rank=4,school=3,spellType="damage",minDmg=703,maxDmg=881,manaCost=335,castTime=6,spCoeff=1,cd=30,level=54,id=51684},

    -- SHADOWBURN
    S{name="Shadowburn",rank=1,school=6,spellType="damage",minDmg=87,maxDmg=99,manaCost=105,castTime=0,spCoeff=0.429,cd=15,level=20,id=17877},
    S{name="Shadowburn",rank=2,school=6,spellType="damage",minDmg=115,maxDmg=131,manaCost=130,castTime=0,spCoeff=0.429,cd=15,level=24,id=18867},
    S{name="Shadowburn",rank=3,school=6,spellType="damage",minDmg=186,maxDmg=210,manaCost=190,castTime=0,spCoeff=0.429,cd=15,level=32,id=18868},
    S{name="Shadowburn",rank=4,school=6,spellType="damage",minDmg=261,maxDmg=293,manaCost=245,castTime=0,spCoeff=0.429,cd=15,level=40,id=18869},
    S{name="Shadowburn",rank=5,school=6,spellType="damage",minDmg=350,maxDmg=392,manaCost=305,castTime=0,spCoeff=0.429,cd=15,level=48,id=18870},
    S{name="Shadowburn",rank=6,school=6,spellType="damage",minDmg=450,maxDmg=502,manaCost=365,castTime=0,spCoeff=0.429,cd=15,level=56,id=18871},

    -- DEATH COIL
    S{name="Death Coil",rank=1,school=6,spellType="damage",minDmg=287,maxDmg=287,manaCost=430,castTime=0,spCoeff=0.214,cd=120,level=42,id=6789},
    S{name="Death Coil",rank=2,school=6,spellType="damage",minDmg=375,maxDmg=375,manaCost=495,castTime=0,spCoeff=0.214,cd=120,level=50,id=17925},
    S{name="Death Coil",rank=3,school=6,spellType="damage",minDmg=470,maxDmg=470,manaCost=565,castTime=0,spCoeff=0.214,cd=120,level=58,id=17926},

    -- CONFLAGRATE
    S{name="Conflagrate",rank=1,school=3,spellType="damage",minDmg=240,maxDmg=306,manaCost=165,castTime=0,spCoeff=0.429,cd=10,level=40,id=17962},
    S{name="Conflagrate",rank=2,school=3,spellType="damage",minDmg=316,maxDmg=396,manaCost=200,castTime=0,spCoeff=0.429,cd=10,level=48,id=18930},
    S{name="Conflagrate",rank=3,school=3,spellType="damage",minDmg=383,maxDmg=479,manaCost=230,castTime=0,spCoeff=0.429,cd=10,level=54,id=18931},
    S{name="Conflagrate",rank=4,school=3,spellType="damage",minDmg=447,maxDmg=557,manaCost=255,castTime=0,spCoeff=0.429,cd=10,level=60,id=18932},

    -- DRAIN LIFE
    S{name="Drain Life",rank=1,school=6,spellType="ch_dmg",minDmg=50,maxDmg=50,manaCost=55,castTime=5,spCoeff=0.553,cd=0,level=14,id=689},
    S{name="Drain Life",rank=2,school=6,spellType="ch_dmg",minDmg=85,maxDmg=85,manaCost=85,castTime=5,spCoeff=0.714,cd=0,level=22,id=699},
    S{name="Drain Life",rank=3,school=6,spellType="ch_dmg",minDmg=145,maxDmg=145,manaCost=135,castTime=5,spCoeff=0.714,cd=0,level=30,id=709},
    S{name="Drain Life",rank=4,school=6,spellType="ch_dmg",minDmg=205,maxDmg=205,manaCost=185,castTime=5,spCoeff=0.714,cd=0,level=38,id=7651},
    S{name="Drain Life",rank=5,school=6,spellType="ch_dmg",minDmg=275,maxDmg=275,manaCost=240,castTime=5,spCoeff=0.714,cd=0,level=46,id=11699},
    S{name="Drain Life",rank=6,school=6,spellType="ch_dmg",minDmg=355,maxDmg=355,manaCost=300,castTime=5,spCoeff=0.714,cd=0,level=54,id=11700},

    -- DRAIN SOUL
    S{name="Drain Soul",rank=1,school=6,spellType="ch_dmg",minDmg=114,maxDmg=114,manaCost=15,castTime=6,spCoeff=0.312,cd=0,level=10,id=1120},
    S{name="Drain Soul",rank=2,school=6,spellType="ch_dmg",minDmg=282,maxDmg=282,manaCost=35,castTime=6,spCoeff=0.5,cd=0,level=24,id=8288},
    S{name="Drain Soul",rank=3,school=6,spellType="ch_dmg",minDmg=462,maxDmg=462,manaCost=70,castTime=6,spCoeff=0.5,cd=0,level=38,id=8289},
    S{name="Drain Soul",rank=4,school=6,spellType="ch_dmg",minDmg=762,maxDmg=762,manaCost=100,castTime=6,spCoeff=0.5,cd=0,level=52,id=11675},
    S{name="Drain Soul",rank=5,school=6,spellType="ch_dmg",minDmg=954,maxDmg=954,manaCost=135,castTime=6,spCoeff=0.5,cd=0,level=60,id=51687},

    -- DARK HARVEST  (Koeffizient geschaetzt)
    S{name="Dark Harvest",rank=1,school=6,spellType="ch_dmg",minDmg=704,maxDmg=704,manaCost=230,castTime=8,spCoeff=1,cd=30,level=40,id=52550},
    S{name="Dark Harvest",rank=2,school=6,spellType="ch_dmg",minDmg=904,maxDmg=904,manaCost=300,castTime=8,spCoeff=1,cd=30,level=50,id=52551},
    S{name="Dark Harvest",rank=3,school=6,spellType="ch_dmg",minDmg=1152,maxDmg=1152,manaCost=350,castTime=8,spCoeff=1,cd=30,level=60,id=52552},

    -- RAIN OF FIRE
    S{name="Rain of Fire",rank=1,school=3,spellType="ch_dmg",minDmg=176,maxDmg=176,manaCost=295,castTime=8,spCoeff=0.333,cd=0,level=20,isAoE=true,id=5740},
    S{name="Rain of Fire",rank=2,school=3,spellType="ch_dmg",minDmg=384,maxDmg=384,manaCost=605,castTime=8,spCoeff=0.333,cd=0,level=34,isAoE=true,id=6219},
    S{name="Rain of Fire",rank=3,school=3,spellType="ch_dmg",minDmg=624,maxDmg=624,manaCost=885,castTime=8,spCoeff=0.333,cd=0,level=46,isAoE=true,id=11677},
    S{name="Rain of Fire",rank=4,school=3,spellType="ch_dmg",minDmg=904,maxDmg=904,manaCost=1185,castTime=8,spCoeff=0.333,cd=0,level=58,isAoE=true,id=11678},

    -- HELLFIRE
    S{name="Hellfire",rank=1,school=3,spellType="ch_dmg",minDmg=1245,maxDmg=1245,manaCost=160,castTime=15,spCoeff=0.333,cd=0,level=30,isAoE=true,id=1949},
    S{name="Hellfire",rank=2,school=3,spellType="ch_dmg",minDmg=2085,maxDmg=2085,manaCost=240,castTime=15,spCoeff=0.333,cd=0,level=42,isAoE=true,id=11683},
    S{name="Hellfire",rank=3,school=3,spellType="ch_dmg",minDmg=3120,maxDmg=3120,manaCost=325,castTime=15,spCoeff=0.333,cd=0,level=54,isAoE=true,id=11684},
}

-- ============================================================================
-- DRUID
-- ============================================================================
SPELLCALC_SPELLS["DRUID"] = {
    -- WRATH
    S{name="Wrath",rank=1,school=4,spellType="damage",minDmg=13,maxDmg=15,manaCost=20,castTime=1.5,spCoeff=0.123,cd=0,level=1,id=5176},
    S{name="Wrath",rank=2,school=4,spellType="damage",minDmg=26,maxDmg=30,manaCost=35,castTime=1.7,spCoeff=0.231,cd=0,level=6,id=5177},
    S{name="Wrath",rank=3,school=4,spellType="damage",minDmg=46,maxDmg=54,manaCost=55,castTime=2,spCoeff=0.443,cd=0,level=14,id=5178},
    S{name="Wrath",rank=4,school=4,spellType="damage",minDmg=66,maxDmg=77,manaCost=70,castTime=2,spCoeff=0.571,cd=0,level=22,id=5179},
    S{name="Wrath",rank=5,school=4,spellType="damage",minDmg=106,maxDmg=121,manaCost=100,castTime=2,spCoeff=0.571,cd=0,level=30,id=5180},
    S{name="Wrath",rank=6,school=4,spellType="damage",minDmg=146,maxDmg=165,manaCost=125,castTime=2,spCoeff=0.571,cd=0,level=38,id=6780},
    S{name="Wrath",rank=7,school=4,spellType="damage",minDmg=197,maxDmg=220,manaCost=155,castTime=2,spCoeff=0.571,cd=0,level=46,id=8905},
    S{name="Wrath",rank=8,school=4,spellType="damage",minDmg=248,maxDmg=277,manaCost=180,castTime=2,spCoeff=0.571,cd=0,level=54,id=9912},
    S{name="Wrath",rank=9,school=4,spellType="damage",minDmg=292,maxDmg=328,manaCost=210,castTime=2,spCoeff=0.571,cd=0,level=60,id=45967},

    -- STARFIRE
    S{name="Starfire",rank=1,school=7,spellType="damage",minDmg=89,maxDmg=109,manaCost=95,castTime=3.5,spCoeff=1,cd=0,level=20,id=2912},
    S{name="Starfire",rank=2,school=7,spellType="damage",minDmg=137,maxDmg=167,manaCost=135,castTime=3.5,spCoeff=1,cd=0,level=26,id=8949},
    S{name="Starfire",rank=3,school=7,spellType="damage",minDmg=201,maxDmg=241,manaCost=180,castTime=3.5,spCoeff=1,cd=0,level=34,id=8950},
    S{name="Starfire",rank=4,school=7,spellType="damage",minDmg=280,maxDmg=334,manaCost=230,castTime=3.5,spCoeff=1,cd=0,level=42,id=8951},
    S{name="Starfire",rank=5,school=7,spellType="damage",minDmg=362,maxDmg=428,manaCost=275,castTime=3.5,spCoeff=1,cd=0,level=50,id=9875},
    S{name="Starfire",rank=6,school=7,spellType="damage",minDmg=445,maxDmg=525,manaCost=315,castTime=3.5,spCoeff=1,cd=0,level=58,id=9876},
    S{name="Starfire",rank=7,school=7,spellType="damage",minDmg=496,maxDmg=584,manaCost=340,castTime=3.5,spCoeff=1,cd=0,level=60,id=25298},

    -- MOONFIRE  (Koeffizient geschaetzt)
    S{name="Moonfire",rank=1,school=7,spellType="dd+dot",minDmg=7,maxDmg=9,manaCost=25,castTime=0,spCoeff=0.06,dotTotal=12,dotDuration=9,dotCoeff=0.156,cd=0,level=4,id=8921},
    S{name="Moonfire",rank=2,school=7,spellType="dd+dot",minDmg=13,maxDmg=17,manaCost=50,castTime=0,spCoeff=0.094,dotTotal=48,dotDuration=18,dotCoeff=0.488,cd=0,level=10,id=8924},
    S{name="Moonfire",rank=3,school=7,spellType="dd+dot",minDmg=25,maxDmg=31,manaCost=75,castTime=0,spCoeff=0.128,dotTotal=78,dotDuration=18,dotCoeff=0.663,cd=0,level=16,id=8925},
    S{name="Moonfire",rank=4,school=7,spellType="dd+dot",minDmg=40,maxDmg=48,manaCost=105,castTime=0,spCoeff=0.15,dotTotal=120,dotDuration=18,dotCoeff=0.78,cd=0,level=22,id=8926},
    S{name="Moonfire",rank=5,school=7,spellType="dd+dot",minDmg=61,maxDmg=73,manaCost=150,castTime=0,spCoeff=0.15,dotTotal=186,dotDuration=18,dotCoeff=0.78,cd=0,level=28,id=8927},
    S{name="Moonfire",rank=6,school=7,spellType="dd+dot",minDmg=81,maxDmg=97,manaCost=190,castTime=0,spCoeff=0.15,dotTotal=246,dotDuration=18,dotCoeff=0.78,cd=0,level=34,id=8928},
    S{name="Moonfire",rank=7,school=7,spellType="dd+dot",minDmg=105,maxDmg=125,manaCost=235,castTime=0,spCoeff=0.15,dotTotal=318,dotDuration=18,dotCoeff=0.78,cd=0,level=40,id=8929},
    S{name="Moonfire",rank=8,school=7,spellType="dd+dot",minDmg=130,maxDmg=154,manaCost=280,castTime=0,spCoeff=0.15,dotTotal=396,dotDuration=18,dotCoeff=0.78,cd=0,level=46,id=9833},
    S{name="Moonfire",rank=9,school=7,spellType="dd+dot",minDmg=157,maxDmg=185,manaCost=325,castTime=0,spCoeff=0.15,dotTotal=480,dotDuration=18,dotCoeff=0.78,cd=0,level=52,id=9834},
    S{name="Moonfire",rank=10,school=7,spellType="dd+dot",minDmg=189,maxDmg=221,manaCost=375,castTime=0,spCoeff=0.15,dotTotal=576,dotDuration=18,dotCoeff=0.78,cd=0,level=58,id=9835},

    -- INSECT SWARM  (Koeffizient geschaetzt)
    S{name="Insect Swarm",rank=1,school=4,spellType="dot",manaCost=45,castTime=0,dotTotal=99,dotDuration=18,dotCoeff=1,cd=0,level=20,id=5570},
    S{name="Insect Swarm",rank=2,school=4,spellType="dot",manaCost=85,castTime=0,dotTotal=207,dotDuration=18,dotCoeff=1,cd=0,level=30,id=24974},
    S{name="Insect Swarm",rank=3,school=4,spellType="dot",manaCost=100,castTime=0,dotTotal=261,dotDuration=18,dotCoeff=1,cd=0,level=40,id=24975},
    S{name="Insect Swarm",rank=4,school=4,spellType="dot",manaCost=140,castTime=0,dotTotal=396,dotDuration=18,dotCoeff=1,cd=0,level=50,id=24976},
    S{name="Insect Swarm",rank=5,school=4,spellType="dot",manaCost=160,castTime=0,dotTotal=486,dotDuration=18,dotCoeff=1,cd=0,level=60,id=24977},

    -- HURRICANE
    S{name="Hurricane",rank=1,school=4,spellType="ch_dmg",minDmg=700,maxDmg=700,manaCost=880,castTime=10,spCoeff=0.333,cd=10,level=40,isAoE=true,id=16914},
    S{name="Hurricane",rank=2,school=4,spellType="ch_dmg",minDmg=1000,maxDmg=1000,manaCost=1180,castTime=10,spCoeff=0.333,cd=10,level=50,isAoE=true,id=17401},
    S{name="Hurricane",rank=3,school=4,spellType="ch_dmg",minDmg=1340,maxDmg=1340,manaCost=1495,castTime=10,spCoeff=0.333,cd=10,level=60,isAoE=true,id=17402},

    -- HEALING TOUCH
    S{name="Healing Touch",rank=1,school=4,spellType="heal",minDmg=37,maxDmg=51,manaCost=25,castTime=1.5,hpCoeff=0.123,cd=0,level=1,id=5185},
    S{name="Healing Touch",rank=2,school=4,spellType="heal",minDmg=88,maxDmg=112,manaCost=55,castTime=2,hpCoeff=0.314,cd=0,level=8,id=5186},
    S{name="Healing Touch",rank=3,school=4,spellType="heal",minDmg=195,maxDmg=243,manaCost=110,castTime=2.5,hpCoeff=0.554,cd=0,level=14,id=5187},
    S{name="Healing Touch",rank=4,school=4,spellType="heal",minDmg=363,maxDmg=445,manaCost=185,castTime=3,hpCoeff=0.857,cd=0,level=20,id=5188},
    S{name="Healing Touch",rank=5,school=4,spellType="heal",minDmg=572,maxDmg=694,manaCost=270,castTime=3.5,hpCoeff=1,cd=0,level=26,id=5189},
    S{name="Healing Touch",rank=6,school=4,spellType="heal",minDmg=742,maxDmg=894,manaCost=335,castTime=3.5,hpCoeff=1,cd=0,level=32,id=6778},
    S{name="Healing Touch",rank=7,school=4,spellType="heal",minDmg=936,maxDmg=1120,manaCost=405,castTime=3.5,hpCoeff=1,cd=0,level=38,id=8903},
    S{name="Healing Touch",rank=8,school=4,spellType="heal",minDmg=1199,maxDmg=1427,manaCost=495,castTime=3.5,hpCoeff=1,cd=0,level=44,id=9758},
    S{name="Healing Touch",rank=9,school=4,spellType="heal",minDmg=1516,maxDmg=1796,manaCost=600,castTime=3.5,hpCoeff=1,cd=0,level=50,id=9888},
    S{name="Healing Touch",rank=10,school=4,spellType="heal",minDmg=1890,maxDmg=2230,manaCost=720,castTime=3.5,hpCoeff=1,cd=0,level=56,id=9889},
    S{name="Healing Touch",rank=11,school=4,spellType="heal",minDmg=2267,maxDmg=2677,manaCost=800,castTime=3.5,hpCoeff=1,cd=0,level=60,id=25297},

    -- REGROWTH
    S{name="Regrowth",rank=1,school=4,spellType="dd+hot",minDmg=84,maxDmg=98,manaCost=96,castTime=2,hpCoeff=0.21,dotTotal=100,dotDuration=20,dotCoeff=0.49,cd=0,level=12,id=8936},
    S{name="Regrowth",rank=2,school=4,spellType="dd+hot",minDmg=164,maxDmg=188,manaCost=164,castTime=2,hpCoeff=0.278,dotTotal=170,dotDuration=20,dotCoeff=0.647,cd=0,level=18,id=8938},
    S{name="Regrowth",rank=3,school=4,spellType="dd+hot",minDmg=240,maxDmg=274,manaCost=224,castTime=2,hpCoeff=0.3,dotTotal=250,dotDuration=20,dotCoeff=0.7,cd=0,level=24,id=8939},
    S{name="Regrowth",rank=4,school=4,spellType="dd+hot",minDmg=318,maxDmg=360,manaCost=280,castTime=2,hpCoeff=0.3,dotTotal=330,dotDuration=20,dotCoeff=0.7,cd=0,level=30,id=8940},
    S{name="Regrowth",rank=5,school=4,spellType="dd+hot",minDmg=405,maxDmg=457,manaCost=336,castTime=2,hpCoeff=0.3,dotTotal=410,dotDuration=20,dotCoeff=0.7,cd=0,level=36,id=8941},
    S{name="Regrowth",rank=6,school=4,spellType="dd+hot",minDmg=511,maxDmg=575,manaCost=408,castTime=2,hpCoeff=0.3,dotTotal=520,dotDuration=20,dotCoeff=0.7,cd=0,level=42,id=9750},
    S{name="Regrowth",rank=7,school=4,spellType="dd+hot",minDmg=646,maxDmg=724,manaCost=492,castTime=2,hpCoeff=0.3,dotTotal=660,dotDuration=20,dotCoeff=0.7,cd=0,level=48,id=9856},
    S{name="Regrowth",rank=8,school=4,spellType="dd+hot",minDmg=809,maxDmg=905,manaCost=592,castTime=2,hpCoeff=0.3,dotTotal=820,dotDuration=20,dotCoeff=0.7,cd=0,level=54,id=9857},
    S{name="Regrowth",rank=9,school=4,spellType="dd+hot",minDmg=1003,maxDmg=1119,manaCost=704,castTime=2,hpCoeff=0.3,dotTotal=1020,dotDuration=20,dotCoeff=0.7,cd=0,level=60,id=9858},

    -- REJUVENATION
    S{name="Rejuvenation",rank=1,school=4,spellType="hot",manaCost=25,castTime=0,dotTotal=36,dotDuration=12,dotCoeff=0.32,cd=0,level=4,id=774},
    S{name="Rejuvenation",rank=2,school=4,spellType="hot",manaCost=40,castTime=0,dotTotal=60,dotDuration=12,dotCoeff=0.5,cd=0,level=10,id=1058},
    S{name="Rejuvenation",rank=3,school=4,spellType="hot",manaCost=75,castTime=0,dotTotal=120,dotDuration=12,dotCoeff=0.68,cd=0,level=16,id=1430},
    S{name="Rejuvenation",rank=4,school=4,spellType="hot",manaCost=105,castTime=0,dotTotal=180,dotDuration=12,dotCoeff=0.8,cd=0,level=22,id=2090},
    S{name="Rejuvenation",rank=5,school=4,spellType="hot",manaCost=135,castTime=0,dotTotal=246,dotDuration=12,dotCoeff=0.8,cd=0,level=28,id=2091},
    S{name="Rejuvenation",rank=6,school=4,spellType="hot",manaCost=160,castTime=0,dotTotal=306,dotDuration=12,dotCoeff=0.8,cd=0,level=34,id=3627},
    S{name="Rejuvenation",rank=7,school=4,spellType="hot",manaCost=195,castTime=0,dotTotal=390,dotDuration=12,dotCoeff=0.8,cd=0,level=40,id=8910},
    S{name="Rejuvenation",rank=8,school=4,spellType="hot",manaCost=235,castTime=0,dotTotal=492,dotDuration=12,dotCoeff=0.8,cd=0,level=46,id=9839},
    S{name="Rejuvenation",rank=9,school=4,spellType="hot",manaCost=280,castTime=0,dotTotal=612,dotDuration=12,dotCoeff=0.8,cd=0,level=52,id=9840},
    S{name="Rejuvenation",rank=10,school=4,spellType="hot",manaCost=335,castTime=0,dotTotal=756,dotDuration=12,dotCoeff=0.8,cd=0,level=58,id=9841},
    S{name="Rejuvenation",rank=11,school=4,spellType="hot",manaCost=360,castTime=0,dotTotal=888,dotDuration=12,dotCoeff=0.8,cd=0,level=60,id=25299},

    -- TRANQUILITY
    S{name="Tranquility",rank=1,school=4,spellType="ch_heal",minDmg=352,maxDmg=352,manaCost=750,castTime=4,hpCoeff=0.133,cd=1800,level=30,id=740},
    S{name="Tranquility",rank=2,school=4,spellType="ch_heal",minDmg=528,maxDmg=528,manaCost=1010,castTime=6,hpCoeff=0.2,cd=1800,level=40,id=8918},
    S{name="Tranquility",rank=3,school=4,spellType="ch_heal",minDmg=704,maxDmg=704,manaCost=1390,castTime=8,hpCoeff=0.266,cd=1800,level=50,id=9862},
    S{name="Tranquility",rank=4,school=4,spellType="ch_heal",minDmg=880,maxDmg=880,manaCost=1850,castTime=10,hpCoeff=0.333,cd=1800,level=60,id=9863},
}

-- ============================================================================
-- SHAMAN
-- ============================================================================
SPELLCALC_SPELLS["SHAMAN"] = {
    -- LIGHTNING BOLT
    S{name="Lightning Bolt",rank=1,school=4,spellType="damage",minDmg=13,maxDmg=15,manaCost=15,castTime=1.5,spCoeff=0.123,cd=0,level=1,id=403},
    S{name="Lightning Bolt",rank=2,school=4,spellType="damage",minDmg=26,maxDmg=30,manaCost=25,castTime=2,spCoeff=0.314,cd=0,level=8,id=529},
    S{name="Lightning Bolt",rank=3,school=4,spellType="damage",minDmg=45,maxDmg=53,manaCost=40,castTime=2.5,spCoeff=0.553,cd=0,level=14,id=548},
    S{name="Lightning Bolt",rank=4,school=4,spellType="damage",minDmg=83,maxDmg=95,manaCost=70,castTime=3,spCoeff=0.857,cd=0,level=20,id=915},
    S{name="Lightning Bolt",rank=5,school=4,spellType="damage",minDmg=125,maxDmg=143,manaCost=95,castTime=3,spCoeff=0.857,cd=0,level=26,id=943},
    S{name="Lightning Bolt",rank=6,school=4,spellType="damage",minDmg=172,maxDmg=194,manaCost=125,castTime=3,spCoeff=0.857,cd=0,level=32,id=6041},
    S{name="Lightning Bolt",rank=7,school=4,spellType="damage",minDmg=227,maxDmg=255,manaCost=150,castTime=3,spCoeff=0.857,cd=0,level=38,id=10391},
    S{name="Lightning Bolt",rank=8,school=4,spellType="damage",minDmg=282,maxDmg=316,manaCost=175,castTime=3,spCoeff=0.857,cd=0,level=44,id=10392},
    S{name="Lightning Bolt",rank=9,school=4,spellType="damage",minDmg=347,maxDmg=389,manaCost=210,castTime=3,spCoeff=0.857,cd=0,level=50,id=15207},
    S{name="Lightning Bolt",rank=10,school=4,spellType="damage",minDmg=419,maxDmg=467,manaCost=240,castTime=3,spCoeff=0.857,cd=0,level=56,id=15208},

    -- CHAIN LIGHTNING
    S{name="Chain Lightning",rank=1,school=4,spellType="damage",minDmg=191,maxDmg=217,manaCost=280,castTime=2.5,spCoeff=0.714,cd=6,level=32,id=421},
    S{name="Chain Lightning",rank=2,school=4,spellType="damage",minDmg=277,maxDmg=311,manaCost=380,castTime=2.5,spCoeff=0.714,cd=6,level=40,id=930},
    S{name="Chain Lightning",rank=3,school=4,spellType="damage",minDmg=378,maxDmg=424,manaCost=490,castTime=2.5,spCoeff=0.714,cd=6,level=48,id=2860},
    S{name="Chain Lightning",rank=4,school=4,spellType="damage",minDmg=493,maxDmg=551,manaCost=605,castTime=2.5,spCoeff=0.714,cd=6,level=56,id=10605},

    -- MOLTEN BLAST  (Koeffizient geschaetzt)
    S{name="Molten Blast",rank=1,school=3,spellType="damage",minDmg=61,maxDmg=73,manaCost=65,castTime=2,spCoeff=0.571,cd=0,level=20,id=36916},
    S{name="Molten Blast",rank=2,school=3,spellType="damage",minDmg=96,maxDmg=120,manaCost=95,castTime=2,spCoeff=0.571,cd=0,level=28,id=36917},
    S{name="Molten Blast",rank=3,school=3,spellType="damage",minDmg=136,maxDmg=155,manaCost=120,castTime=2,spCoeff=0.571,cd=0,level=36,id=36918},
    S{name="Molten Blast",rank=4,school=3,spellType="damage",minDmg=185,maxDmg=204,manaCost=145,castTime=2,spCoeff=0.571,cd=0,level=44,id=36919},
    S{name="Molten Blast",rank=5,school=3,spellType="damage",minDmg=238,maxDmg=268,manaCost=175,castTime=2,spCoeff=0.571,cd=0,level=52,id=36920},
    S{name="Molten Blast",rank=6,school=3,spellType="damage",minDmg=290,maxDmg=331,manaCost=210,castTime=2,spCoeff=0.571,cd=0,level=60,id=36921},

    -- EARTHQUAKE  (Koeffizient geschaetzt)
    S{name="Earthquake",rank=1,school=4,spellType="damage",minDmg=262,maxDmg=291,manaCost=225,castTime=2.5,spCoeff=0.357,cd=16,level=40,isAoE=true,id=48306},
    S{name="Earthquake",rank=2,school=4,spellType="damage",minDmg=395,maxDmg=446,manaCost=335,castTime=2.5,spCoeff=0.357,cd=16,level=50,isAoE=true,id=48307},
    S{name="Earthquake",rank=3,school=4,spellType="damage",minDmg=587,maxDmg=634,manaCost=440,castTime=2.5,spCoeff=0.357,cd=16,level=60,isAoE=true,id=48308},

    -- EARTH SHOCK
    S{name="Earth Shock",rank=1,school=4,spellType="damage",minDmg=17,maxDmg=19,manaCost=30,castTime=0,spCoeff=0.154,cd=6,level=4,id=8042},
    S{name="Earth Shock",rank=2,school=4,spellType="damage",minDmg=32,maxDmg=34,manaCost=50,castTime=0,spCoeff=0.212,cd=6,level=8,id=8044},
    S{name="Earth Shock",rank=3,school=4,spellType="damage",minDmg=60,maxDmg=64,manaCost=85,castTime=0,spCoeff=0.299,cd=6,level=14,id=8045},
    S{name="Earth Shock",rank=4,school=4,spellType="damage",minDmg=119,maxDmg=127,manaCost=145,castTime=0,spCoeff=0.386,cd=6,level=24,id=8046},
    S{name="Earth Shock",rank=5,school=4,spellType="damage",minDmg=225,maxDmg=239,manaCost=240,castTime=0,spCoeff=0.386,cd=6,level=36,id=10412},
    S{name="Earth Shock",rank=6,school=4,spellType="damage",minDmg=359,maxDmg=381,manaCost=345,castTime=0,spCoeff=0.386,cd=6,level=48,id=10413},
    S{name="Earth Shock",rank=7,school=4,spellType="damage",minDmg=492,maxDmg=520,manaCost=450,castTime=0,spCoeff=0.386,cd=6,level=60,id=10414},

    -- FLAME SHOCK  (Koeffizient geschaetzt)
    S{name="Flame Shock",rank=1,school=3,spellType="dd+dot",minDmg=21,maxDmg=21,manaCost=55,castTime=0,spCoeff=0.134,dotTotal=35,dotDuration=15,dotCoeff=0.406,cd=6,level=10,id=8050},
    S{name="Flame Shock",rank=2,school=3,spellType="dd+dot",minDmg=45,maxDmg=45,manaCost=95,castTime=0,spCoeff=0.198,dotTotal=60,dotDuration=15,dotCoeff=0.601,cd=6,level=18,id=8052},
    S{name="Flame Shock",rank=3,school=3,spellType="dd+dot",minDmg=86,maxDmg=86,manaCost=160,castTime=0,spCoeff=0.214,dotTotal=120,dotDuration=15,dotCoeff=0.65,cd=6,level=28,id=8053},
    S{name="Flame Shock",rank=4,school=3,spellType="dd+dot",minDmg=152,maxDmg=152,manaCost=250,castTime=0,spCoeff=0.214,dotTotal=210,dotDuration=15,dotCoeff=0.65,cd=6,level=40,id=10447},
    S{name="Flame Shock",rank=5,school=3,spellType="dd+dot",minDmg=198,maxDmg=198,manaCost=345,castTime=0,spCoeff=0.214,dotTotal=280,dotDuration=15,dotCoeff=0.65,cd=6,level=52,id=10448},
    S{name="Flame Shock",rank=6,school=3,spellType="dd+dot",minDmg=293,maxDmg=293,manaCost=410,castTime=0,spCoeff=0.214,dotTotal=410,dotDuration=15,dotCoeff=0.65,cd=6,level=60,id=29228},

    -- FROST SHOCK
    S{name="Frost Shock",rank=1,school=5,spellType="damage",minDmg=89,maxDmg=95,manaCost=115,castTime=0,spCoeff=0.386,cd=6,level=20,id=8056},
    S{name="Frost Shock",rank=2,school=5,spellType="damage",minDmg=206,maxDmg=220,manaCost=225,castTime=0,spCoeff=0.386,cd=6,level=34,id=8058},
    S{name="Frost Shock",rank=3,school=5,spellType="damage",minDmg=333,maxDmg=353,manaCost=325,castTime=0,spCoeff=0.386,cd=6,level=46,id=10472},
    S{name="Frost Shock",rank=4,school=5,spellType="damage",minDmg=436,maxDmg=464,manaCost=430,castTime=0,spCoeff=0.386,cd=6,level=58,id=10473},

    -- HEALING WAVE
    S{name="Healing Wave",rank=1,school=4,spellType="heal",minDmg=34,maxDmg=44,manaCost=25,castTime=1.5,hpCoeff=0.123,cd=0,level=1,id=331},
    S{name="Healing Wave",rank=2,school=4,spellType="heal",minDmg=64,maxDmg=78,manaCost=45,castTime=2,hpCoeff=0.271,cd=0,level=6,id=332},
    S{name="Healing Wave",rank=3,school=4,spellType="heal",minDmg=129,maxDmg=155,manaCost=80,castTime=2.5,hpCoeff=0.5,cd=0,level=12,id=547},
    S{name="Healing Wave",rank=4,school=4,spellType="heal",minDmg=268,maxDmg=316,manaCost=155,castTime=3,hpCoeff=0.793,cd=0,level=18,id=913},
    S{name="Healing Wave",rank=5,school=4,spellType="heal",minDmg=376,maxDmg=440,manaCost=200,castTime=3,hpCoeff=0.857,cd=0,level=24,id=939},
    S{name="Healing Wave",rank=6,school=4,spellType="heal",minDmg=536,maxDmg=622,manaCost=265,castTime=3,hpCoeff=0.857,cd=0,level=32,id=959},
    S{name="Healing Wave",rank=7,school=4,spellType="heal",minDmg=740,maxDmg=854,manaCost=340,castTime=3,hpCoeff=0.857,cd=0,level=40,id=8005},
    S{name="Healing Wave",rank=8,school=4,spellType="heal",minDmg=1017,maxDmg=1167,manaCost=440,castTime=3,hpCoeff=0.857,cd=0,level=48,id=10395},
    S{name="Healing Wave",rank=9,school=4,spellType="heal",minDmg=1367,maxDmg=1561,manaCost=560,castTime=3,hpCoeff=0.857,cd=0,level=56,id=10396},
    S{name="Healing Wave",rank=10,school=4,spellType="heal",minDmg=1620,maxDmg=1850,manaCost=620,castTime=3,hpCoeff=0.857,cd=0,level=60,id=25357},

    -- LESSER HEALING WAVE
    S{name="Lesser Healing Wave",rank=1,school=4,spellType="heal",minDmg=162,maxDmg=186,manaCost=105,castTime=1.5,hpCoeff=0.429,cd=0,level=20,id=8004},
    S{name="Lesser Healing Wave",rank=2,school=4,spellType="heal",minDmg=247,maxDmg=281,manaCost=145,castTime=1.5,hpCoeff=0.429,cd=0,level=28,id=8008},
    S{name="Lesser Healing Wave",rank=3,school=4,spellType="heal",minDmg=337,maxDmg=381,manaCost=185,castTime=1.5,hpCoeff=0.429,cd=0,level=36,id=8010},
    S{name="Lesser Healing Wave",rank=4,school=4,spellType="heal",minDmg=458,maxDmg=514,manaCost=235,castTime=1.5,hpCoeff=0.429,cd=0,level=44,id=10466},
    S{name="Lesser Healing Wave",rank=5,school=4,spellType="heal",minDmg=631,maxDmg=705,manaCost=305,castTime=1.5,hpCoeff=0.429,cd=0,level=52,id=10467},
    S{name="Lesser Healing Wave",rank=6,school=4,spellType="heal",minDmg=832,maxDmg=928,manaCost=380,castTime=1.5,hpCoeff=0.429,cd=0,level=60,id=10468},

    -- CHAIN HEAL
    S{name="Chain Heal",rank=1,school=4,spellType="heal",minDmg=320,maxDmg=368,manaCost=260,castTime=3,hpCoeff=0.857,cd=0,level=40,id=1064},
    S{name="Chain Heal",rank=2,school=4,spellType="heal",minDmg=405,maxDmg=465,manaCost=315,castTime=3,hpCoeff=0.857,cd=0,level=46,id=10622},
    S{name="Chain Heal",rank=3,school=4,spellType="heal",minDmg=551,maxDmg=629,manaCost=405,castTime=3,hpCoeff=0.857,cd=0,level=54,id=10623},
}

-- ============================================================================
-- PALADIN
-- ============================================================================
SPELLCALC_SPELLS["PALADIN"] = {
    -- HOLY SHOCK
    S{name="Holy Shock",rank=1,school=2,spellType="damage",minDmg=97,maxDmg=104,manaCost=280,castTime=0,spCoeff=0.429,cd=20,level=38,id=20473},
    S{name="Holy Shock",rank=2,school=2,spellType="damage",minDmg=142,maxDmg=154,manaCost=335,castTime=0,spCoeff=0.429,cd=20,level=40,id=20929},
    S{name="Holy Shock",rank=3,school=2,spellType="damage",minDmg=198,maxDmg=214,manaCost=410,castTime=0,spCoeff=0.429,cd=20,level=48,id=20930},
    S{name="Holy Shock",rank=4,school=2,spellType="damage",minDmg=256,maxDmg=271,manaCost=485,castTime=0,spCoeff=0.429,cd=20,level=56,id=51786},

    -- HOLY SHOCK (HEAL)
    S{name="Holy Shock (Heal)",rank=1,school=2,spellType="heal",minDmg=311,maxDmg=320,manaCost=280,castTime=0,hpCoeff=0.429,cd=20,level=38,id=20473},
    S{name="Holy Shock (Heal)",rank=2,school=2,spellType="heal",minDmg=351,maxDmg=379,manaCost=335,castTime=0,hpCoeff=0.429,cd=20,level=40,id=20929},
    S{name="Holy Shock (Heal)",rank=3,school=2,spellType="heal",minDmg=480,maxDmg=518,manaCost=410,castTime=0,hpCoeff=0.429,cd=20,level=48,id=20930},
    S{name="Holy Shock (Heal)",rank=4,school=2,spellType="heal",minDmg=628,maxDmg=680,manaCost=485,castTime=0,hpCoeff=0.429,cd=20,level=56,id=51786},

    -- CONSECRATION
    S{name="Consecration",rank=1,school=2,spellType="dot",manaCost=120,castTime=0,dotTotal=72,dotDuration=8,dotCoeff=0.333,cd=8,level=20,isAoE=true,id=26573},
    S{name="Consecration",rank=2,school=2,spellType="dot",manaCost=205,castTime=0,dotTotal=136,dotDuration=8,dotCoeff=0.333,cd=8,level=30,isAoE=true,id=20116},
    S{name="Consecration",rank=3,school=2,spellType="dot",manaCost=290,castTime=0,dotTotal=216,dotDuration=8,dotCoeff=0.333,cd=8,level=40,isAoE=true,id=20922},
    S{name="Consecration",rank=4,school=2,spellType="dot",manaCost=390,castTime=0,dotTotal=320,dotDuration=8,dotCoeff=0.333,cd=8,level=50,isAoE=true,id=20923},
    S{name="Consecration",rank=5,school=2,spellType="dot",manaCost=505,castTime=0,dotTotal=432,dotDuration=8,dotCoeff=0.333,cd=8,level=60,isAoE=true,id=20924},

    -- EXORCISM
    S{name="Exorcism",rank=1,school=2,spellType="damage",minDmg=84,maxDmg=96,manaCost=85,castTime=0,spCoeff=0.429,cd=15,level=20,id=879},
    S{name="Exorcism",rank=2,school=2,spellType="damage",minDmg=152,maxDmg=172,manaCost=135,castTime=0,spCoeff=0.429,cd=15,level=28,id=5614},
    S{name="Exorcism",rank=3,school=2,spellType="damage",minDmg=217,maxDmg=245,manaCost=180,castTime=0,spCoeff=0.429,cd=15,level=36,id=5615},
    S{name="Exorcism",rank=4,school=2,spellType="damage",minDmg=304,maxDmg=342,manaCost=235,castTime=0,spCoeff=0.429,cd=15,level=44,id=10312},
    S{name="Exorcism",rank=5,school=2,spellType="damage",minDmg=393,maxDmg=439,manaCost=285,castTime=0,spCoeff=0.429,cd=15,level=52,id=10313},
    S{name="Exorcism",rank=6,school=2,spellType="damage",minDmg=505,maxDmg=563,manaCost=345,castTime=0,spCoeff=0.429,cd=15,level=60,id=10314},

    -- HAMMER OF WRATH
    S{name="Hammer of Wrath",rank=1,school=2,spellType="damage",minDmg=304,maxDmg=336,manaCost=295,castTime=1,spCoeff=0.429,cd=6,level=44,id=24275},
    S{name="Hammer of Wrath",rank=2,school=2,spellType="damage",minDmg=399,maxDmg=441,manaCost=360,castTime=1,spCoeff=0.429,cd=6,level=52,id=24274},
    S{name="Hammer of Wrath",rank=3,school=2,spellType="damage",minDmg=504,maxDmg=556,manaCost=425,castTime=1,spCoeff=0.429,cd=6,level=60,id=24239},

    -- HOLY WRATH
    S{name="Holy Wrath",rank=1,school=2,spellType="damage",minDmg=362,maxDmg=428,manaCost=645,castTime=2,spCoeff=0.19,cd=60,level=50,isAoE=true,id=2812},
    S{name="Holy Wrath",rank=2,school=2,spellType="damage",minDmg=490,maxDmg=576,manaCost=805,castTime=2,spCoeff=0.19,cd=60,level=60,isAoE=true,id=10318},

    -- FLASH OF LIGHT
    S{name="Flash of Light",rank=1,school=2,spellType="heal",minDmg=62,maxDmg=72,manaCost=35,castTime=1.5,hpCoeff=0.429,cd=0,level=20,id=19750},
    S{name="Flash of Light",rank=2,school=2,spellType="heal",minDmg=96,maxDmg=110,manaCost=50,castTime=1.5,hpCoeff=0.429,cd=0,level=26,id=19939},
    S{name="Flash of Light",rank=3,school=2,spellType="heal",minDmg=145,maxDmg=163,manaCost=70,castTime=1.5,hpCoeff=0.429,cd=0,level=34,id=19940},
    S{name="Flash of Light",rank=4,school=2,spellType="heal",minDmg=197,maxDmg=221,manaCost=90,castTime=1.5,hpCoeff=0.429,cd=0,level=42,id=19941},
    S{name="Flash of Light",rank=5,school=2,spellType="heal",minDmg=267,maxDmg=299,manaCost=115,castTime=1.5,hpCoeff=0.429,cd=0,level=50,id=19942},
    S{name="Flash of Light",rank=6,school=2,spellType="heal",minDmg=343,maxDmg=383,manaCost=140,castTime=1.5,hpCoeff=0.429,cd=0,level=58,id=19943},
    S{name="Flash of Light",rank=7,school=2,spellType="heal",minDmg=428,maxDmg=493,manaCost=180,castTime=1.5,hpCoeff=0.429,cd=0,level=60,id=51743},

    -- HOLY LIGHT
    S{name="Holy Light",rank=1,school=2,spellType="heal",minDmg=39,maxDmg=47,manaCost=35,castTime=2.5,hpCoeff=0.205,cd=0,level=1,id=635},
    S{name="Holy Light",rank=2,school=2,spellType="heal",minDmg=76,maxDmg=90,manaCost=60,castTime=2.5,hpCoeff=0.339,cd=0,level=6,id=639},
    S{name="Holy Light",rank=3,school=2,spellType="heal",minDmg=159,maxDmg=187,manaCost=110,castTime=2.5,hpCoeff=0.553,cd=0,level=14,id=647},
    S{name="Holy Light",rank=4,school=2,spellType="heal",minDmg=310,maxDmg=356,manaCost=190,castTime=2.5,hpCoeff=0.714,cd=0,level=22,id=1026},
    S{name="Holy Light",rank=5,school=2,spellType="heal",minDmg=491,maxDmg=553,manaCost=275,castTime=2.5,hpCoeff=0.714,cd=0,level=30,id=1042},
    S{name="Holy Light",rank=6,school=2,spellType="heal",minDmg=698,maxDmg=780,manaCost=365,castTime=2.5,hpCoeff=0.714,cd=0,level=38,id=3472},
    S{name="Holy Light",rank=7,school=2,spellType="heal",minDmg=945,maxDmg=1053,manaCost=465,castTime=2.5,hpCoeff=0.714,cd=0,level=46,id=10328},
    S{name="Holy Light",rank=8,school=2,spellType="heal",minDmg=1246,maxDmg=1388,manaCost=580,castTime=2.5,hpCoeff=0.714,cd=0,level=54,id=10329},
    S{name="Holy Light",rank=9,school=2,spellType="heal",minDmg=1590,maxDmg=1770,manaCost=660,castTime=2.5,hpCoeff=0.714,cd=0,level=60,id=25292},
}



-- ============================================================================
-- TALENT MODIFIERS
-- ============================================================================

SPELLCALC_TALENTS = {}

-- [patch] Talentwerte gegen die Client-Daten von OctoWoW geprueft
-- (Talent.dbc/Spell.dbc aus patch-4.mpq bzw. patch-O.mpq, 2026-10-02).
-- Die Talentbaeume weichen teils stark von Classic 1.12 ab.
--   perRank   linearer Bonus pro Rang
--   values    Bonus je Rang, wenn nicht linear
--   part      "direct" oder "dot": wirkt nur auf diesen Teil des Zaubers
--   key       eigener Name, wenn ein Talent mehrere Eintraege braucht
-- Talente, die nur Krit, Zauberzeit, Kosten oder Cooldown aendern, werden
-- (noch) nicht beruecksichtigt.

SPELLCALC_TALENTS["MAGE"] = {
    { name="Fire Power",         perRank=0.02, maxRank=5, affectType="damage", affectSchool={3} },
    { name="Piercing Ice",       perRank=0.02, maxRank=3, affectType="damage", affectSchool={5} },
    { name="Improved Cone of Cold", values={0.15, 0.25, 0.35}, maxRank=3, affectType="damage", affectSpells={"Cone of Cold"} },
    -- Proc: 8/16/25% Chance auf +25% Schaden -> Erwartungswert, nur Arkan
    { name="Arcane Instability", values={0.02, 0.04, 0.0625}, maxRank=3, affectType="damage", affectSchool={7} },
}

SPELLCALC_TALENTS["PRIEST"] = {
    { name="Darkness",           perRank=0.02, maxRank=5, affectType="damage", affectSchool={6} },
    { name="Shadowform",         perRank=0.15, maxRank=1, affectType="damage", affectSchool={6} },
    -- Schaden nur Smite, Holy Fire, Mind Blast (plus Holy Nova/Chastise, nicht in der Liste)
    { name="Force of Will",      perRank=0.01, maxRank=5, affectType="damage", affectSpells={"Smite","Holy Fire","Mind Blast"} },
    { name="Force of Will", key="Force of Will (Shield)", perRank=0.04, maxRank=5, affectType="healing", affectSpells={"Power Word: Shield"} },
    { name="Spiritual Healing",  perRank=0.06, maxRank=5, affectType="healing",
      affectSpells={"Lesser Heal","Heal","Greater Heal","Flash Heal","Renew","Prayer of Healing"} },
    { name="Improved Renew",     perRank=0.05, maxRank=3, affectType="healing", affectSpells={"Renew"} },
    { name="Improved Power Word: Shield", perRank=0.05, maxRank=3, affectType="healing", affectSpells={"Power Word: Shield"} },
}

SPELLCALC_TALENTS["WARLOCK"] = {
    { name="Shadow Mastery",     perRank=0.02, maxRank=5, affectType="damage", affectSchool={6} },
    { name="Emberstorm",         perRank=0.02, maxRank=5, affectType="damage", affectSchool={3} },
    { name="Improved Immolate",  perRank=0.04, maxRank=5, affectType="damage", affectSpells={"Immolate"} },
    { name="Aftermath",          perRank=0.02, maxRank=3, affectType="damage", affectSpells={"Immolate"}, part="dot" },
    { name="Improved Curse of Agony", values={0.03, 0.06, 0.10}, maxRank=3, affectType="damage", affectSpells={"Curse of Agony"} },
    { name="Improved Drains",    perRank=0.05, maxRank=2, affectType="damage", affectSpells={"Drain Life"} },
}

SPELLCALC_TALENTS["DRUID"] = {
    { name="Moonfury",           perRank=0.04, maxRank=3, affectType="damage",
      affectSpells={"Wrath","Starfire","Moonfire","Insect Swarm","Hurricane"} },
    { name="Improved Moonfire",  perRank=0.05, maxRank=2, affectType="damage", affectSpells={"Moonfire"} },
    { name="Genesis",            perRank=0.05, maxRank=3, affectType="both", part="dot",
      affectSpells={"Moonfire","Insect Swarm","Hurricane","Rejuvenation","Regrowth","Tranquility"} },
    { name="Gift of Nature",     perRank=0.02, maxRank=5, affectType="healing", affectSchool="all" },
    { name="Improved Tranquility", perRank=0.20, maxRank=2, affectType="healing", affectSpells={"Tranquility"} },
}

SPELLCALC_TALENTS["SHAMAN"] = {
    { name="Concussion",         perRank=0.01, maxRank=5, affectType="damage",
      affectSpells={"Lightning Bolt","Chain Lightning","Earth Shock","Flame Shock","Frost Shock"} },
    { name="Call of Flame",      perRank=0.05, maxRank=3, affectType="damage", affectSpells={"Flame Shock"} },
    { name="Elemental Fury",     perRank=0.05, maxRank=2, affectType="damage", affectSchool={3,4,5} },
}

SPELLCALC_TALENTS["PALADIN"] = {
    { name="Healing Light",      perRank=0.04, maxRank=3, affectType="healing",
      affectSpells={"Flash of Light","Holy Light","Holy Shock (Heal)"} },
}
