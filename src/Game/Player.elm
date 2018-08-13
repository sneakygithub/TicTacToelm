module Game.Player exposing (..)

import Game.Board as Board


type PlayerType
    = Human
    | Ai

type alias Player =
    { kind : PlayerType
    , marker : String
    }


takeTurnOnBoard : Maybe Player -> Int -> Board.Board -> Board.Board
takeTurnOnBoard player move board =
    Board.markBoardSpaceWith board move (getMaybeMarker player)


getMaybeMarker : Maybe Player -> Maybe String
getMaybeMarker player =
    Maybe.map getMarker player


getMarker : Player -> String
getMarker player =
    player.marker
