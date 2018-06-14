module LibSpec where

import Test.Hspec
import Test.QuickCheck
import Test.Validity

import Data.GenValidity.Time ()

import Lib

spec :: Spec
spec = do
    describe "hourMinute" $
        it "produces valid HourMinutes for valid NominalDiffTimes" $
        producesValidsOnValids hourMinute
