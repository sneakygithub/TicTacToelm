module Util.ListPlus exposing (..)

import Debug


split : Int -> List a -> List (List a)
split nestedListLength list =
  case List.take nestedListLength list of
    [] ->
        []

    listHead ->
        List.drop nestedListLength list
            |> split nestedListLength
            |> (::) listHead


rotateOne : List a -> List a
rotateOne list =
    let
        head =
            case List.head list of
                Nothing ->
                    []

                Just content ->
                    List.singleton content
        tail =
            list
                |>List.tail
                |>Maybe.withDefault []
    in
        List.append tail head


