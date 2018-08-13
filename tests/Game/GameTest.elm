module Game.GameTest exposing (..)

import Expect
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Game.Game exposing (..)
import Game.Player as Player exposing (Player)

suite : Test
suite =
    describe "Game"
        [ describe "continueGame"
            [ test "A full board ends the game" <|
                \() ->
                    let
                        fullBoard =
                            [ Just "x", Just "o", Just "x"
                            , Just "x", Just "o", Just "o"
                            , Just "o", Just "x", Just "x"
                            ]
                    in
                        continueGame fullBoard
                            |> Expect.equal False
            , test "When there are moves left, the game continues" <|
                \() ->
                    let
                        openBoard =
                            [ Just "x", Just "o", Just "x"
                            , Just "x", Nothing, Just "o"
                            , Just "o", Just "x", Just "x"
                            ]
                    in
                        continueGame openBoard
                            |> Expect.equal True
            ]
        , describe "currentPlayer"
            [ test "It returns the current player if the current player is a human" <|
                \() ->
                    let
                    board =
                        ( List.repeat 9 Nothing )

                    players =
                        [ Player Player.Human "x" , Player Player.Ai "o"]

                    gameState =
                        GameState True board players
                in
                    currentPlayer gameState
                        |> Expect.equal (Just (Player Player.Human "x"))
            , test "It returns the current player if the current player is an AI" <|
                \() ->
                    let
                    board =
                        ( List.repeat 9 Nothing )

                    players =
                        [ Player Player.Ai "o", Player Player.Human "x" ]

                    gameState =
                        GameState True board players
                in
                    currentPlayer gameState
                        |> Expect.equal (Just (Player Player.Ai "o"))
            , test "It returns Nothing if there are no players" <|
                \() ->
                    let
                    board =
                        ( List.repeat 9 Nothing )

                    players =
                        [ ]

                    gameState =
                        GameState True board players
                in
                    currentPlayer gameState
                        |> Expect.equal Nothing
            ]
        ]
