module Game.GameTest exposing (..)

import Expect
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Game.Game exposing (..)
import Game.Player as Player exposing (Player)
import Game.Board exposing (Space(..))

suite : Test
suite =
    describe "Game"
        [ describe "continueGame"
            [ test "A full board ends the game" <|
                \() ->
                    let
                        fullBoard =
                            [ X, O, X
                            , X, O, O
                            , O, X, X
                            ]
                    in
                        continueGame fullBoard
                            |> Expect.equal False
            , test "When there are moves left, the game continues" <|
                \() ->
                    let
                        openBoard =
                            [ X, O, X
                            , O, Empty, O
                            , O, X, X
                            ]
                    in
                        continueGame openBoard
                            |> Expect.equal True
            , test "A winner ends the game" <|
                \() ->
                    let
                        wonBoard =
                            [ X, O, X
                            , O, Empty, X
                            , O, O, X
                            ]
                    in
                        continueGame wonBoard
                            |> Expect.equal False
            ]
        , describe "currentPlayer"
            [ test "It returns the current player if the current player is a human" <|
                \() ->
                    let
                    board =
                        ( List.repeat 9 Empty )

                    players =
                        [ Player Player.Human X , Player Player.Ai O]

                    gameState =
                        GameState True board players
                in
                    currentPlayer gameState
                        |> Expect.equal (Just (Player Player.Human X))
            , test "It returns the current player if the current player is an AI" <|
                \() ->
                    let
                    board =
                        ( List.repeat 9 Empty )

                    players =
                        [ Player Player.Ai O, Player Player.Human X ]

                    gameState =
                        GameState True board players
                in
                    currentPlayer gameState
                        |> Expect.equal (Just (Player Player.Ai O))
            , test "It returns Nothing if there are no players" <|
                \() ->
                    let
                    board =
                        ( List.repeat 9 Empty )

                    players =
                        [ ]

                    gameState =
                        GameState True board players
                in
                    currentPlayer gameState
                        |> Expect.equal Nothing
            ]
        ]
