{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RecordWildCards #-}

module Lib where

import GHC.Generics (Generic)

import Data.Aeson as JSON

main :: IO ()
main = pure ()

data Recurrence
    = EveryDay
    | EveryMonth
    deriving (Show, Eq, Generic)

instance ToJSON Recurrence

instance FromJSON Recurrence
