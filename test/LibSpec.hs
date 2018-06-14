{-# LANGUAGE TypeApplications #-}

module LibSpec where

import Test.Hspec
import Test.QuickCheck
import Test.Validity

import Data.GenValidity.Time ()

import Lib

instance GenUnchecked HourMinute

instance GenValid HourMinute

spec :: Spec
spec = do
    describe "hourMinute" $
        it "produces valid HourMinutes for valid Integers" $
        producesValidsOnValids hourMinute
    describe "toNominalDiffTime" $ do
        it "is the inverse of hourMinute if you start with an Integer" $
            inverseFunctionsOnValid hourMinute toPicoseconds
        it "is the inverse of hourMinute if you start with a HourMinute" $
            inverseFunctionsOnValid toPicoseconds hourMinute
    genValidSpec @HourMinute
    eqSpec @HourMinute
    ordSpec @HourMinute
