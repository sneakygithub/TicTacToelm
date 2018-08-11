module BrowserInterface.Models exposing (..)

import BrowserInterface.Msgs exposing (Msg)
import Game.Board exposing (Board)

type alias Model =
    { continue : Bool
    , board: Board
    }


init : ( Model, Cmd Msg )
init =
    ( Model True (List.repeat 9 Nothing), Cmd.none )



