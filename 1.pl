#!/usr/bin/env swipl
solve(L, Z) :- member(X, L), member(Y, L), 2020 is X + Y, Z is X * Y.
solve2(L, Z) :- member(W, L), member(X, L), member(Y, L), 2020 is W + X + Y, Z is W * X * Y.
