from gen_core import *
import re

FAM = {'MAGE': 3, 'WARLOCK': 5, 'PRIEST': 6, 'DRUID': 7, 'PALADIN': 10, 'SHAMAN': 11}
sla, _ = load('SkillLineAbility.dbc')
SLA = set(r[2] for r in sla)

BYNAME = {}
for sid, r in SPELL.items():
    BYNAME.setdefault(sstr(r[120]), []).append(sid)

def ranks_for(cls, name, want=None, fam_strict=True):
    """Return {rank: sid} for player-learnable ranks of a spell."""
    out = {}
    cands = BYNAME.get(name, [])
    if any(s in SLA for s in cands) and fam_strict:
        # if the spell is in the class skill line, only take those entries
        # (otherwise old/foreign ranks with the same name slip in)
        slac = [s for s in cands if s in SLA]
        if not want or any(want(parse(s)) for s in slac):
            cands = slac
    for sid in cands:
        r = SPELL[sid]
        m = re.match(r'Rank (\d+)$', sstr(r[129]))
        if not m or r[29] <= 0 or r[29] > 60: continue
        if fam_strict and r[160] != FAM[cls]: continue
        if not fam_strict and sid not in SLA: continue
        o = parse(sid)
        if want and not want(o): continue
        rk = int(m.group(1))
        score = (sid in SLA, r[32] > 0 or r[156] > 0, -sid)
        if rk not in out or score > out[rk][0]:
            out[rk] = (score, sid)
    if not out and fam_strict:
        return ranks_for(cls, name, want, False)
    return {k: v[1] for k, v in sorted(out.items())}

