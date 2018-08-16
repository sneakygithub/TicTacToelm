module Game.Player exposing (..)

import Game.Board as Board


type PlayerType
    = Human
    | Ai


type alias Player =
    { kind : PlayerType
    , marker : Board.Space
    }


takeTurnOnBoard : Maybe Player -> Int -> Board.Board -> Board.Board
takeTurnOnBoard player move board =
    Board.markBoardSpaceWith board move (getMarkerOrEmpty player)


getMarkerOrEmpty : Maybe Player -> Board.Space
getMarkerOrEmpty player =
    case player of
        Nothing ->
            Board.Empty

        Just player ->
            player.marker
