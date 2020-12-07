#!/usr/bin/env -S perl -n
use List::Util;

while ($_ =~ /([a-z ]+) bags contain (.*)\./g) {
  my ($a, $b) = ($1, $2);
  $m{$a} = [$b =~ /[0-9]+ ([a-z ]+) bag/g];
}

END {
  sub f {
    return $_[0] eq "shiny gold" || List::Util::any {f($_)} @{$m{$_[0]}};
  }
  print List::Util::reduce {$a + List::Util::any {f($_)} @{$m{$b}}} 0, (keys %m);
}
