module Game.Ai exposing (..)

import Game.Board as Board exposing (Board)
import Game.Rules as Rules
import Game.Player as Player exposing (Player)

import Util.Math as Math
import Util.ListPlus as ListPlus


import Debug

type alias MiniMaxHelper =
    { board : Board
    , players : List Player
    , turnDeterminer : ( Int -> Bool )
    }


playTurn : Board -> List Player -> Maybe Int
playTurn board players =
    let
        miniMaxHelper = MiniMaxHelper board players ( getTurnDeterminer board )
    in
        bestMove miniMaxHelper


deduceTurn : Board -> Int
deduceTurn board =
    Board.openSpaces board
        |> List.length
        |> (-) ( List.length board )


getTurnDeterminer : Board -> ( Int -> Bool )
getTurnDeterminer board =
    if ( Math.isEven ( deduceTurn board ) ) then
        Math.isEven

    else
        Math.isOdd


getCurrentMarker : List Player -> Board.Space
getCurrentMarker players =
    List.head players
        |> Player.getMarkerOrEmpty


isCurrentPlayer : Board -> ( Int -> Bool ) -> Bool
isCurrentPlayer board turnDeterminer =
    deduceTurn board
        |> turnDeterminer


winPoints : Board -> ( Int -> Bool) -> Int
winPoints board turnDeterminer =
    let
        turn  =
            (deduceTurn board)

        maxPoints =
            ( List.length board ) + 1

        points =
            turn
                |> (-) maxPoints
    in
        if ( isCurrentPlayer board turnDeterminer ) then
            points

        else
            -points


chooseBestScore : List Int -> Board -> ( Int -> Bool ) -> Int
chooseBestScore scores board turnDeterminer =
    let
        bestScore =
            if (isCurrentPlayer board turnDeterminer) then
                List.maximum scores

            else
                List.minimum scores
    in
        case bestScore of
            Just score ->
                score

            Nothing ->
                0


scoreTurn : Board -> Int -> List Player -> ( Int -> Bool ) -> Int
scoreTurn board space players turnDeterminer =
    let
        turnMarker =
            getCurrentMarker players

        turn =
            deduceTurn board

        newBoard =
            Board.markBoardSpaceWith board space turnMarker
    in
        if Rules.hasWinner newBoard then
            winPoints board turnDeterminer

        else if Board.boardFull newBoard then
            0

        else
            miniMax ( MiniMaxHelper newBoard ( ListPlus.rotateOne players ) turnDeterminer )


calculateScores : MiniMaxHelper -> List Int
calculateScores miniMaxHelper =
    let
        { board, players, turnDeterminer } =
            miniMaxHelper
    in
        Board.openSpaces board
            |> List.map (\space -> scoreTurn board space players turnDeterminer)


miniMax : MiniMaxHelper -> Int
miniMax miniMaxHelper =
    let
        scores =  calculateScores miniMaxHelper
    in
        chooseBestScore scores miniMaxHelper.board miniMaxHelper.turnDeterminer


bestMove : MiniMaxHelper -> Maybe Int
bestMove miniMaxHelper =
    let
        { board, players, turnDeterminer } =
            miniMaxHelper

        openSpaces =
            Board.openSpaces board

        scores =
            List.map (\space -> scoreTurn board space players turnDeterminer) openSpaces

        scoredSpaces =
            List.map2 (,) scores openSpaces

    in
        List.maximum scoredSpaces
            |> Maybe.map Tuple.second
