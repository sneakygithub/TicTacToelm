module Game.AiTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Game.Ai exposing (..)


suite : Test
suite =
    describe "AI"
        [ describe "playTurn"
            [ test "Returns the only open space on a board with one open space" <|
                \() ->
                    let
                        board =
                            [ Just "x", Just "o", Just "x"
                            , Just "x", Nothing, Just "o"
                            , Just "o", Just "x", Just "x"
                            ]
                    in
                        playTurn board
                            |> Expect.equal ( Just 4 )
            , test "Returns any open space on a board that is partly full" <|
                \() ->
                    let
                        board =
                            [ Nothing, Nothing, Nothing
                            , Nothing, Just "x", Nothing
                            , Nothing, Nothing, Nothing
                            ]
                    in
                        playTurn board
                            |> Expect.notEqual ( Just 4 )
            , test "Returns Nothing if given a full board" <|
                \() ->
                    let
                        board =
                            [ Just "x", Just "o", Just "x"
                            , Just "x", Just "o", Just "o"
                            , Just "o", Just "x", Just "x"
                            ]
                    in
                        playTurn board
                            |> Expect.equal Nothing
            ]
        ]

