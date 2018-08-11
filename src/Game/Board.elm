module Game.Board exposing (..)

import Array


type alias Board = List ( Maybe String )


boardFull : Board -> Bool
boardFull board =
    not ( List.member Nothing board )


markBoardSpaceWith : Board -> Int -> String -> Board
markBoardSpaceWith board space marker =
    Array.fromList board
        |> Array.set space (Just marker)
        |> Array.toList


