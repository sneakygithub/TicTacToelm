module BrowserInterface.ViewTest exposing (..)

import Expect
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Debug
import Html exposing (div, text)
import Html.Events exposing (onClick)

import BrowserInterface.View exposing (..)
import BrowserInterface.Msgs as Msgs


suite : Test
suite =
    describe "View"
        [ describe "renderSpace"
            [ test "Given an empty space, it renders an empty div" <|
                \() ->
                    let
                        space =
                            Nothing

                        expectedResult =
                            div [ spaceStyle, onClick (Msgs.Mark 6) ] [ text " " ]
                    in
                        renderSpace 6 space
                            |> Expect.equal expectedResult
            , test "Given taken space, it renders the appropriate text in a div" <|
                \() ->
                    let
                        space =
                            Just "x"

                        expectedResult =
                            div [ spaceStyle ] [ text "x" ]
                    in
                        renderSpace 0 space
                            |> Expect.equal expectedResult
            ]
        , describe "renderRow"
            [ test "Given a list of 'empty' spaces, it renders the same number of empty divs" <|
                \() ->
                    let
                        spaces =
                            [ renderSpace 0 Nothing
                            , renderSpace 1 Nothing
                            , renderSpace 2 Nothing
                            ]

                        expectedResult =
                            div [ class "row" ] spaces
                    in
                        renderRow spaces
                            |> Expect.equal expectedResult
            , test "Given a list of taken spaces, it renders the proper markers" <|
                \() ->
                    let
                        xdiv =
                            div [ spaceStyle ] [ text "x" ]

                        odiv =
                            div [ spaceStyle ] [ text "o" ]

                        spaces =
                            [xdiv, odiv, xdiv]

                        expectedResult =
                            div [ class "row" ] spaces
                    in
                        renderRow spaces
                            |> Expect.equal expectedResult
            , test "Given a list of taken and empty spaces, it renders the proper markers or empty spaces" <|
                \() ->
                    let
                        blankdiv =
                            div [ spaceStyle, onClick (Msgs.Mark 0) ] [ text " " ]

                        xdiv =
                            div [ spaceStyle ] [ text "x" ]

                        odiv =
                            div [ spaceStyle ] [ text "o" ]

                        spaces =
                            [blankdiv, odiv, xdiv]

                        expectedResult =
                            div [ class "row" ] spaces
                    in
                        renderRow spaces
                            |> Expect.equal expectedResult
            ]
        , describe "renderBoard"
            [ test "Given a list of empty spaces, it renders an empty board" <|
                \() ->
                    let
                        spaces =
                            List.repeat 9 Nothing

                        divs =
                            div [ spaceStyle, onClick (Msgs.Mark 4) ] [ text " " ]

                        innerDiv1 =
                            div [class "row"] (
                                [ renderSpace 0 Nothing
                                , renderSpace 1 Nothing
                                , renderSpace 2 Nothing
                                ])

                        innerDiv2 =
                            div [class "row"] (
                                [ renderSpace 3 Nothing
                                , renderSpace 4 Nothing
                                , renderSpace 5 Nothing
                                ])

                        innerDiv3 =
                            div [class "row"] (
                                [ renderSpace 6 Nothing
                                , renderSpace 7 Nothing
                                , renderSpace 8 Nothing
                                ])


                        expectedResult =
                            div [ class "board" ] [ innerDiv1, innerDiv2, innerDiv3]
                    in
                        renderBoard spaces
                            |> Expect.equal expectedResult
            , test "Given a list of taken spaces, it renders the proper markers" <|
                \() ->
                    let
                        spaces =
                            [ Just "x", Just "o", Just "x"
                            , Just "o", Just "o", Just "x"
                            , Just "x", Just "x", Just "o"
                            ]

                        xdiv =
                            div [ spaceStyle ] [ text "x" ]

                        odiv =
                            div [ spaceStyle ] [ text "o" ]

                        innerDivs =
                            [ div [ class "row" ] [ xdiv, odiv, xdiv ]
                            , div [ class "row" ] [ odiv, odiv, xdiv ]
                            , div [ class "row" ] [ xdiv, xdiv, odiv ]
                            ]

                        expectedResult =
                            div [ class "board" ] innerDivs
                    in
                        renderBoard spaces
                            |> Expect.equal expectedResult
            ,test "Given a list of taken and empty spaces, it renders the proper markers or empty spaces" <|
                \() ->
                    let
                        spaces =
                            [ Nothing, Nothing, Just "o"
                            , Just "o", Nothing, Just "x"
                            , Just "x", Just "x", Just "o"
                            ]

                        xdiv =
                            div [ spaceStyle ] [ text "x" ]

                        odiv =
                            div [ spaceStyle ] [ text "o" ]

                        innerDivs =
                            [ div [ class "row" ] [ (renderSpace 0 Nothing), (renderSpace 1 Nothing), odiv ]
                            , div [ class "row" ] [ odiv, (renderSpace 4 Nothing), xdiv ]
                            , div [ class "row" ] [ xdiv, xdiv, odiv ]
                            ]

                        expectedResult =
                            div [ class "board" ] innerDivs
                    in
                        renderBoard spaces
                            |> Expect.equal expectedResult
            ]
        , describe "split"
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
        ]
