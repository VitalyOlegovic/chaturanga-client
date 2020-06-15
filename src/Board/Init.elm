module Board.Init exposing (main)

import Board.Model exposing (Model, Msg(..), init)
import Board.Update exposing (update)
import Board.View exposing (view)
import Browser
import Html.Styled as Html exposing (..)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view >> toUnstyled
        , update = update
        , subscriptions = \_ -> Sub.none
        }
