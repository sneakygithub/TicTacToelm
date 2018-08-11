module Main exposing (..)

import BrowserInterface.Update as Update
import BrowserInterface.View as View
import BrowserInterface.Models as Models
import BrowserInterface.Msgs exposing (Msg)

import Html exposing (program)


subscriptions : Models.Model -> Sub Msg
subscriptions model =
    Sub.none


main =
    program
        { init = Models.init
        , view = View.view
        , update = Update.update
        , subscriptions = subscriptions
        }
