module Game.RulesTest exposing (..)

import Expect
import Test exposing (..)
import Set

import Game.Rules exposing (..)
import Game.Board exposing (Space(..))

suite : Test
suite =
    describe "Rules"
        [ describe "hasWinner"
            [ test "When given a board without a winner, it returns False"
                ( \() ->
                    let
                        noWinner =
                            [ X, Empty, O
                            , O, X, X
                            , Empty, Empty, O
                            ]
                    in
                        hasWinner noWinner
                        |> Expect.false "expected False because no one won" )
            , test "When given a set of all Empty spaces it returns false"
                ( \() ->
                   let
                        winner =
                            [ X, O, O
                            , X, X, X
                            , Empty, Empty, O
                            ]
                    in
                        hasWinner winner
                        |> Expect.true "expected True because X won" )
            ]
        , describe "getWinner"
            [ test "When given a board without a winner, it returns Nothing" <|
                \() ->
                    let
                        board =
                            [ X, Empty, O
                            , O, X, X
                            , Empty, Empty, O
                            ]
                    in
                        getWinner board
                            |> Expect.equal Nothing
            , test "When given a board with X winning, it returns X" <|
                \() ->
                    let
                        board =
                            [ X, Empty, O
                            , O, X, X
                            , O, Empty, X
                            ]
                    in
                        getWinner board
                            |> Expect.equal (Just X)
            ]
        , describe "didMeetWinCondition"
            [ test "When given a set of all the same marker, returns true"
                ( \() ->
                    didMeetWinCondition [O, O, O]
                        |> Expect.true "expected the win condition to have been met" )
            , test "When given a set of all Empty spaces it returns false"
                ( \() ->
                    didMeetWinCondition [Empty, Empty, Empty]
                        |> Expect.false "expected the win condition to fail from emptiness" )
            , test "When given a set of some taken spaces some not it returns false"
                ( \() ->
                    ( didMeetWinCondition [O, Empty, Empty] )
                        && ( didMeetWinCondition [Empty, X, X] )
                        |> Expect.false "expected the win condition to fail from incompletion" )
            , test "When given a set of mixed markers it returns false"
                ( \() ->
                    ( didMeetWinCondition [X, X, O ] )
                        && ( didMeetWinCondition [X, O, X] )
                        && ( didMeetWinCondition [X, O, O] )
                        |> Expect.false "expected the win condition to fail from mixed markers" )
            ]
        , describe "potentialWins"
            [ test "When given an empty board, it returns a list of lists of empty spaces" <|
                \() ->
                    let
                        board =
                            [ Empty, Empty, Empty
                            , Empty, Empty, Empty
                            , Empty, Empty, Empty
                            ]
                        winOptions =
                            [ [ Empty, Empty, Empty ]
                            , [ Empty, Empty, Empty ]
                            , [ Empty, Empty, Empty ]
                            , [ Empty, Empty, Empty ]
                            , [ Empty, Empty, Empty ]
                            , [ Empty, Empty, Empty ]
                            , [ Empty, Empty, Empty ]
                            , [ Empty, Empty, Empty ]
                            ]
                    in
                        potentialWins board
                            |> Expect.equal winOptions
            , test "When given a mixed board, it returns the appropriately filled out lists" <|
                \() ->
                    let
                        board =
                            [ X, Empty, O
                            , O, X, X
                            , Empty, Empty, O
                            ]
                        winOptions =
                            [ [ X, Empty, O ]
                            , [ O, X, X ]
                            , [ Empty, Empty, O ]
                            , [ X, O, Empty ]
                            , [ Empty, X, Empty ]
                            , [ O, X, O ]
                            , [ X, X, O ]
                            , [ O, X, Empty ]
                            ]
                    in
                        potentialWins board
                            |> Expect.equal winOptions
            ]
        , describe "allWinOptions"
            [ test "Returns a list of all the ways to win on a board" <|
                \() ->
                    let
                        board =
                            [ X, Empty, Empty
                            , X, O, O
                            , Empty, X, O
                            ]
                        winOptions =
                            [ [ 0, 1, 2 ]
                            , [ 3, 4, 5 ]
                            , [ 6, 7, 8 ]
                            , [ 0, 3, 6 ]
                            , [ 1, 4, 7 ]
                            , [ 2, 5, 8 ]
                            , [ 0, 4, 8 ]
                            , [ 2, 4, 6 ]
                            ]
                    in
                        allWinOptions board
                            |> Expect.equal winOptions
            ]
        ,describe "horizontalWinOptions"
            [ test "Given a 3x3 (9 space) game-board it returns a list of the row spaces" <|
                \() ->
                    let
                        board =
                            [ X, Empty, Empty
                            , X, O, O
                            , Empty, X, O
                            ]
                        rows =
                            [ [ 0, 1, 2 ]
                            , [ 3, 4, 5 ]
                            , [ 6, 7, 8 ]
                            ]
                    in
                        horizontalWinOptions board
                            |> Expect.equal rows
            ]
        , describe "verticalWinOptions"
            [ test "Given a 3x3 (9 space) game-board it returns a list of the column spaces" <|
                \() ->
                    let
                        board =
                            [ X, O , X
                            , X, O, Empty
                            , Empty, X, O
                            ]
                        cols =
                            [ [ 0, 3, 6 ]
                            , [ 1, 4, 7 ]
                            , [ 2, 5, 8 ]
                            ]
                    in
                        verticalWinOptions board
                            |> Expect.equal cols
            ]
        , describe "diagonalWinOptions"
            [ test "Given a 3x3 (9 space) board, it returns a list of the diagonal wins" <|
                \() ->
                    let
                        board =
                            [ X, O , X
                            , X, O, Empty
                            , Empty, X, O
                            ]
                        diagonals =
                            [ [ 0, 4, 8 ]
                            , [ 2, 4, 6 ]
                            ]
                    in
                        diagonalWinOptions board
                            |> Expect.equal diagonals
            ]
        ]
