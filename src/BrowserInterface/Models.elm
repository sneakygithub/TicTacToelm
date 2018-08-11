module BrowserInterface.Models exposing (..)

import BrowserInterface.Msgs exposing (Msg)

type alias Model =
    Bool


init : ( Model, Cmd Msg )
init =
    ( True, Cmd.none )

