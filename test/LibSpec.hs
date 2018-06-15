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
            JSON.encode (EveryDay 2) `shouldBe` "{\"every-day\":2}"
        it "should read EveryDay like this (golden)" $
            JSON.decode "\"every-day\"" `shouldBe` Just (EveryDay 1)
        it "should read EveryDay like this" $
            JSON.decode "{\"every-day\": 6}" `shouldBe` Just (EveryDay 6)
        it "should encode EveryMonth like this" $
            JSON.encode (EveryMonth 7) `shouldBe` "{\"every-month\":7}"
        it "should read EveryMonth like this (golden)" $
            JSON.decode "\"every-month\"" `shouldBe` Just (EveryMonth 1)
        it "should read EveryMonth like this" $
            JSON.decode "{ \"every-month\": 5}" `shouldBe` Just (EveryMonth 5)
        it "should roundtrip" $
            forAllValid $ \r ->
                (decode (encode r) :: Maybe Recurrence) `shouldBe` (Just r)

instance GenUnchecked Recurrence

instance GenValid Recurrence
