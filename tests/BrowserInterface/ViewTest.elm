module BrowserInterface.ViewTest exposing (..)

import Expect
import Test exposing (..)
import Html exposing (div, text)
import Html.Events exposing (onClick)

import BrowserInterface.View exposing (..)
import BrowserInterface.Msgs as Msgs

import Game.Board exposing (Space(..))


suite : Test
suite =
    describe "View"
        [ describe "renderSpace"
            [ test "Given an empty space, it renders an empty div" <|
                \() ->
                    let
                        space =
                            Empty

                        expectedResult =
                            div [ spaceStyle, onClick (Msgs.Mark 6) ] [ text " " ]
                    in
                        renderSpace 6 space
                            |> Expect.equal expectedResult
            , test "Given taken space, it renders the appropriate text in a div" <|
                \() ->
                    let
                        space =
                            X

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
                            [ renderSpace 0 Empty
                            , renderSpace 1 Empty
                            , renderSpace 2 Empty
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
                            List.repeat 9 Empty

                        divs =
                            div [ spaceStyle, onClick (Msgs.Mark 4) ] [ text " " ]

                        innerDiv1 =
                            div [class "row"] (
                                [ renderSpace 0 Empty
                                , renderSpace 1 Empty
                                , renderSpace 2 Empty
                                ])

                        innerDiv2 =
                            div [class "row"] (
                                [ renderSpace 3 Empty
                                , renderSpace 4 Empty
                                , renderSpace 5 Empty
                                ])

                        innerDiv3 =
                            div [class "row"] (
                                [ renderSpace 6 Empty
                                , renderSpace 7 Empty
                                , renderSpace 8 Empty
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
                            [ X, O, X
                            , O, O, X
                            , X, X, O
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
                            [ Empty, Empty, O
                            , O, Empty, X
                            , X, X, O
                            ]

                        xdiv =
                            div [ spaceStyle ] [ text "x" ]

                        odiv =
                            div [ spaceStyle ] [ text "o" ]

                        innerDivs =
                            [ div [ class "row" ] [ (renderSpace 0 Empty), (renderSpace 1 Empty), odiv ]
                            , div [ class "row" ] [ odiv, (renderSpace 4 Empty), xdiv ]
                            , div [ class "row" ] [ xdiv, xdiv, odiv ]
                            ]

                        expectedResult =
                            div [ class "board" ] innerDivs
                    in
                        renderBoard spaces
                            |> Expect.equal expectedResult
            ]
        , describe "spaceToText"
            [ test "When given an X marked space, it returns x" <|
                \() ->
                    spaceToText X
                        |> Expect.equal "x"
            , test "When given an O marked space, it returns o" <|
                \() ->
                    spaceToText O
                        |> Expect.equal "o"
            , test "When given anything else it marks ?" <|
                \() ->
                    spaceToText Empty
                        |> Expect.equal " "

            ]
        ]
