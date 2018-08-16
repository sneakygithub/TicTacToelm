module BrowserInterface.Models exposing (..)

import BrowserInterface.Msgs exposing (Msg)
import Game.Game as Game exposing (GameState)


type alias Model =
    { page : Page
    , gameState : GameState
    , gameView : List String
    }


type Page
    = GamePage



init : ( Model, Cmd Msg )
init =
    ( Model GamePage Game.freshGame ["x", "o"], Cmd.none )


