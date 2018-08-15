module Game.PlayerTest exposing (..)

import Expect
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Game.Player exposing (..)
import Game.Board exposing (Space(..))

suite : Test
suite =
    describe "Player"
        [ describe "getMarkerOrEmpty"
            [ test "When given an Ai player, it returns the marker" <|
                \() ->
                getMarkerOrEmpty ( Just ( Player Ai X) )
                    |> Expect.equal X
            , test "When given a Human player, it returns the marker" <|
                \() ->
                getMarkerOrEmpty ( Just (Player Human O) )
                    |> Expect.equal O
            , test "When given nothing it returns empty" <|
                \() ->
                getMarkerOrEmpty Nothing
                    |> Expect.equal Empty
            ]
        , describe "takeTurnOnBoard"
            [ test "When given a partly filled board a player and a space, it returns the space marked with the player's marker" <|
                \() ->
                    let
                        player = (Player Ai O)
                        startingBoard =
                            [ X, O, X,
                              X, Empty, O,
                              Empty, Empty, X
                            ]

                        expectedBoard =
                            [ X, O, X,
                              X, O, O,
                              Empty, Empty, X
                            ]
                    in
                        takeTurnOnBoard (Just player) 4 startingBoard
                            |> Expect.equal expectedBoard
            , test "When given a board and a space but no player, it returns the same board" <|
                \() ->
                    let
                        startingBoard =
                            [ X, O, X
                            , X, Empty, O
                            , Empty, Empty, X
                            ]
                    in
                        takeTurnOnBoard Nothing 7 startingBoard
                            |> Expect.equal startingBoard
            ]
        ]


