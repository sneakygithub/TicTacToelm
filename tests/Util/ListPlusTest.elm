module Util.ListPlusTest exposing (..)

import Expect
import Test exposing (..)

import Util.ListPlus exposing (..)


suite : Test
suite =
    describe "ListPlus"
        [ describe "split"
            [ test "Splitting an empty list returns an empty list" <|
                \() ->
                    split 7 []
                        |> Expect.equal []
            , test "Splitting a list of 9 by 3 gets 3 sublists of equal length" <|
                \() ->
                    let
                        splitableList =
                            [ 'a', 'b', 'c',
                              'd', 'e', 'f',
                              'g', 'h', 'i'
                            ]

                        expectedResult =
                            [ [ 'a', 'b', 'c' ]
                            , [ 'd', 'e', 'f' ]
                            , [ 'g', 'h', 'i' ]
                            ]
                    in
                        split 3 splitableList
                            |> Expect.equal expectedResult
            , test "Splitting a list of 8 by 3 gets 3 sublists with the last list short one element" <|
                \() ->
                    let
                        splitableList =
                            [ 'a', 'b', 'c',
                              'd', 'e', 'f',
                              'g', 'h'
                            ]

                        expectedResult =
                            [ [ 'a', 'b', 'c' ]
                            , [ 'd', 'e', 'f' ]
                            , [ 'g', 'h' ]
                            ]
                    in
                        split 3 splitableList
                            |> Expect.equal expectedResult
            , test "Splitting a list of 8 by 2 gets 4 sublists with the last list short one element" <|
                \() ->
                    let
                        splitableList =
                            [ 'a', 'b', 'c',
                              'd', 'e', 'f',
                              'g', 'h'
                            ]

                        expectedResult =
                            [ [ 'a', 'b']
                            , [ 'c', 'd' ]
                            , [ 'e', 'f' ]
                            , [ 'g', 'h' ]
                            ]
                    in
                        split 2 splitableList
                            |> Expect.equal expectedResult
            , test "Splitting a list by 0 gets an empty list" <|
                \() ->
                    let
                        splitableList =
                            [ 'a', 'b', 'c',
                              'd', 'e', 'f',
                              'g', 'h', 'i'
                            ]
                    in
                        split 0 splitableList
                            |> Expect.equal []
            ]
        , describe "rotate"
        [ test "When given an empty list, it returns an empty list" <|
            \() ->
                rotateOne []
                    |> Expect.equal []
        , test "When given a list of one, it returns the list" <|
            \() ->
                rotateOne [ "hello!" ]
                    |> Expect.equal [ "hello!" ]
        , test "When given a list of two, it swaps the order" <|
            \() ->
                rotateOne [1, 2]
                    |> Expect.equal [ 2, 1 ]
        ,test "When given a list of more than two items, it moves the first item to the last spot" <|
            \() ->
                rotateOne [ "first", "middle", "last" ]
                    |> Expect.equal [ "middle", "last", "first" ]
        ]
    ]
