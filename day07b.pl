#!/usr/bin/env -S perl -n
use List::Util;

while ($_ =~ /([a-z ]+) bags contain (.*)\./g) {
  my ($a, $b) = ($1, $2);
  while ($b =~ /([0-9])+ ([a-z ]+) bag/g) {
    push(@{$m{$a}}, [$1, $2]);
  }
}

END {
  sub f {
    return List::Util::reduce {$a + @{$b}[0] * f(@{$b}[1])} 1, @{$m{$_[0]}};
  }
  print f("shiny gold") - 1;
}
