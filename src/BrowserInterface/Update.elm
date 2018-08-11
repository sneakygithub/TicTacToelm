module BrowserInterface.Update exposing (..)

import BrowserInterface.Msgs as Msgs
import BrowserInterface.Models exposing (Model)
import Game.Board as Board
-- TODO: Get this game board out of here! IT should only interface with Game
import Game.Game as Game


update : Msgs.Msg -> Model -> ( Model, Cmd Msgs.Msg )
update msg model =
    case msg of
        Msgs.Stop ->
            ( Model False model.board, Cmd.none )

        Msgs.Continue ->
            ( Model True model.board, Cmd.none )

        Msgs.Mark space->
            let
                newBoard = Board.markBoardSpaceWith model.board space "x"
                continueGame = Game.continueGame newBoard
            in
                ( Model continueGame newBoard , Cmd.none )

