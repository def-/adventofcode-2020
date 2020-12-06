#!/usr/bin/env python
import sys
r = 0
s = set()
for l in sys.stdin:
  l = l.rstrip("\n")
  if l:
    for c in l:
      s.add(c)
  else:
    r += len(s)
    s = set()
print(r)
