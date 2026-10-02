from dbc import *
import re
AOE_TARGETS={8,15,16,20,22,24,28,30,33,34,37,52,53,54,56,61}
def parse(sid):
    r=SPELL[sid]
    o=dict(id=sid,name=sstr(r[120]),rank=sstr(r[129]),school=r[1],mana=r[32],manapct=r[156],
           cast=CAST.get(r[18],0)/1000,cd=max(r[19],r[20])/1000,lvl=r[29],dur=DUR.get(r[30],0)/1000,
           fam=(r[162]<<32)|r[161],attrEx=r[7],chan=False,aoe=False)
    for k in range(3):
        e=eff(sid,k)
        if not e['effect']: continue
        tA,tB=SPELL[sid][82+k],SPELL[sid][85+k]
        if tA in AOE_TARGETS or tB in AOE_TARGETS: o['aoe']=True
        lo=e['bp']+1; hi=e['bp']+max(e['die'],1)
        if e['effect'] in (2,10,9) and 'lo' not in o:
            o['lo'],o['hi']=lo,hi; o['dkind']='heal' if e['effect']==10 else 'dmg'
        elif e['effect'] in (6,27,35) and e['aura'] in (3,8,53) and e['amp']:
            n=int(round(o['dur']*1000/e['amp']))
            o['tick']=lo; o['ticks']=n; o['amp']=e['amp']/1000; o['ptotal']=lo*n
            o['pkind']='hot' if e['aura']==8 else 'dot'
            if o['dur']>0 and r[23]: o['chan']=True
        elif e['effect'] in (6,27) and e['aura']==23 and e['amp'] and e['trig'] in SPELL:
            t=parse(e['trig']); n=int(round(o['dur']*1000/e['amp']))
            if 'lo' in t:
                o['tick']=(t['lo']+t['hi'])/2; o['ticks']=n; o['amp']=e['amp']/1000; o['ptotal']=o['tick']*n
                o['pkind']='hot' if t.get('dkind')=='heal' else 'dot'; o['chan']=bool(r[23]); o['trig']=e['trig']
                if t['aoe']: o['aoe']=True
        elif e['effect']==6 and e['aura']==69:
            o['lo']=o['hi']=lo; o['dkind']='absorb'
    if r[23] and o['dur']>0: o['chan']=True
    return o
