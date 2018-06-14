{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RecordWildCards #-}

module Lib where

import Data.Maybe
import Data.Time
import Data.Validity
import GHC.Generics (Generic)

readsInt :: String -> Maybe Integer
readsInt = extract . reads
  where
    extract [(n, "")] = Just n
    extract _ = Nothing

decToBin :: Integer -> String
decToBin num
    | abs num < 2 = show num
    | otherwise = decToBin (half num) ++ (show $ mod num 2)
  where
    half n = absIntHalf n * signum n
    absIntHalf = floor . (/ 2) . fromIntegral . abs

main = do
    putStrLn "Enter decimal value:"
    val <- getLine
    putStrLn . fromMaybe "Invalid Input" . fmap decToBin . readsInt $ val
    main
