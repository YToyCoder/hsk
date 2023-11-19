module Main where

import LiterateTest (add)
import Text.Printf (printf)

{- McCarthy 91 function -}
mc n  | n > 100 = n - 10
      | otherwise = mc (mc (n + 11))

mc' n | n > 100 = n - 10
      | otherwise = 91

main =
  mapM_ print cmp_result
    where 
      source = [10 .. 200]
      maped = map mc source 
      mc_fixed = map mc' source
      cmp_result = zipWith (==) mc_fixed maped -- map is_equal (zip mc_fixed maped)