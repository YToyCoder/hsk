{-# LANGUAGE GADTs #-}
module Main where

import LiterateTest (add)
import Text.Printf (printf)
import Data.List (insertBy, sortBy)
import Data.Ord (comparing)
import Control.Monad (filterM)
import GHC.Base (liftA2)

{- McCarthy 91 function -}
mc n
  | n > 100 = n - 10
  | otherwise = mc (mc (n + 11))

mc' n
  | n > 100 = n - 10
  | otherwise = 91

-- Binary Search
search :: (Ord a) => a -> [a] -> Bool
search a [] = False
search a xs
  | m < a = search a behind
  | m > a = search a front
  | otherwise = True
    where (front, m : behind) = splitAt (length xs `div` 2) xs

-- insert sort 
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys)
  | x < y = x : y : ys
  | otherwise = y : insert  x ys

partitionEithers :: [Either a b] -> ([a], [b])
partitionEithers =
  foldr (either left right ) ([], [])
    where
      left a (l, r) = (a : l, r)
      right a (l, r) = (l, a : r)

data HTree a = Leaf a | Branch (HTree a) (HTree a) deriving Show

htree [ (_, t)] = t
htree ((w1, t1) : (w2, t2) : wts) =
  htree $ insertBy (comparing fst) (w1 + w2, Branch t1 t2) wts

serialize (Leaf x) = [(x, "")]
serialize (Branch l r) =
  [(x, '0' : code) | (x, code) <- serialize l] ++
  [(x, '1' : code) | (x, code) <- serialize r]

huffman :: (Ord a, Ord w, Num w) => [(a, w)] -> [(a, [Char])]
huffman freq =
  sortBy (comparing fst) $
  serialize $ htree $ sortBy (comparing fst) $ [(w, Leaf x) | (x, w) <- freq]

-- simple logic calculator
data Term t where
  Con   :: a -> Term a
  (:&:) :: Term Bool -> Term Bool -> Term Bool
  (:|:) :: Term Bool -> Term Bool -> Term Bool
  (:<:) :: Term Int -> Term Int -> Term Bool
  (:=:) :: Term Int -> Term Int -> Term Bool
  (:+:) :: Term Int -> Term Int -> Term Int
  (:-:) :: Term Int -> Term Int -> Term Int
  Name :: String -> Term t

data Formula ts where
  Body    :: Term Bool -> Formula ()
  ForAll  :: Show a => [a] -> (Term a -> Formula as) -> Formula (a, as)
  Exist   :: Show a => [a] -> (Term a -> Formula as) -> Formula (a, as)

ex1 :: Formula ()
ex1 = Body (Con True)

ex2 :: Formula (Int, ())
ex2 = ForAll [1 .. 10] $ \n -> Body $ n :<: (n :+: Con 1)

eval :: Term t -> t
eval (Con v) = v
eval (p :&: q) = eval p && eval q
eval (p :|: q) = eval p || eval q
eval (n :<: m) = eval n < eval m
eval (n :=: m) = eval n == eval m
eval (n :+: m) = eval n + eval m
eval (n :-: m) = eval n - eval m
eval (Name _) = error "Cannot eval a Name"

mm = liftA2 (\ flg -> if flg then (1:) else id) [False, True]

main :: IO ()
main =
  mapM_ print k --(search 50 [1 .. 100] : cmp_result)
    where
      source = [10 .. 200]
      maped = map mc source
      mc_fixed = map mc' source
      cmp_result = zipWith (==) mc_fixed maped -- map is_equal (zip mc_fixed maped)
      -- k = if [False , True] then 1 : [] else []
      k = filterM (const [False, True]) [1..3]
