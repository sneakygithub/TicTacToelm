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
                            div [ class "space", onClick (Msgs.Mark 6) ] [ text " " ]
                    in
                        renderSpace 6 space
                            |> Expect.equal expectedResult
            , test "Given taken space, it renders the appropriate text in a div" <|
                \() ->
                    let
                        space =
                            X

                        expectedResult =
                            div [ class "space" ] [ text "x" ]
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
                            div [ class "space" ] [ text "x" ]

                        odiv =
                            div [ class "space" ] [ text "o" ]

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
                            div [ class "space", onClick (Msgs.Mark 0) ] [ text " " ]

                        xdiv =
                            div [ class "space" ] [ text "x" ]

                        odiv =
                            div [ class "space" ] [ text "o" ]

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
                        board =
                            List.repeat 9 Empty

                        spaces =
                                [ renderSpace 0 Empty
                                , renderSpace 1 Empty
                                , renderSpace 2 Empty
                                , renderSpace 3 Empty
                                , renderSpace 4 Empty
                                , renderSpace 5 Empty
                                , renderSpace 6 Empty
                                , renderSpace 7 Empty
                                , renderSpace 8 Empty
                                ]

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
                        renderBoard board spaces
                            |> Expect.equal expectedResult
            , test "Given a list of taken spaces, it renders the proper markers" <|
                \() ->
                    let
                        board =
                            [ X, O, X
                            , O, O, X
                            , X, X, O
                            ]

                        xdiv =
                            div [ class "space" ] [ text "x" ]

                        odiv =
                            div [ class "space" ] [ text "o" ]

                        spaces =
                                [ xdiv, odiv, xdiv
                                , odiv, odiv, xdiv
                                , xdiv, xdiv, odiv
                                ]

                        innerDivs =
                            [ div [ class "row" ] [ xdiv, odiv, xdiv ]
                            , div [ class "row" ] [ odiv, odiv, xdiv ]
                            , div [ class "row" ] [ xdiv, xdiv, odiv ]
                            ]

                        expectedResult =
                            div [ class "board" ] innerDivs
                    in
                        renderBoard board spaces
                            |> Expect.equal expectedResult
            ,test "Given a list of taken and empty spaces, it renders the proper markers or empty spaces" <|
                \() ->
                    let
                        board =
                            [ Empty, Empty, O
                            , O, Empty, X
                            , X, X, O
                            ]

                        xdiv =
                            div [ class "space" ] [ text "x" ]

                        odiv =
                            div [ class "space" ] [ text "o" ]

                        spaces =
                                [ (renderSpace 0 Empty), (renderSpace 1 Empty), odiv
                                , odiv, (renderSpace 4 Empty), xdiv
                                , xdiv, xdiv, odiv
                                ]

                        innerDivs =
                            [ div [ class "row" ] [ (renderSpace 0 Empty), (renderSpace 1 Empty), odiv ]
                            , div [ class "row" ] [ odiv, (renderSpace 4 Empty), xdiv ]
                            , div [ class "row" ] [ xdiv, xdiv, odiv ]
                            ]

                        expectedResult =
                            div [ class "board" ] innerDivs
                    in
                        renderBoard board spaces
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
