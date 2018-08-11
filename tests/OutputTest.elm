module OutputTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Output exposing (..)
import Messages


suite : Test
suite =
    describe "Intro"
    [ test "Returns the introduction" <|
        \_ ->
            Expect.equal intro_message Messages.intro_message
            ]

