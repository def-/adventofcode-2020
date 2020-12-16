#!/usr/bin/env node
blocks = require('fs').readFileSync(process.stdin.fd, 'utf-8').split('\n\n');
specs = new Map(blocks[0].split('\n').map(l => /([a-z ]+): ([0-9]+)-([0-9]+) or ([0-9]+)-([0-9]+)/.exec(l)).map(x => [x[1].split(" ").join("_"), x.slice(2, 6).map(y => parseInt(y))]));
your = blocks[1].split('\n')[1].split(',').map(x => parseInt(x));
nearbies = blocks[2].split('\n').slice(1, -1).map(l => l.split(',').map(x => parseInt(x)));

valids = []

sum = 0;
for (nearby of nearbies) {
  all_found = true;
  for (x of nearby) {
    found = false;
    for ([key, val] of specs) {
      if ((x >= val[0] && x <= val[1]) || (x >= val[2] && x <= val[3])) {
        found = true;
        break;
      }
    }
    if (!found) {
      all_found = false;
      sum += x;
    }
  }
  if (all_found) {
    valids.push(nearby);
  }
}

//console.log(sum); // Part 1

// Part 2 solved in Z3, use: z3 -model -smt2 day16b.z3
for ([key, val] of specs) {
  console.log('(declare-fun %s () Int)', key)
  for (z of valids) {
    console.log('(assert (or');
    your.map((_, i) => i).filter(i => (z[i] >= val[0] && z[i] <= val[1]) || (z[i] >= val[2] && z[i] <= val[3])).map(i => console.log('  (= %s %d)', key, i));
    console.log('))');
  }
}

console.log('(assert (distinct');
for ([key, _] of specs) console.log('  ' + key);
console.log('))');
console.log('(declare-fun your () (Array Int Int))');
your.map((y, i) => console.log('(assert (= (store your %d %d) your))', i, y));
console.log('(declare-fun result () Int)');
console.log('(assert (= result (* (select your departure_track) (select your departure_location) (select your departure_station) (select your departure_platform) (select your departure_time) (select your departure_date))))');
console.log('(check-sat)');