# name, type, direct coeff (top rank), periodic coeff (top rank), flags
# est = coefficient estimated (Turtle/OctoWoW spells without known values)
SPELLS = {
 'MAGE': [
  ('Frostbolt', 'damage', 0.814, 0, {}),
  ('Fireball', 'dd+dot', 1.0, 0.0, {}),
  ('Fire Blast', 'damage', 0.429, 0, {}),
  ('Scorch', 'damage', 0.429, 0, {}),
  ('Pyroblast', 'dd+dot', 1.0, 0.15, {}),
  ('Flamestrike', 'dd+dot', 0.274, 0.039, {}),
  ('Blast Wave', 'damage', 0.136, 0, {}),
  ('Cone of Cold', 'damage', 0.129, 0, {}),
  ('Frost Nova', 'damage', 0.032, 0, {}),
  ('Arcane Missiles', 'ch_dmg', 0, 1.0, {'crit': True}),
  ('Arcane Explosion', 'damage', 0.143, 0, {}),
  ('Arcane Rupture', 'damage', 0.714, 0, {'est': True}),
  ('Arcane Surge', 'damage', 0.429, 0, {'est': True}),
  ('Blizzard', 'ch_dmg', 0, 0.333, {}),
 ],
 'PRIEST': [
  ('Smite', 'damage', 0.714, 0, {}),
  ('Holy Fire', 'dd+dot', 0.75, 0.167, {}),
  ('Holy Nova', 'damage', 0.107, 0, {'want': 'dmg'}),
  ('Chastise', 'damage', 0.429, 0, {'est': True}),
  ('Mind Blast', 'damage', 0.429, 0, {}),
  ('Pain Spike', 'damage', 0.429, 0, {'est': True}),
  ('Shadow Word: Pain', 'dot', 0, 1.0, {}),
  ('Mind Flay', 'ch_dmg', 0, 0.429, {}),
  ('Devouring Plague', 'dot', 0, 1.0, {}),
  ('Starshards', 'ch_dmg', 0, 0.835, {}),
  ('Flash Heal', 'heal', 0.429, 0, {}),
  ('Greater Heal', 'heal', 0.857, 0, {}),
  ('Heal', 'heal', 0.857, 0, {}),
  ('Lesser Heal', 'heal', 0.714, 0, {}),
  ('Renew', 'hot', 0, 1.0, {}),
  ('Prayer of Healing', 'heal', 0.286, 0, {}),
  ('Holy Nova', 'heal', 0.161, 0, {'want': 'heal', 'label': 'Holy Nova (Heal)'}),
  ('Desperate Prayer', 'heal', 0.429, 0, {}),
  ('Power Word: Shield', 'heal', 0.1, 0, {'noscale': True, 'nocrit': True}),
 ],
 'WARLOCK': [
  ('Shadow Bolt', 'damage', 0.857, 0, {}),
  ('Corruption', 'dot', 0, 1.0, {}),
  ('Curse of Agony', 'dot', 0, 1.0, {}),
  ('Siphon Life', 'dot', 0, 0.5, {}),
  ('Immolate', 'dd+dot', 0.157, 0.651, {}),
  ('Searing Pain', 'damage', 0.571, 0, {}),
  ('Soul Fire', 'damage', 1.0, 0, {}),
  ('Shadowburn', 'damage', 0.429, 0, {}),
  ('Death Coil', 'damage', 0.214, 0, {}),
  ('Conflagrate', 'damage', 0.429, 0, {}),
  ('Drain Life', 'ch_dmg', 0, 0.714, {}),
  ('Drain Soul', 'ch_dmg', 0, 0.5, {}),
  ('Dark Harvest', 'ch_dmg', 0, 1.0, {'est': True}),
  ('Rain of Fire', 'ch_dmg', 0, 0.333, {}),
  ('Hellfire', 'ch_dmg', 0, 0.333, {}),
 ],
 'DRUID': [
  ('Wrath', 'damage', 0.571, 0, {}),
  ('Starfire', 'damage', 1.0, 0, {}),
  ('Moonfire', 'dd+dot', 0.15, 0.78, {'est': True}),
  ('Insect Swarm', 'dot', 0, 1.0, {'est': True}),
  ('Hurricane', 'ch_dmg', 0, 0.333, {}),
  ('Healing Touch', 'heal', 1.0, 0, {}),
  ('Regrowth', 'dd+hot', 0.3, 0.7, {}),
  ('Rejuvenation', 'hot', 0, 0.8, {}),
  ('Tranquility', 'ch_heal', 0, 0.333, {}),
 ],
 'SHAMAN': [
  ('Lightning Bolt', 'damage', 0.857, 0, {}),
  ('Chain Lightning', 'damage', 0.714, 0, {}),
  ('Molten Blast', 'damage', 0.571, 0, {'est': True}),
  ('Earthquake', 'damage', 0.357, 0, {'est': True}),
  ('Earth Shock', 'damage', 0.386, 0, {}),
  ('Flame Shock', 'dd+dot', 0.214, 0.65, {'est': True}),
  ('Frost Shock', 'damage', 0.386, 0, {}),
  ('Healing Wave', 'heal', 0.857, 0, {}),
  ('Lesser Healing Wave', 'heal', 0.429, 0, {}),
  ('Chain Heal', 'heal', 0.857, 0, {}),
 ],
 'PALADIN': [
  ('Holy Shock', 'damage', 0.429, 0, {'shock': 'dmg'}),
  ('Holy Shock', 'heal', 0.429, 0, {'shock': 'heal', 'label': 'Holy Shock (Heal)'}),
  ('Consecration', 'dot', 0, 0.333, {}),
  ('Exorcism', 'damage', 0.429, 0, {}),
  ('Hammer of Wrath', 'damage', 0.429, 0, {}),
  ('Holy Wrath', 'damage', 0.19, 0, {}),
  ('Flash of Light', 'heal', 0.429, 0, {}),
  ('Holy Light', 'heal', 0.714, 0, {}),
 ],
}

def ctime(c):
    return min(max(c, 1.5), 3.5)

def level_pen(lvl):
    return 1.0 if lvl >= 20 else max(0.0, 1 - (20 - lvl) * 0.0375)

def values(cls, name, typ, flags):
    want = None
    if flags.get('want') == 'dmg': want = lambda o: o.get('dkind') == 'dmg'
    if flags.get('want') == 'heal': want = lambda o: o.get('dkind') == 'heal'
    rk = ranks_for(cls, name, want)
    out = []
    for r, sid in rk.items():
        o = parse(sid)
        if flags.get('shock'):
            # Holy Shock: the main spell only has a dummy, values are in the triggered spell
            trig = [s for s in BYNAME['Holy Shock'] if sstr(SPELL[s][129]) == 'Rank %d' % r
                    and parse(s).get('dkind') == flags['shock']]
            if not trig: continue
            t = parse(trig[0]); o['lo'], o['hi'] = t['lo'], t['hi']
        if name == 'Flash of Light' and 'lo' not in o:
            e = eff(sid, 0)
            o['lo'], o['hi'] = e['bp'] + 1, e['bp'] + e['die']
        if name == 'Tranquility' and 'ptotal' not in o:
            e = eff(sid, 0)
            n = int(round(o['dur'] / (e['amp'] / 1000)))
            o['ptotal'] = (e['bp'] + 1) * n
        if flags.get('want') == 'heal' and o['mana'] == 0:
            dm = ranks_for(cls, name, lambda x: x.get('dkind') == 'dmg').get(r)
            if dm: o['mana'] = SPELL[dm][32]; o['cast'] = parse(dm)['cast']; o['cd'] = parse(dm)['cd']
        out.append((r, o))
    return out

