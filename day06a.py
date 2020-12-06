#!/usr/bin/env python
import sys
r = 0
for b in sys.stdin.read().split("\n\n"):
  s = set()
  for l in b.split("\n"):
    s |= set(l.rstrip("\n"))
  r += len(s)
print(r)
