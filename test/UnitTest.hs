module Main where 

import System.Exit

import Test.HUnit
import LiterateTest
import HskStart

testAdd = TestCase (assertEqual "for add 2 3" 5 (add 2 3))
testUncurry = TestCase (assertEqual "curry function " 1 (uncurriedFn (3, 2)))
testCurry = TestCase (assertEqual "curry function" 1 (curriedFn 3 2))
main = do 
  a <- runTestTT (test [testAdd, testUncurry, testCurry]) 
  if errors a + failures a == 0
    then exitSuccess
    else exitFailure