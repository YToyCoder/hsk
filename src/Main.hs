module Main where

import LiterateTest (add)
import Text.Printf (printf)

{- McCarthy 91 function -}
mc n  | n > 100 = n - 10
      | otherwise = mc (mc (n + 11))

mc' n | n > 100 = n - 10
      | otherwise = 91

-- Binary Search
search :: (Ord a) => a -> [a] -> Bool
search a [] = False
search a xs | m < a = search a behind
            | m > a = search a front
            | otherwise = True
      where (front, m : behind) = splitAt (length xs `div` 2) xs

-- insert sort 
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys)   | x < y = x : y : ys
                  | otherwise = y : insert  x ys

main =
  mapM_ print (search 50 [1 .. 100] : cmp_result)
    where
      source = [10 .. 200]
      maped = map mc source
      mc_fixed = map mc' source
      cmp_result = zipWith (==) mc_fixed maped -- map is_equal (zip mc_fixed maped)