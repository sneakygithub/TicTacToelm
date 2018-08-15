module BrowserInterface.View exposing (..)

import BrowserInterface.Models as Models exposing (Model)
import BrowserInterface.Msgs exposing (Msg)
import BrowserInterface.Msgs as Msgs

import Util.ListPlus as ListPlus

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style, attribute)
import Html.Events exposing (onClick)


import Game.Game exposing (GameState)
import Game.Board as Board

import Debug

view : Model -> Html Msg
view model =
    case model.page of
        Models.WelcomePage ->
            div [] [ text "PLACEHOLDER WELCOME TEXT"]

        Models.GamePage ->
            loop (Debug.log "I hate this" model.gameState)


loop : GameState -> Html Msg
loop model =
    if model.continue then
        div []
            [ renderBoard model.board
            , div [ onClick Msgs.Continue ] [ text "Continue!" ]
            ,  div [ onClick Msgs.Stop ] [ text "Stop" ]
            ]
    else
        div []
            [ text "Game Over" ]


-- TODO: Could this adhere more to the SRP?
renderBoard : Board.Board -> Html Msg
renderBoard board =
    let
        sideSize = Board.sideSize board
        spaces = List.indexedMap renderSpace board
        rows = ListPlus.split 3 spaces
        renderedRows = List.map renderRow rows

    in
        div [ class "board" ] renderedRows



renderRow : List ( Html Msg ) -> Html Msg
renderRow spaces =
     div [ class "row" ] spaces


renderSpace : Int -> Board.Space -> Html Msg
renderSpace index space =
    case space of
        Board.Empty ->
            div [spaceStyle, onClick (Msgs.Mark index) ] [ text " "]

        _ ->
            div [spaceStyle] [ text (spaceToText space) ]


spaceToText : Board.Space -> String
spaceToText space =
    case space of
        Board.X ->
            "x"

        Board.O ->
            "o"

        Board.Empty ->
            "?"


class : String -> Html.Attribute msg
class name =
  attribute "class" name


spaceStyle : Html.Attribute msg
spaceStyle =
    style
        [ ("font-size", "20px")
        , ("font-family", "monospace")
        , ("display", "inline-block")
        , ("width", "50px")
        , ("height", "50px")
        , ("text-align", "center")
        , ("border", "2px solid blue") ]
