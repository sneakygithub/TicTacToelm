module Game.BoardTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Game.Board exposing (..)


suite : Test
suite =
    describe "Board"
        [ describe "renderEmptyBoard"
            [ test "returns a board of the right number of empty spaces" <|
                \() ->
                    let
                        board =
                            [ Empty, Empty, Empty
                            , Empty, Empty, Empty
                            , Empty, Empty, Empty
                            ]
                    in
                        renderEmptyBoard 9
                            |> Expect.equal board
            ]
        , describe "boardFull"
            [ test "Returns false if board contains any empty space"
                ( \() ->
                    boardFull [ X, O, X,
                                X, Empty, O,
                                Empty, Empty, X
                              ]
                        |> Expect.false "expected the board have open spaces" )
            , test "Returns true if board spaces are filled"
                ( \() ->
                    boardFull [ X, O, X,
                                X, O, O,
                                O, X, X
                              ]
                        |> Expect.true "expected the board to be full" )
            ]
        , describe "markBoardSpaceWith"
            [ test "Returns a board with the desired space marked when the board is partly filled" <|
                \() ->
                    let
                        startingBoard =
                            [ Empty, O, X,
                              X, Empty, O,
                              Empty, Empty, X
                            ]

                        expectedBoard =
                            [ Empty, O, X,
                              X, O, O,
                              Empty, Empty, X
                            ]
                    in
                        markBoardSpaceWith startingBoard 4 (O)
                            |> Expect.equal expectedBoard
            , test "Returns a board with the desired space marked when given an empty board" <|
                \() ->
                    let
                        startingBoard =
                            [ Empty, Empty, Empty,
                              Empty, Empty, Empty,
                              Empty, Empty, Empty
                            ]

                        expectedBoard =
                            [ Empty, Empty, Empty,
                              Empty, Empty, Empty,
                              Empty, Empty, X
                            ]
                    in
                        markBoardSpaceWith startingBoard 8 (X)
                            |> Expect.equal expectedBoard
            , test "Returns the same board it was given when the space is taken" <|
                \() ->
                    let
                        startingBoard =
                            [ X, O, O
                            , X, Empty, O
                            , Empty, Empty, X
                            ]
                    in
                        markBoardSpaceWith startingBoard 8 ( O )
                            |> Expect.equal startingBoard
            ]
        , describe "openSpaces"
            [ test "returns an list of all space indices on an entirely empty board" <|
                \() ->
                    let
                        board =
                            [ Empty, Empty, Empty
                            , Empty, Empty, Empty
                            , Empty, Empty, Empty
                            ]
                    in
                        openSpaces board
                            |> Expect.equal ( List.range 0 8 )
            , test "returns a list only open of spaces on a partly empty board" <|
                \() ->
                    let
                        board =
                            [ X, O, X
                            , O, Empty, O
                            , Empty, Empty, X
                            ]
                    in
                        openSpaces board
                            |> Expect.equal [ 4, 6, 7 ]
            , test "returns empty list when given a full board" <|
                \() ->
                    let
                        board =
                            [ X, O, X
                            , X, O, O
                            , O, X, X
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
                            [ X, O, Empty
                            , X, Empty, O
                            , Empty, Empty, X
                            ]
                    in
                        isOpenSpaceOnBoard 4 board
                            |> Expect.true "space should be open")
            , test "returns false if space is taken"
                ( \() ->
                    let
                        board =
                            [ X, O, X
                            , X, Empty, O
                            , Empty, Empty, Empty
                            ]
                    in
                        isOpenSpaceOnBoard 0 board
                            |> Expect.false "space should be taken")
            ]
        , describe "sideSize"
            [ test "When given a 9 space (3x3) board, it returns 3" <|
                \() ->
                    let
                        board =
                            [ X, O, O
                            , X, Empty, O
                            , Empty, Empty, X
                            ]
                    in
                        sideSize board
                            |> Expect.equal 3
            ]
        , describe "getMaybeMarkerFromSpace"
            [ test "Returns a marker from a marked space" <|
                \() ->
                    let
                        board =
                            [ X, O, X
                            , O, Empty, O
                            , Empty, Empty, X
                            ]
                    in
                        getMarkerFromSpace 1 board
                            |> Expect.equal O
            , test "Returns Empty from an empty space" <|
                \() ->
                    let
                        board =
                            [ X, O, X
                            , O, Empty, O
                            , Empty, Empty, X
                            ]
                    in
                        getMarkerFromSpace 4 board
                            |> Expect.equal Empty
            ]
        ]
