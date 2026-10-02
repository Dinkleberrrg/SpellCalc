import re, sys

def tokens(src):
    i, n = 0, len(src)
    line = 1
    while i < n:
        c = src[i]
        if c == '\n':
            line += 1; i += 1; continue
        if src.startswith('--[[', i):
            j = src.index(']]', i); line += src.count('\n', i, j); i = j + 2; continue
        if src.startswith('--', i):
            j = src.find('\n', i); i = n if j < 0 else j; continue
        if c in '"\'':
            j = i + 1
            while src[j] != c:
                if src[j] == '\\': j += 1
                if src[j] == '\n': raise SystemExit('unterminated string line %d' % line)
                j += 1
            i = j + 1; continue
        if src.startswith('[[', i):
            j = src.index(']]', i); line += src.count('\n', i, j); i = j + 2; continue
        m = re.match(r'[A-Za-z_][A-Za-z0-9_]*', src[i:])
        if m:
            yield m.group(0), line; i += len(m.group(0)); continue
        yield c, line; i += 1

def check(path):
    src = open(path, encoding='utf-8').read()
    stack = []
    paren = []
    for tok, line in tokens(src):
        if tok in ('function', 'if', 'do', 'repeat'):
            stack.append((tok, line))
        elif tok in ('for', 'while'):
            stack.append((tok, line))
        elif tok == 'end':
            if not stack: raise SystemExit('%s: extra end at line %d' % (path, line))
            t, l = stack.pop()
            # for/while consume their 'do'
            if t == 'do' and stack and stack[-1][0] in ('for', 'while'):
                stack.pop()
        elif tok == 'until':
            stack.pop()
        elif tok in '({[':
            paren.append((tok, line))
        elif tok in ')}]':
            if not paren: raise SystemExit('%s: extra %s line %d' % (path, tok, line))
            paren.pop()
    if stack or paren:
        raise SystemExit('%s: unclosed %s %s' % (path, stack[-3:], paren[-3:]))
    print(path, 'OK')

for p in sys.argv[1:]:
    check(p)
