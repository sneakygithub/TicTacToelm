module Game.GameTest exposing (..)

import Expect
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Game.Game exposing (..)


suite : Test
suite =
    describe "Game"
        [ describe "continueGame"
            [ test "A full board ends the game" <|
                \() ->
                    let
                        fullBoard =
                            [ Just "x", Just "o", Just "x"
                            , Just "x", Just "o", Just "o"
                            , Just "o", Just "x", Just "x"
                            ]
                    in
                        continueGame fullBoard
                            |> Expect.equal False
            , test "When there are moves left, the game continues" <|
                \() ->
                    let
                        openBoard =
                            [ Just "x", Just "o", Just "x"
                            , Just "x", Nothing, Just "o"
                            , Just "o", Just "x", Just "x"
                            ]
                    in
                        continueGame openBoard
                            |> Expect.equal True
            ]
        ]
