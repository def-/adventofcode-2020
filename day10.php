#!/usr/bin/env php
<?php
$xs[] = 0;
while ($x = trim(fgets(STDIN))) $xs[] = $x;
sort($xs);
$xs[] = end($xs) + 3;

# Part 1
for ($i = 1; $i < count($xs); $i++) $d[$xs[$i] - $xs[$i-1]]++;
$a = $d[1] * $d[3];
echo $d[1] * $d[3] . "\n";

# Part 2
function b($i, $j) {
  global $xs, $m;
  if ($i >= count($xs) || $xs[$i] > $j + 3) return 0;
  if ($i == count($xs) - 1) return 1;
  if (!isset($m[$i])) $m[$i] = b($i+1, $xs[$i]) + b($i+2, $xs[$i]) + b($i+3, $xs[$i]);
  return $m[$i];
}
echo b(0, 0) . "\n";
?>
