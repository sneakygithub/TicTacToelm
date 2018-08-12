module Game.Game exposing (..)

import Game.Board as Board

continueGame : Board.Board -> Bool
continueGame board =
    not ( Board.boardFull board )


type alias GameState =
    { continue : Bool
    , board : Board.Board
    }


freshGame = GameState True ( List.repeat 9 Nothing )


takeTurn : Board.Board -> Int -> GameState
takeTurn board space =
    let
        newBoard = Board.markBoardSpaceWith board space "x"

        continue = continueGame newBoard
    in
        ( GameState continue newBoard )