def fmt(x):
    s = ('%.3f' % x).rstrip('0').rstrip('.')
    return s if s else '0'

def gen():
    lines = []
    for cls, spells in SPELLS.items():
        lines.append('')
        lines.append('-- ' + '=' * 76)
        lines.append('-- ' + cls)
        lines.append('-- ' + '=' * 76)
        lines.append('SPELLCALC_SPELLS["%s"] = {' % cls)
        for name, typ, cd_, cp_, flags in spells:
            vals = values(cls, name, typ, flags)
            if not vals:
                lines.append('    -- %s: nicht im Client gefunden' % name)
                continue
            top = vals[-1][1]
            label = flags.get('label', name)
            note = '  (coefficient estimated)' if flags.get('est') else ''
            lines.append('    -- %s%s' % (label.upper(), note))
            for r, o in vals:
                pen = level_pen(o['lvl'])
                school = o['school'] + 1
                isAoE = o['aoe']
                f = ['name="%s"' % label, 'rank=%d' % r, 'school=%d' % school, 'spellType="%s"' % typ]
                heal = typ in ('heal', 'hot', 'dd+hot', 'ch_heal')
                ck = 'hpCoeff' if heal else 'spCoeff'
                if typ in ('damage', 'heal'):
                    c = cd_ if flags.get('noscale') else cd_ * ctime(o['cast']) / ctime(top['cast'])
                    f += ['minDmg=%d' % o['lo'], 'maxDmg=%d' % o['hi'], 'manaCost=%d' % o['mana'],
                          'castTime=%g' % o['cast'], '%s=%s' % (ck, fmt(c * pen))]
                elif typ in ('dot', 'hot'):
                    p = min(1.0, cp_ * o['dur'] / top['dur']) if top['dur'] else cp_
                    f += ['manaCost=%d' % o['mana'], 'castTime=%g' % o['cast'],
                          'dotTotal=%d' % o['ptotal'], 'dotDuration=%g' % o['dur'], 'dotCoeff=%s' % fmt(p * pen)]
                elif typ in ('dd+dot', 'dd+hot'):
                    c = cd_ * ctime(o['cast']) / ctime(top['cast'])
                    p = min(1.0, cp_ * o['dur'] / top['dur']) if top['dur'] else cp_
                    f += ['minDmg=%d' % o['lo'], 'maxDmg=%d' % o['hi'], 'manaCost=%d' % o['mana'],
                          'castTime=%g' % o['cast'], '%s=%s' % (ck, fmt(c * pen)),
                          'dotTotal=%d' % o.get('ptotal', 0), 'dotDuration=%g' % o['dur'], 'dotCoeff=%s' % fmt(p * pen)]
                else:  # channel
                    p = min(1.0, cp_ * o['dur'] / top['dur']) if top['dur'] else cp_
                    tot = int(round(o.get('ptotal', 0)))
                    f += ['minDmg=%d' % tot, 'maxDmg=%d' % tot, 'manaCost=%d' % o['mana'],
                          'castTime=%g' % o['dur'], '%s=%s' % (ck, fmt(p * pen))]
                if o['mana'] == 0 and o['manapct']:
                    f.append('manaPct=%d' % o['manapct'])
                f += ['cd=%g' % o['cd'], 'level=%d' % o['lvl']]
                if isAoE: f.append('isAoE=true')
                if flags.get('crit'): f.append('canCrit=true')
                if flags.get('nocrit'): f.append('noCrit=true')
                f.append('id=%d' % o['id'])
                lines.append('    S{' + ','.join(f) + '},')
            lines.append('')
        if lines[-1] == '': lines.pop()
        lines.append('}')
    return '\n'.join(lines)

if __name__ == '__main__':
    print(gen())
