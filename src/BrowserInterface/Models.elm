module BrowserInterface.Models exposing (..)

import BrowserInterface.Msgs exposing (Msg)
import Game.Game as Game exposing (GameState)


type alias Model =
    { page : Page
    , gameState : GameState
    }


type Page
    = WelcomePage
    | GamePage



init : ( Model, Cmd Msg )
init =
    ( Model GamePage Game.freshGame, Cmd.none )


