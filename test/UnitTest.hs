module Main where 

import System.Exit

import Test.HUnit
    ( assertEqual,
      runTestTT,
      Counts(errors, failures),
      Test(TestCase),
      Testable(test), assertBool )
import LiterateTest ( add )
import HaskellStart (
  curriedFn, 
  uncurriedFn, 
  bsOne, bsTwo, bs, 
  map', 
  h, h', h'',
  function)
import Data.List (sort)

testAdd :: Test
testAdd = TestCase (assertEqual "for add 2 3" 5 (add 2 3))
testUncurry :: Test
testUncurry = TestCase (assertEqual "curry function " 1 (uncurriedFn (3, 2)))
testCurry :: Test
testCurry = TestCase (assertEqual "curry function" 1 (curriedFn 3 2))
ls = [2,5,1,10,7, 9, 8,3]
sortedls = sort ls
testBsOne :: Test
testBsOne = TestCase (assertEqual "bsone" sortedls (bsOne ls))
testBsTwo = TestCase (assertEqual "bsone" sortedls (bsTwo ls))
testBs = TestCase (assertEqual "bsone" sortedls (bs ls))
mapFn = ( + 1) -- short version
testMap = TestCase (assertEqual "map" (map' mapFn ls) (map mapFn ls) )
testHFn = TestCase (
  assertBool 
  "function h" 
  (let v1 = h 1 in let v2 = h' 1 in v1 == h'' 1 && v1 == v2))
main :: IO b
main = do 
  a <- runTestTT (test [
    testAdd, 
    testUncurry, testCurry, 
    testBsOne, testBsTwo, testBs, 
    testMap,
    testHFn
    ]) 
  if errors a + failures a == 0
    then exitSuccess
    else exitFailure