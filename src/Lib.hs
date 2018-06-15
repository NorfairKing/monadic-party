{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Lib where

import GHC.Generics (Generic)

import Control.Applicative
import Data.Aeson as JSON
import Data.Validity

main :: IO ()
main = pure ()

data Recurrence
    = EveryDay Int
    | EveryMonth Int
    deriving (Show, Eq, Generic)

instance Validity Recurrence

instance ToJSON Recurrence where
    toJSON (EveryDay i) = object ["every-day" .= i]
    toJSON (EveryMonth i) = object ["every-month" .= i]

-- object :: [Pair] -> Value
-- (.=) :: (KeyValue kv, ToJSON v) => Text -> v -> kv
-- instance KeyValue Pair
instance FromJSON Recurrence where
    parseJSON v =
        JSON.withText
            "Recurrence"
            (\t ->
                 case t of
                     "every-day" -> pure (EveryDay 1)
                     "every-month" -> pure (EveryMonth 1))
            v <|>
        JSON.withObject "Recurrence" (\o -> EveryDay <$> o .: "every-day") v<|>

        JSON.withObject "Recurrence" (\o -> EveryMonth <$> o .: "every-month") v
-- parseJSON :: JSON.Value -> Parser Recurrence
-- withText :: String -> (Text -> Parser a) -> Value -> Parser a
-- withObject :: String -> (Object -> Parser a) -> Value -> Parser a
-- (<|>) :: Parser a -> Parser a -> Parser a
-- (.:) :: FromJSON a => Object -> Text -> Parser a
