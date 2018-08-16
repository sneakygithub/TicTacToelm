module Game.Game exposing (..)

import Game.Ai as Ai
import Game.Board as Board
import Game.Player as Player exposing (Player)
import Game.Rules as Rules
import Util.ListPlus as ListPlus


continueGame : Board.Board -> Bool
continueGame board =
    not
        ((Board.boardFull board)
            || (Rules.hasWinner board)
        )


type alias GameState =
    { continue : Bool
    , board : Board.Board
    , players : List Player
    }


freshGame =
    let
        board =
            Board.renderEmptyBoard 9

        players =
            [ Player (Player.Human) Board.X, Player (Player.Ai) Board.O ]
    in
        GameState True board players


takeTurn : GameState -> Maybe Int -> GameState
takeTurn gameState move =
    case move of
        Nothing ->
            Ai.playTurn gameState.board (ListPlus.rotateOne gameState.players)
                |> takeTurn gameState

        Just move ->
            let
                player =
                    currentPlayer gameState

                newBoard =
                    Player.takeTurnOnBoard player move gameState.board

                continue =
                    continueGame newBoard

                players =
                    ListPlus.rotateOne gameState.players

                updatedGameState =
                    (GameState continue newBoard players)
            in
                case (currentPlayer updatedGameState) of
                    Just currentPlayer ->
                        case (currentPlayer.kind) of
                            Player.Ai ->
                                if continue then
                                    takeTurn updatedGameState Nothing
                                else
                                    updatedGameState

                            Player.Human ->
                                updatedGameState

                    Nothing ->
                        freshGame


currentPlayer : GameState -> Maybe Player
currentPlayer gameState =
    List.head gameState.players
