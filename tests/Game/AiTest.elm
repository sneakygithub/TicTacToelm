module Game.AiTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Game.Ai exposing (..)
import Game.Board exposing (Space(..))


suite : Test
suite =
    describe "AI"
        [ describe "playTurn"
            [ test "Returns the only open space on a board with one open space" <|
                \() ->
                    let
                        board =
                            [ X, O, X
                            , X, Empty, O
                            , O, X, X
                            ]
                    in
                        playTurn board
                            |> Expect.equal ( Just 4 )
            , test "Returns any open space on a board that is partly full" <|
                \() ->
                    let
                        board =
                            [ Empty, Empty, Empty
                            , Empty, X, Empty
                            , Empty, Empty, Empty
                            ]
                    in
                        playTurn board
                            |> Expect.notEqual ( Just 4 )
            , test "Returns Nothing if given a full board" <|
                \() ->
                    let
                        board =
                            [ X, O, X
                            , X, O, O
                            , O, X, X
                            ]
                    in
                        playTurn board
                            |> Expect.equal Nothing
            ]
        ]

