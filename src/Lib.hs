{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RecordWildCards #-}

module Lib where

import Data.Time
import Data.Validity
import GHC.Generics (Generic)

main :: IO ()
main = pure ()

data HourMinute = HourMinute
    { hours :: Integer
    , minutes :: Integer
    , seconds :: Integer
    , picoseconds :: Integer
    } deriving (Generic, Show, Eq, Ord)

instance Validity HourMinute where
    validate HourMinute {..} =
        mconcat
            [ delve "hours" hours
            , delve "minutes" minutes
            , delve "picoseconds" picoseconds
            , declare "Hours are positive" $ hours >= 0
            , declare "hours are fewer than 24" $ hours < 24
            , declare "minutes are positive" $ minutes >= 0
            , declare "minutes are fewer than 60" $ minutes < 60
            , declare "seconds are positive" $ seconds >= 0
            , declare "seconds are fewer than 1e12" $ seconds < 60
            , declare "picoseconds are positive" $ picoseconds >= 0
            , declare "picoseconds are fewer than 1e12" $
              picoseconds < (10 ^ 12)
            ]

hourMinute :: Integer -> HourMinute
hourMinute x =
    let totalHours = totalMinutes `div` 60
        totalMinutes = totalSeconds `div` 60
        totalSeconds = totalPicoseconds `div` (10 ^ 12)
        totalPicoseconds = x
        hours = totalHours
        minutes = totalMinutes - 60 * hours
        seconds = totalSeconds - 60 * minutes
        picoseconds = totalPicoseconds - (10 ^ 12) * seconds
    in HourMinute {..}

toPicoseconds :: HourMinute -> Integer
toPicoseconds HourMinute {..} =
    ((((hours * 60) + minutes) * 60) + seconds) * (10 ^ 12) + picoseconds
