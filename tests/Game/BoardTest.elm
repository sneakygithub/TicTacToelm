module Game.BoardTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Game.Board exposing (..)


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
        , describe "markBoardSpaceWith"
            [ test "Returns a board with the desired space marked when the board is partly filled" <|
                \() ->
                    let
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
                        markBoardSpaceWith startingBoard 4 (Just "o")
                            |> Expect.equal expectedBoard
            , test "Returns a board with the desired space marked when given an empty board" <|
                \() ->
                    let
                        startingBoard =
                            [ Nothing, Nothing, Nothing,
                              Nothing, Nothing, Nothing,
                              Nothing, Nothing, Nothing
                            ]

                        expectedBoard =
                            [ Nothing, Nothing, Nothing,
                              Nothing, Nothing, Nothing,
                              Nothing, Nothing, Just "x"
                            ]
                    in
                        markBoardSpaceWith startingBoard 8 (Just "x")
                            |> Expect.equal expectedBoard
            , test "Returns the same board it was given when the marker is Nothing" <|
                \() ->
                    let
                        startingBoard =
                            [ Just "x", Just "o", Just "x"
                            , Just "x", Nothing, Just "o"
                            , Nothing, Nothing, Just "x"
                            ]
                    in
                        markBoardSpaceWith startingBoard 7 Nothing
                            |> Expect.equal startingBoard
            , test "Returns the same board it was given when the space is taken" <|
                \() ->
                    let
                        startingBoard =
                            [ Just "x", Just "o", Just "x"
                            , Just "x", Nothing, Just "o"
                            , Nothing, Nothing, Just "x"
                            ]
                    in
                        markBoardSpaceWith startingBoard 8 ( Just "o" )
                            |> Expect.equal startingBoard
            ]
        , describe "openSpaces"
            [ test "returns an list of all space indices on an entirely empty board" <|
                \() ->
                    let
                        board =
                            [ Nothing, Nothing, Nothing
                            , Nothing, Nothing, Nothing
                            , Nothing, Nothing, Nothing
                            ]
                    in
                        openSpaces board
                            |> Expect.equal ( List.range 0 8 )
            , test "returns a list only open of spaces on a partly empty board" <|
                \() ->
                    let
                        board =
                            [ Just "x", Just "o", Just "x"
                            , Just "x", Nothing, Just "o"
                            , Nothing, Nothing, Just "x"
                            ]
                    in
                        openSpaces board
                            |> Expect.equal [ 4, 6, 7 ]
            , test "returns empty list when given a full board" <|
                \() ->
                    let
                        board =
                            [ Just "x", Just "o", Just "x"
                            , Just "x", Just "o", Just "o"
                            , Just "o", Just "x", Just "x"
                            ]
                    in
                        openSpaces board
                            |> Expect.equal []
            ]
        , describe "isOpenSpaceOnBoard"
            [ test "returns true if space is open"
                ( \() ->
                    let
                        board =
                            [ Just "x", Just "o", Just "x"
                            , Just "x", Nothing, Just "o"
                            , Nothing, Nothing, Just "x"
                            ]
                    in
                        isOpenSpaceOnBoard 4 board
                            |> Expect.true "space should be open")
            , test "returns false if space is taken"
                ( \() ->
                    let
                        board =
                            [ Just "x", Just "o", Just "x"
                            , Just "x", Nothing, Just "o"
                            , Nothing, Nothing, Just "x"
                            ]
                    in
                        isOpenSpaceOnBoard 0 board
                            |> Expect.false "space should be taken")
            ]
        ]
