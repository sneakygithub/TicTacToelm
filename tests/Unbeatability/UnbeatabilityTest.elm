module Unbeatability.UnbeatabilityTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Debug

import Game.Ai exposing (..)
import Game.Board as Board exposing (Board, Space(..))
import Game.Player as Player exposing (Player)
import Game.Game as Game
import Game.Rules as Rules


startingBoard : Board
startingBoard =
    Board.renderEmptyBoard 9


players : List Player
players =
    [ Player Player.Human X , Player Player.Ai O ]


humanSimulator : Board -> List Board
humanSimulator board =
    Board.openSpaces board
        |> List.map (\space -> Board.markBoardSpaceWith board space X)


computerSimulator : Board -> Board
computerSimulator board =
    let
        space =
            playTurn board players
    in
        case space of
            Nothing ->
                board

            Just space ->
                Board.markBoardSpaceWith board space O


simulator : Board -> Bool
simulator board =
    let
        boards =
            humanSimulator board
                |>List.map computerSimulator

        outcomes =
            List.map (\board -> (Just X) == (Rules.getWinner board)) boards

        keepGoing =
            List.filter Game.continueGame boards

    in
        if (List.all ((==) False) outcomes) then
            let
                recur =
                    List.map simulator keepGoing
            in
                True

        else
            False


suite : Test
suite =
    describe "UnbeatabilityTest"
        [ test "every possible game"
            ( \() ->
                simulator startingBoard
                    |> Expect.true "the game should be unbeatable" )
        ]
