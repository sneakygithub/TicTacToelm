module Game.PlayerTest exposing (..)

import Expect
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Game.Player exposing (..)


suite : Test
suite =
    describe "Player"
        [ describe "getMaybeMarker"
            [ test "When given an Ai player, it returns the marker" <|
                \() ->
                getMaybeMarker ( Just ( Player Ai "🤖") )
                    |> Expect.equal ( Just "🤖" )
            , test "When given a Human player, it returns the marker" <|
                \() ->
                getMaybeMarker ( Just (Player Human "🚹") )
                    |> Expect.equal ( Just "🚹" )
            , test "When given Nothing it returns Nothing" <|
                \() ->
                getMaybeMarker Nothing
                    |> Expect.equal Nothing
            ]
        , describe "getMarker"
            [ test "When given a player it returns the marker" <|
                \() ->
                getMarker  ( Player Human "💕" )
                    |> Expect.equal "💕"
            ]
        , describe "takeTurnOnBoard"
            [ test "When given a partly filled board a player and a space, it returns the space marked with the player's marker" <|
                \() ->
                    let
                        player = (Player Ai "o")
                        startingBoard =
                            [ Just "x", Just "o", Just "x",
                              Just "x", Nothing, Just "o",
                              Nothing, Nothing, Just "x"
                            ]

                        expectedBoard =
                            [ Just "x", Just "o", Just "x",
                              Just "x", Just "o", Just "o",
                              Nothing, Nothing, Just "x"
                            ]
                    in
                        takeTurnOnBoard (Just player) 4 startingBoard
                            |> Expect.equal expectedBoard
            , test "When given a board and a space but no player, it returns the same board" <|
                \() ->
                    let
                        startingBoard =
                            [ Just "x", Just "o", Just "x"
                            , Just "x", Nothing, Just "o"
                            , Nothing, Nothing, Just "x"
                            ]
                    in
                        takeTurnOnBoard Nothing 7 startingBoard
                            |> Expect.equal startingBoard
            ]
        ]


