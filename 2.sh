#!/bin/sh
# Part 1
while IFS=" " read -r range char pw; do
  IFS=- read -r min max <<< "$range"
  char=$(echo "$char" | cut -c1)
  count=$(echo "$pw" | tr -cd "$char" | wc -c)
  [ "$min" -le "$count" ] && [ "$count" -le "$max" ] && echo
done | wc -l

# Part 2
while IFS=" " read -r locs char pw; do
  IFS=- read -r loc1 loc2 <<< "$locs"
  char=$(echo "$char" | cut -c1)
  char1=$(echo "$pw" | cut -d" " -f3 | cut -b"$loc1")
  char2=$(echo "$pw" | cut -d" " -f3 | cut -b"$loc2")
  [ "$char1" = "$char" ] && [ "$char2" != "$char" ] && echo
  [ "$char1" != "$char" ] && [ "$char2" = "$char" ] && echo
done | wc -l
