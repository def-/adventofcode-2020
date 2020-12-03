#!/usr/bin/env runhaskell
f _ _ _ [] = 0
f y x p (l:ls) = fromEnum ((l !! p) == '#') + (f y x (p + x) $ drop y ls)

main = do
  ls <- fmap (map (concat . repeat) . lines) getContents
  print $ f 0 3 0 ls
  print $ product $ map (\x -> x 0 ls) [f 0 1, f 0 3, f 0 5, f 0 7, f 1 1]
