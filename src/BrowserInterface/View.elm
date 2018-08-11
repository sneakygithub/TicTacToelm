module BrowserInterface.View exposing (..)

import BrowserInterface.Models exposing (Model)
import BrowserInterface.Msgs exposing (Msg)
import BrowserInterface.Msgs as Msgs

import Html exposing (Html, button, div, text, program)
import Html.Events exposing (onClick)

view : Model -> Html Msg
view model =
    loop model


loop : Bool -> Html Msg
loop model =
    if model then
        div []
            [ button [ onClick Msgs.Continue ] [ text "Continue!" ]
            ,  button [ onClick Msgs.Stop ] [ text "Stop" ]
            ]
    else
        div []
            [ text "Game Over" ]
