module Board exposing (..)

type alias Board = List ( Maybe String )

boardFull : Board -> Bool
boardFull board =
    not ( List.member Nothing board )
