module Game.Board exposing (..)

import Array


type Space
    = Empty
    | X
    | O


type alias Board =
    List Space


renderEmptyBoard : Int -> Board
renderEmptyBoard totalSpaces =
    List.repeat totalSpaces Empty


boardFull : Board -> Bool
boardFull board =
    board
        |> openSpaces
        |> List.length
        |> (==) 0


markBoardSpaceWith : Board -> Int -> Space -> Board
markBoardSpaceWith board space marker =
    if isOpenSpaceOnBoard space board then
        Array.fromList board
            |> Array.set space marker
            |> Array.toList
    else
        board


isOpenSpaceOnBoard : Int -> Board -> Bool
isOpenSpaceOnBoard space board =
    (getMarkerFromSpace space board) == Empty


openSpaces : Board -> List Int
openSpaces board =
    board
        |> List.indexedMap (\index _ -> index)
        |> List.filter (\space -> isOpenSpaceOnBoard space board)


sideSize : Board -> Int
sideSize board =
    List.length board
        |> toFloat
        |> sqrt
        |> round


getMarkerFromSpace : Int -> Board -> Space
getMarkerFromSpace space board =
    Array.fromList board
        |> Array.get space
        |> Maybe.withDefault Empty
