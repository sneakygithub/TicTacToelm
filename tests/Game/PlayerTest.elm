module Game.PlayerTest exposing (..)

import Expect
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Game.Player exposing (..)


suite : Test
suite =
    describe "Player"
        [ describe "getMaybeMarker"
            [ test "When given an Ai player, it returns the marker" <|
                \() ->
                getMaybeMarker ( Just ( Player Ai "🤖") )
                    |> Expect.equal ( Just "🤖" )
            , test "When given a Human player, it returns the marker" <|
                \() ->
                getMaybeMarker ( Just (Player Human "🚹") )
                    |> Expect.equal ( Just "🚹" )
            , test "When given Nothing it returns Nothing" <|
                \() ->
                getMaybeMarker Nothing
                    |> Expect.equal Nothing
            ]
        ]


