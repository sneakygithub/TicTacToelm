module Util.MathTest exposing (..)

import Expect
import Test exposing (..)

import Util.Math exposing (..)


suite : Test
suite =
    describe "Math"
        [ describe "isEven"
            [ test "Returns true if given an even number"
                ( \() ->
                    isEven 42
                        |> Expect.true "expected 42 to be even..." )
            , test "Returns false if given an odd number"
                ( \() ->
                    isEven 713
                        |> Expect.false "expected 713 to be not even" )
            ]
        , describe "isOdd"
            [ test "Returns false if given an even number"
                ( \() ->
                    isOdd 42
                        |> Expect.false "expected 42 to be not odd" )
            , test "Returns false if given an odd number"
                ( \() ->
                    isOdd 713
                        |> Expect.true "expected 713 to be odd" )
            ]
        ]
