{-# LANGUAGE DeriveGeneric #-}

module Lib where

import Data.Time
import Data.Validity
import GHC.Generics (Generic)

main :: IO ()
main = pure ()

data HourMinute = HourMinute
    { hours :: Integer
    , minutes :: Integer
    } deriving (Generic, Show, Eq)

instance Validity HourMinute

hourMinute :: NominalDiffTime -> HourMinute
hourMinute = undefined
