module Game.Game exposing (..)


continueGame : Bool -> String
continueGame flag =
    case flag of
        True ->
            "continue"

        False ->
            "game over"
