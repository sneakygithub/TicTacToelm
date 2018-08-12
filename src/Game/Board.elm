module Game.Board exposing (..)

import Array
import Debug


type alias Board = List ( Maybe String )


boardFull : Board -> Bool
boardFull board =
    board
        |> openSpaces
        |> List.length
        |> (==) 0


markBoardSpaceWith : Board -> Int -> String -> Board
markBoardSpaceWith board space marker =
    Array.fromList board
        |> Array.set space (Just marker)
        |> Array.toList


isOpenSpaceOnBoard : Int -> Board -> Bool
isOpenSpaceOnBoard space board =
    let
        existingMarker =
            Array.fromList board
                |> Array.get space
    in
        existingMarker == Just Nothing


openSpaces : Board -> List Int
openSpaces board =
    let
        indexOffset = 1
    in
        List.length board
            |>List.range indexOffset
            |> List.map (\index -> index - indexOffset)
            |> List.filter (\space -> isOpenSpaceOnBoard space board)
