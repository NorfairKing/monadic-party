{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE OverloadedStrings #-}

module LibSpec where

import Test.Hspec
import Test.QuickCheck
import Test.Validity

import Data.GenValidity.Time ()

import Data.Aeson as JSON

import Lib

spec :: Spec
spec = do
    describe "JSON Recurrence" $ do
        it "should encode EveryDay like this" $
            JSON.encode EveryDay `shouldBe` "\"every-day\""
        it "should read EveryDay like this" $
            JSON.decode "\"every-day\"" `shouldBe` Just EveryDay
        it "should encode EveryMonth like this" $
            JSON.encode EveryMonth `shouldBe` "\"every-month\""
        it "should read EveryMonth like this" $
            JSON.decode "\"every-month\"" `shouldBe` Just EveryMonth
