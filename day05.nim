#!/usr/bin/env -S nim -r c
import algorithm, sequtils
var results: set[int16]
for l in stdin.lines:
  var i = 0
  proc m(a, key: auto): int =
    result = if i == key.len: 0 elif key[i] in "FL": 1 else: -1
    inc i
  let r = binarySearch(newSeq[int](128), l[0..^4], m)
  i = 0
  let c = binarySearch(newSeq[int](8), l[^3..^1], m)
  results.incl(int16(r * 8 + c))
echo max(toSeq(results)) # Part 1
for i in 0'i16..128*8:
  if i-1 in results and i notin results and i+1 in results:
    echo i # Part 2
