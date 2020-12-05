#!/usr/bin/env -S nim -r c
import algorithm
var s: array[128*8, bool]
for l in stdin.lines:
  var i = 0
  proc m(s, k: auto): int =
    result = if i == k.len: 0 elif k[i] in "FL": 1 else: -1
    inc i
  s[binarySearch(s, l, m)] = true
for i in countdown(s.high, s.low):
  if s[i]:
    echo i # Part 1
    break
for i in s.low+1 .. s.high:
  if s[i-1] and not s[i] and s[i+1]:
    echo i # Part 2
