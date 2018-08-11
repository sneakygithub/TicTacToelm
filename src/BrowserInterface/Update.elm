module BrowserInterface.Update exposing (..)

import BrowserInterface.Msgs as Msgs
import BrowserInterface.Models exposing (Model)


update : Msgs.Msg -> Model -> ( Model, Cmd Msgs.Msg )
update msg model =
    case msg of
        Msgs.Stop ->
            ( False, Cmd.none )

        Msgs.Continue ->
            ( True, Cmd.none )
