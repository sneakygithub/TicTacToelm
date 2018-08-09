module BoardTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Board exposing (..)
import Text


suite : Test
suite =
    describe "Board"
        [ describe "boardFull"
            [ test "Returns false if board contains Nothing"
                ( \() ->
                    boardFull [ Just "x", Just "o", Just "x",
                                Just "x", Nothing, Just "o",
                                Nothing, Nothing, Just "x"
                              ]
                    |> Expect.false "expected the board have open spaces" )
            , test "Returns true if board spaces are filled"
                ( \() ->
                    boardFull [ Just "x", Just "o", Just "x",
                                Just "x", Just "o", Just "o",
                                Just "o", Just "x", Just "x"
                              ]
                    |> Expect.true "expected the board to be full" )
            ]
        , describe "markSpace"
            [ test "Returns a board with the desired space marked when the board is partly filled" <|
                \() ->
                    let
                        startingBoard = [ Just "x", Just "o", Just "x",
                                          Just "x", Nothing, Just "o",
                                          Nothing, Nothing, Just "x"
                                        ]
                        expectedBoard = [ Just "x", Just "o", Just "x",
                                          Just "x", Just "o", Just "o",
                                          Nothing, Nothing, Just "x"
                                        ]
                    in
                        markBoardSpaceWith startingBoard 4 "o"
                            |> Expect.equal expectedBoard
            , test "Returns a board with the desired space marked when given an empty board" <|
                \() ->
                    let
                        startingBoard = [ Nothing, Nothing, Nothing,
                                          Nothing, Nothing, Nothing,
                                          Nothing, Nothing, Nothing
                                        ]
                        expectedBoard = [ Nothing, Nothing, Nothing,
                                          Nothing, Nothing, Nothing,
                                          Nothing, Nothing, Just "x"
                                        ]
                    in
                        markBoardSpaceWith startingBoard 8 "x"
                            |> Expect.equal expectedBoard
            ]
        ]
