# Meal rotation macro calculator - breakfast carb revision
import itertools

ING = {  # per 100 g: (P, C, F)
    'chicken':     (31, 0, 3.6),
    'beef':        (26, 0, 11),
    'steak':       (29, 0, 9),
    'salmon':      (25, 0, 13),
    'tuna_fresh':  (29, 0, 6),
    'tuna_can':    (25, 0, 1),
    'turkey':      (27, 0, 8),
    'eggwhite':    (11, 0, 0),
    'gy2':         (10, 4, 2),
    'gy0':         (10, 4, 0),
    'cottage':     (11, 3.5, 4.3),
    'whey':        (80, 8, 5),
    'rice':        (2.7, 28, 0.3),
    'potato':      (2, 17, 0.1),
    'pasta':       (5, 30, 1.1),
    'quinoa':      (4.4, 21, 1.9),
    'oats':        (13, 60, 7),
    'bread':       (10, 43, 3.5),
    'banana100':   (1.1, 23, 0.3),
    'berries':     (0.8, 9, 0.4),
    'almonds':     (21, 9, 50),
    'almondbutter':(21, 19, 56),
    'oliveoil':    (0, 0, 100),
    'avocado':     (2, 9, 15),
    'chia':        (17, 8, 31),
    'veg':         (2, 6.5, 0.3),
    'tomatosauce': (2, 7, 0.5),
}
UNIT = {'egg': (6.3, 0.4, 5.0), 'banana': (1.3, 27, 0.4), 'apple': (0.5, 21, 0.3)}

def cal(m): return 4*m[0] + 4*m[1] + 9*m[2]
def g(item, grams):
    p, c, f = ING[item]; k = grams/100.0
    return (p*k, c*k, f*k)
def u(item, n):
    p, c, f = UNIT[item]; return (p*n, c*n, f*n)
def add(*ms): return tuple(sum(x) for x in zip(*ms))
def show(m): return f"P{m[0]:.0f} C{m[1]:.0f} F{m[2]:.0f}  {cal(m):.0f} kcal"

TIERS = {'Rest': 34, 'Easy': 40, 'Quality': 56, 'Long': 69}

def carb(food, carb_g):
    grams = carb_g / ING[food][1] * 100.0
    return grams, g(food, grams)

breakfasts = {
    'B1 Eggs & potato hash':      (add(u('egg',3), g('eggwhite',130), g('oliveoil',6)),            'potato'),
    'B2 Banana protein pancakes': (add(u('egg',2), g('eggwhite',100), g('whey',15),
                                       g('almondbutter',12), g('berries',80), g('oliveoil',5)),   'banana100'),
    'B3 Eggs & toast':            (add(u('egg',3), g('eggwhite',190)),                             'bread'),
    'B4 Overnight oats':          (add(g('gy0',150), g('whey',25), g('chia',15),
                                       g('berries',80), g('almonds',25)),                         'oats'),
}
lunches = {
    'L1 Chicken & rice':      (add(g('chicken',130), g('veg',150), g('oliveoil',12)),             'rice'),
    'L2 Beef & potato':       (add(g('beef',140), g('veg',200), g('oliveoil',6)),                 'potato'),
    'L3 Tuna & quinoa bowl':  (add(g('tuna_can',140), g('veg',150), g('oliveoil',14)),            'quinoa'),
    'L4 Turkey pasta':        (add(g('turkey',130), g('tomatosauce',100), g('veg',100), g('oliveoil',8)), 'pasta'),
}
dinners = {
    'D1 Chicken stir-fry':    (add(g('chicken',135), g('veg',250), g('oliveoil',13)),             'rice'),
    'D2 Salmon & potato':     (add(g('salmon',135), g('veg',250), g('oliveoil',6)),               'potato'),
    'D3 Steak & veg':         (add(g('steak',135), g('veg',300), g('oliveoil',6)),                'potato'),
    'D4 Turkey meatballs':    (add(g('turkey',140), g('tomatosauce',150), g('veg',100), g('oliveoil',8)), 'pasta'),
}
snacks = {
    'S1 Yogurt & almonds':    add(g('gy2',250), g('whey',15), g('almonds',20), g('berries',80)),
    'S2 Cottage cheese bowl': add(g('cottage',250), g('whey',15), u('apple',1)),
    'S3 Shake & fruit':       add(g('whey',35), u('apple',1), g('almondbutter',16)),
}
shakes = {
    'Post-session shake': add(g('whey',40), u('banana',1)),
    'Break-fast shake':   add(g('whey',25), g('gy0',200), g('berries',80), g('almondbutter',15)),
}

def meal_card(name, fixed, cf, tiers):
    print(f"  {name}  [carb: {cf}]")
    print(f"    fixed anchor: {show(fixed)}")
    for t in tiers:
        grams, cm = carb(cf, TIERS[t])
        print(f"    {t:8s} ({grams:.0f}g {cf}): {show(add(fixed, cm))}")

print("="*64, "\nBREAKFASTS\n", "="*64, sep="")
for n,(fx,cf) in breakfasts.items(): meal_card(n, fx, cf, ['Easy','Quality','Long'])

def tt(meal, tier):
    fixed, cf = meal
    _, cm = carb(cf, TIERS[tier])
    return add(fixed, cm)

def scan(label, target, builder):
    results = [builder(*c) for c in combos]
    cals = [cal(m) for m in results]
    ps, cs, fs = [m[0] for m in results], [m[1] for m in results], [m[2] for m in results]
    print(f"\n{label} (target {target})")
    print(f"  kcal  min {min(cals):.0f}  mean {sum(cals)/len(cals):.0f}  max {max(cals):.0f}")
    print(f"  P min {min(ps):.0f} max {max(ps):.0f} | C min {min(cs):.0f} max {max(cs):.0f} | F min {min(fs):.0f} max {max(fs):.0f}")

print("\n", "="*64, "\nDAY-TYPE SCANS\n", "="*64, sep="")
combos = list(itertools.product(breakfasts.values(), lunches.values(), dinners.values()))
scan("EASY    B.Easy + postshake + L.Easy + D.Easy", 2050,
     lambda B,L,D: add(tt(B,'Easy'), shakes['Post-session shake'], tt(L,'Easy'), tt(D,'Easy')))
scan("QUALITY B.Quality + postshake + L.Quality + D.Quality", 2300,
     lambda B,L,D: add(tt(B,'Quality'), shakes['Post-session shake'], tt(L,'Quality'), tt(D,'Quality')))
scan("LONG    B.Long + postshake + L.Long + D.Long", 2500,
     lambda B,L,D: add(tt(B,'Long'), shakes['Post-session shake'], tt(L,'Long'), tt(D,'Long')))
