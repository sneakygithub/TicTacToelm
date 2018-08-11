module Game.Game exposing (..)

import Game.Board as Board

continueGame : Board.Board -> Bool
continueGame board =
    not ( Board.boardFull board )

