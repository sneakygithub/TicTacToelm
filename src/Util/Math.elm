module Util.Math exposing (..)


isEven : Int -> Bool
isEven number =
    number
        % 2
        |> (==) 0


isOdd : Int -> Bool
isOdd number =
    not (isEven number)
