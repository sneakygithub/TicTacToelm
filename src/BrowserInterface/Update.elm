module BrowserInterface.Update exposing (..)

import BrowserInterface.Msgs as Msgs
import BrowserInterface.Models exposing (Model)
import Game.Board as Board


update : Msgs.Msg -> Model -> ( Model, Cmd Msgs.Msg )
update msg model =
    case msg of
        Msgs.Stop ->
            ( Model False model.board, Cmd.none )

        Msgs.Continue ->
            ( Model True model.board, Cmd.none )

        Msgs.Mark space->
            ( Model True ( Board.markBoardSpaceWith model.board space "x" ), Cmd.none )

