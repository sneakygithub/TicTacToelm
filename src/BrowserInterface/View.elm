module BrowserInterface.View exposing (..)

import BrowserInterface.Models as Models exposing (Model)
import BrowserInterface.Msgs as Msgs exposing (Msg)
import Game.Board as Board
import Game.Game exposing (GameState)
import Util.ListPlus as ListPlus

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style, attribute)
import Html.Events exposing (onClick)



view : Model -> Html Msg
view model =
    case model.page of
        Models.GamePage ->
            loop model.gameState


loop : GameState -> Html Msg
loop model =
    if model.continue then
        div []
            [ renderBoard model.board
            , div [ onClick Msgs.Stop ] [ text "Stop" ]
            ]
    else
        div []
            [ text "Game Over" ]


renderActiveBoard : Board.Board -> Html Msg
renderActiveBoard board =
    List.indexedMap renderSpace board
        |> renderBoard board


renderEndBoard : Board.Board -> Html Msg
renderEndBoard board =
    List.indexedMap renderSpace board
        |> renderBoard board


renderBoard : Board.Board -> Html Msg
renderBoard board spaces =
    let
        sideSize =
            Board.sideSize board

        rows =
            ListPlus.split 3 spaces

        renderedRows =
            List.map renderRow rows
    in
        div [ class "board" ] renderedRows


renderRow : List (Html Msg) -> Html Msg
renderRow spaces =
    div [ class "row" ] spaces


renderSpace : Int -> Board.Space -> Html Msg
renderSpace index space =
    case space of
        Board.Empty ->
            div [ class "space", onClick (Msgs.Mark index) ] [ text " " ]

        _ ->
            renderInactiveSpace index space


renderInactiveSpace : Int -> Board.Space -> Html Msg
renderInactiveSpace index space =
    div [ class "space" ] [ text (spaceToText space) ]


spaceToText : Board.Space -> String
spaceToText space =
    case space of
        Board.X ->
            "x"

        Board.O ->
            "o"

        Board.Empty ->
            " "


class : String -> Html.Attribute msg
class name =
    attribute "class" name
