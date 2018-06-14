{-# LANGUAGE TypeApplications #-}

module LibSpec where

import Test.Hspec
import Test.QuickCheck
import Test.Validity

import Data.GenValidity.Time ()

import Lib

spec :: Spec
spec = do
    describe "decToBin" $ do
        it "never crashes" $ producesValidsOnValids decToBin
        it "produces strings that only ever contain ones and zeroes" $
            forAllValid $ \i ->
                all (\c -> c == '0' || c == '1') $
                dropWhile (== '-') $ decToBin i
        it "deals with -1 correctly" $ decToBin (-1) `shouldBe` "-1"
        it "produces positive numbers for positive integers" $
            forAll (abs <$> genValid) $ \i ->
                case decToBin i of
                    [] -> False
                    ('-':_) -> False
                    _ -> True
        it "deals with 59 correctly" $ decToBin 59 `shouldBe` "111011"
