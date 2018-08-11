module BrowserInterface.View exposing (..)

import BrowserInterface.Models exposing (Model)
import BrowserInterface.Msgs exposing (Msg)
import BrowserInterface.Msgs as Msgs

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style, attribute)
import Html.Events exposing (onClick)


view : Model -> Html Msg
view model =
    loop model


loop : Model -> Html Msg
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


split : Int -> List a -> List (List a)
split nestedListLength list =
  case List.take nestedListLength list of
    [] ->
        []

    listHead ->
        List.drop nestedListLength list
            |> split nestedListLength
            |> (::) listHead


-- TODO: Could this adhere more to the SRP?
renderBoard : List (Maybe String) -> Html Msg
renderBoard board =
    let
        spaces = List.indexedMap renderSpace board
        rows = split 3 spaces
        renderedRows = List.map renderRow rows

    in
        div [ class "board" ] renderedRows



renderRow : List ( Html Msg ) -> Html Msg
renderRow spaces =
     div [ class "row" ] spaces


renderSpace : Int -> ( Maybe String ) -> Html Msg
renderSpace index space =
    case space of
        Just space ->
            div [spaceStyle] [text space]

        Nothing ->
            div [spaceStyle, onClick (Msgs.Mark index) ] [ text " "]


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
