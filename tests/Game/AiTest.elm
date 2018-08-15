module Game.AiTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Debug

import Game.Ai exposing (..)
import Game.Board exposing (Space(..))
import Game.Player as Player exposing (Player)

import Util.Math as Math


aiIsX : List Player
aiIsX =
    [ Player Player.Ai X , Player Player.Ai O ]

aiIsO : List Player
aiIsO =
    [ Player Player.Ai O, Player Player.Human X ]


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
                        playTurn board aiIsX
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
                        playTurn board aiIsO
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
                        playTurn board aiIsX
                            |> Expect.equal Nothing
            , test "will take the winning move on a horizontal win" <|
                \() ->
                    let
                        board =
                            [ X, X, Empty
                            , Empty, O, Empty
                            , Empty, O, Empty
                            ]
                    in
                        playTurn board aiIsX
                            |> Expect.equal ( Just 2 )
            , test "will take the winning move on a vertical win" <|
                \() ->
                    let
                        board =
                            [ X, Empty, O
                            , Empty, O, Empty
                            , X, Empty, Empty
                            ]
                    in
                        playTurn board aiIsX
                            |> Expect.equal ( Just 3 )
            , test "will take the winning move on a diagonal win" <|
                \() ->
                    let
                        board =
                            [ X, Empty, O
                            , O, X, Empty
                            , Empty, Empty, Empty
                            ]
                    in
                        playTurn board aiIsX
                            |> Expect.equal ( Just 8 )
            , test "stop immediate horizontal loss" <|
                \() ->
                    let
                        board =
                            [ X, X, Empty
                            , Empty, O, Empty
                            , Empty, O, Empty
                            ]
                    in
                        playTurn board aiIsO
                            |> Expect.equal ( Just 2 )
            , test "will stop immediate vertical loss" <|
                \() ->
                    let
                        board =
                            [ X, Empty, O
                            , Empty, O, Empty
                            , X, Empty, Empty
                            ]
                    in
                        playTurn board aiIsO
                            |> Expect.equal ( Just 3 )
            , test "stops immediate diagonal loss" <|
                \() ->
                    let
                        board =
                            [ X, Empty, O
                            , O, X, Empty
                            , Empty, Empty, Empty
                            ]
                    in
                        playTurn board aiIsO
                            |> Expect.equal ( Just 8 )
            , test "prevents corner fork" <|
                \() ->
                    let
                        board =
                            [ X, Empty, Empty
                            , Empty, O, Empty
                            , Empty, Empty, X
                            ]
                    in
                        List.any ( (==) (playTurn board aiIsO) ) [Just 1, Just 3, Just 5,  Just 7]
                            |> Expect.equal True
            , test "prevents middle fork" <|
                \() ->
                    let
                        board =
                            [ X, Empty, Empty
                            , Empty, O, Empty
                            , Empty, X, Empty
                            ]
                    in
                        List.any ( (==) (playTurn board aiIsO) ) [Just 1, Just 2]
                            |> Expect.equal False
            ]
        , describe "deduceTurn"
            [ test "given a board with no marked spaces, it returns 0" <|
                \() ->
                    let
                        board =
                            [ Empty, Empty, Empty
                            , Empty, Empty, Empty
                            , Empty, Empty, Empty
                            ]
                    in
                        deduceTurn board
                            |> Expect.equal 0
            , test "given a full board it returns the length of the board" <|
                \() ->
                    let
                        board =
                            [ X, X, O
                            , O, X, X
                            , X, O, O
                            ]
                    in
                        deduceTurn board
                            |> Expect.equal 9
            , test "given a board with four turns taken, it returns 4" <|
                \() ->
                    let
                        board =
                            [ X, X, O
                            , O, Empty, Empty
                            , Empty, Empty, Empty
                            ]
                    in
                        deduceTurn board
                            |> Expect.equal 4
            ]
        , describe "getTurnDeterminer"
            [ test "given a board with odd turns, it returns the isOdd function" <|
                \() ->
                    let
                        board =
                            [ Empty, Empty, Empty
                            , Empty, X, Empty
                            , Empty, Empty, Empty
                            ]
                    in
                        getTurnDeterminer board
                            |> Expect.equal Math.isOdd
            , test "given a board with even turns taken, it returns the isEven function" <|
                \() ->
                    let
                        board =
                            [ Empty, Empty, Empty
                            , Empty, X, Empty
                            , Empty, Empty, Empty
                            ]
                    in
                        getTurnDeterminer board
                            |> Expect.equal Math.isOdd
            ]
        , describe "getCurrentMarker"
            [ test "when given a list of players, it returns the marker of the first player" <|
                \() ->
                    getCurrentMarker aiIsX
                        |> Expect.equal X
            , test "when given an empty list of players it will return the Empty marker" <|
                \() ->
                    getCurrentMarker []
                        |> Expect.equal Empty
            ]

        , describe "isCurrentPlayer"
            [ test "when it isn't the AI's turn, it returns false" <|
                \() ->
                    let
                        board =
                            [ Empty, Empty, Empty
                            , Empty, X, Empty
                            , Empty, Empty, Empty
                            ]

                    in
                        isCurrentPlayer board Math.isEven
                        |> Expect.equal False
            , test "when it is the AI's turn, it returns true" <|
                \() ->
                    let
                        board =
                            [ Empty, Empty, O
                            , Empty, X, Empty
                            , O, Empty, Empty
                            ]

                    in
                        isCurrentPlayer board Math.isOdd
                        |> Expect.equal True
            ]
        , describe "winPoints"
            [ test "returns a positive integer in proportion to the turn on the AI's turn" <|
                \() ->
                    let
                        board =
                            [ X, Empty, O
                            , Empty, X, O
                            , Empty, Empty, Empty
                            ]

                    in
                        winPoints board Math.isEven
                        |> Expect.equal 6
            , test "returns a negative integer in proportion to the turn on the AI's opponent's turn" <|
                \() ->
                    let
                        board =
                            [ X, Empty, O
                            , Empty, X, Empty
                            , X, Empty, O
                            ]

                    in
                        winPoints board Math.isEven
                        |> Expect.equal -5
            ]
        , describe "chooseBestScore"
            [ test "picks the highest score on the AI's turn" <|
                \() ->
                    let
                        board =
                            [ X, Empty, O
                            , Empty, X, O
                            , Empty, Empty, Empty
                            ]

                    in
                        chooseBestScore [0, 2, 2, 3, 6] board Math.isEven
                        |> Expect.equal 6
            , test "picks the lowest score on the opponent's turn" <|
                \() ->
                    let
                        board =
                            [ X, Empty, O
                            , Empty, X, Empty
                            , X, Empty, O
                            ]

                    in
                        chooseBestScore [2, -2, -5, 2] board Math.isEven
                        |> Expect.equal -5
            , test "Returns zero if no scores are given" <|
                \() ->
                    let
                        board =
                            [ X, Empty, O
                            , Empty, X, Empty
                            , X, Empty, O
                            ]

                    in
                        chooseBestScore [] board Math.isEven
                        |> Expect.equal 0
            ]
        , describe "scoreTurn"
            [ test "returns the space's win points if the Turn is a winning move" <|
                \() ->
                    let
                        board =
                            [ X, Empty, O
                            , Empty, X, O
                            , Empty, Empty, Empty
                            ]

                    in
                        scoreTurn board 8 aiIsX Math.isEven
                        |> Expect.equal 6
            , test "returns zero if the game is over with no winner on the turn" <|
                \() ->
                    let
                        board =
                            [ X, O, O
                            , O, X, X
                            , X, Empty, O
                            ]

                    in
                        scoreTurn board 7 aiIsX Math.isEven
                        |> Expect.equal 0
            ]
        ]
