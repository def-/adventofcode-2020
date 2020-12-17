val start = [[0,0], [0,1], [0,6], [1,0], [1,2], [1,5], [2,3], [3,3], [3,5], [4,0], [4,1], [4,2], [4,7], [5,0], [5,2], [5,7], [6,1], [6,6], [6,7], [7,1], [7,3], [7,4], [7,5], [7,7]];

fun next true 3 = true
  | next true 4 = true
  | next false 3 = true
  | next x y = false;

fun combs2 (j :: js) ks = (List.map (fn k => [j, k]) ks) @ (combs2 js ks)
  | combs2 [] ks = [];

fun combs3 (i :: is) js ks = (List.map (fn xs => i :: xs) (combs2 js ks)) @ (combs3 is js ks)
  | combs3 [] js ks = [];

fun neighbors [i, j, k] = combs3 [i - 1, i, i + 1] [j - 1, j, j + 1] [k - 1, k, k + 1];

fun range from to = if from = to then [to] else from :: (range (from + 1) to);

fun n neigh pos state = next (List.exists (fn x => x = pos) state) (length (List.filter (fn x => List.exists (fn y => x = y) state) (neigh pos)));

fun space s = List.filter (fn x => n neighbors x s) (combs3 (range (~6) 6) (range (~6) 14) (range (~6) 14));

fun run 0 f x = x
  | run i f x = f (run (i - 1) f x);

val start1 = List.map (fn x => 0 :: x) start;

print ((Int.toString (length (run 6 space start1))) ^ "\n");

(* Part 2 *)
fun combs4 (h :: hs) is js ks = (List.map (fn xs => h :: xs) (combs3 is js ks)) @ (combs4 hs is js ks)
  | combs4 [] is js ks = [];

fun neighbors2 [h, i, j, k] = combs4 [h - 1, h, h + 1] [i - 1, i, i + 1] [j - 1, j, j + 1] [k - 1, k, k + 1];

fun space2 s = List.filter (fn x => n neighbors2 x s) (combs4 (range (~6) 6) (range (~6) 6) (range (~6) 14) (range (~6) 14));

val start2 = List.map (fn x => 0 :: x) start1;

print ((Int.toString (length (run 6 space2 start2))) ^ "\n");
