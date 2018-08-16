module Game.Rules exposing (..)

import Game.Board as Board exposing (Board)
import Game.Player as Player exposing (Player)
import Util.ListPlus as ListPlus

import Array
import Set


hasWinner : Board -> Bool
hasWinner board =
    case (getWinner board) of
        Nothing ->
            False

        Just winner ->
            True


getWinner : Board -> Maybe Board.Space
getWinner board =
    potentialWins board
        |> List.partition didMeetWinCondition
        |> Tuple.first
        |> List.head
        |> Maybe.andThen List.head


didMeetWinCondition : List Board.Space -> Bool
didMeetWinCondition inARow =
    (not (List.any ((==) Board.Empty) inARow))
        && ((ListPlus.rotateOne inARow) == inARow)


potentialWins : Board -> List (List Board.Space)
potentialWins board =
    let
        winOptions =
            allWinOptions board
    in
        winOptions
            |> List.map
                (\winCondition ->
                    List.map
                        (\space -> Board.getMarkerFromSpace space board)
                        winCondition
                )


allWinOptions : Board -> List (List Int)
allWinOptions board =
    (diagonalWinOptions board)
        |> List.append (verticalWinOptions board)
        |> List.append (horizontalWinOptions board)


horizontalWinOptions : Board -> List (List Int)
horizontalWinOptions board =
    board
        |> List.indexedMap (\index _ -> index)
        |> ListPlus.split (Board.sideSize board)


verticalWinOptions : Board -> List (List Int)
verticalWinOptions board =
    colBuilder (Board.sideSize board) []


colBuilder : Int -> List (List Int) -> List (List Int)
colBuilder sideSize cols =
    let
        length =
            List.length cols
    in
        if (length < sideSize) then
            sideSize
                |> List.repeat (sideSize - 1)
                |> List.scanl (+) length
                |> List.singleton
                |> List.append cols
                |> colBuilder sideSize
        else
            cols


diagonalWinOptions : Board -> List (List Int)
diagonalWinOptions board =
    let
        sideSize =
            Board.sideSize board

        topLeftDiagonal =
            List.range 0 (sideSize - 1)
                |> List.map (\space -> (sideSize + 1) * space)

        topRightDiagonal =
            List.range 1 (sideSize)
                |> List.map (\space -> (sideSize - 1) * space)
    in
        []
            |> (::) topRightDiagonal
            |> (::) topLeftDiagonal
