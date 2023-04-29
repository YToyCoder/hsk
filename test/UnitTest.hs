module Main where 

import System.Exit

import Test.HUnit
    ( assertEqual,
      runTestTT,
      Counts(errors, failures),
      Test(TestCase),
      Testable(test) )
import LiterateTest ( add )
import HaskellStart ( curriedFn, uncurriedFn )

testAdd :: Test
testAdd = TestCase (assertEqual "for add 2 3" 5 (add 2 3))
testUncurry :: Test
testUncurry = TestCase (assertEqual "curry function " 1 (uncurriedFn (3, 2)))
testCurry :: Test
testCurry = TestCase (assertEqual "curry function" 1 (curriedFn 3 2))
main :: IO b
main = do 
  a <- runTestTT (test [testAdd, testUncurry, testCurry]) 
  if errors a + failures a == 0
    then exitSuccess
    else exitFailure