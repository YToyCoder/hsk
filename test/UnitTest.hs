module Main where 

import System.Exit

import Test.HUnit
    ( assertEqual,
      runTestTT,
      Counts(errors, failures),
      Test(TestCase),
      Testable(test) )
import LiterateTest ( add )
import HaskellStart (curriedFn, uncurriedFn, bsOne, bsTwo, bs)
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
main :: IO b
main = do 
  a <- runTestTT (test [testAdd, testUncurry, testCurry, testBsOne, testBsTwo, testBs]) 
  if errors a + failures a == 0
    then exitSuccess
    else exitFailure