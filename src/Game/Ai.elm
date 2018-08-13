module Game.Ai exposing (..)

import Game.Board as Board exposing (Board)


playTurn : Board -> Maybe Int
playTurn board =
    board
        |> Board.openSpaces
        |> List.head


