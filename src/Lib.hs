{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Lib where

import GHC.Generics (Generic)

import Data.Validity
import Data.Aeson as JSON

main :: IO ()
main = pure ()

data Recurrence
    = EveryDay
    | EveryMonth
    deriving (Show, Eq, Generic)

instance Validity Recurrence

instance ToJSON Recurrence where
    toJSON EveryDay = JSON.String "every-day"
    toJSON EveryMonth = JSON.String "every-month"

instance FromJSON Recurrence where
    parseJSON =
        JSON.withText "Recurrence" $ \t ->
            case t of
                "every-day" -> pure EveryDay
                "every-month" -> pure EveryMonth
