#!/usr/bin/env python
import sys, collections
r = 0
s = collections.Counter()
n = 0
for l in sys.stdin:
  l = l.rstrip("\n")
  if l:
    for c in l:
      s[c] += 1
    n += 1
  else:
    for c in s:
      if s[c] == n:
        r += 1
    s = collections.Counter()
    n = 0
print(r)
