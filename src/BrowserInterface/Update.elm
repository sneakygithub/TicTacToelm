module BrowserInterface.Update exposing (..)

import BrowserInterface.Msgs as Msgs
import BrowserInterface.Models as Models exposing (Model)

import Debug
import Game.Game as Game exposing (GameState)


update : Msgs.Msg -> Model -> ( Model, Cmd Msgs.Msg )
update msg model =
    let
        currentGameState = model.gameState
    in
        case msg of
            Msgs.Stop ->
                let
                    updatedGameState = { currentGameState | continue = False }
                in
                    ( { model | gameState = updatedGameState }, Cmd.none )

            Msgs.Continue ->
                let
                    updatedGameState = { currentGameState | continue = True }
                in
                    ( { model | gameState = updatedGameState }, Cmd.none )

            Msgs.Mark space->
                let
                    updatedGameState = Game.takeTurn currentGameState.board space
                in
                    ( { model | gameState = updatedGameState }, Cmd.none )

