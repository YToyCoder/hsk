module Main where 

import System.Exit

import Test.HUnit
import LiterateTest

test1 = TestCase (assertEqual "for add 2 3" 5 (add 2 3))

main = do 
  a <- runTestTT (test [test1]) 
  if ((errors a) + (failures a)== 0) 
        then exitSuccess
        else exitFailure