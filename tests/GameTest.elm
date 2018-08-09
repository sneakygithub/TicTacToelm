module GameTest exposing (..)

import Expect
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Game exposing (..)


suite : Test
suite =
    describe "Game"
        [ describe "continueGame"
            [ test "Getting a true value continues the game" <|
                \() ->
                    continueGame True
                        |> Expect.equal "continue"
            , test "Getting a false value ends the game" <|
                \() ->
                    continueGame False
                        |> Expect.equal "game over"
            ]
        ]
