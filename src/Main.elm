module Main exposing (main)


import Board.Update
import Browser
import Browser.Navigation

import Model exposing (Model, Msg(..), initialModel)
import Url

import Browser
import View exposing (view)


type alias Flags = ()




init : flags -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ _ _ = (initialModel, Cmd.none)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of

        BoardMsg msg_ ->
            let
                (subModel, subMessage) = Board.Update.update msg_ model.board
            in
                ({model| board = subModel}, Cmd.map BoardMsg subMessage)

        Ignore -> (model, Cmd.none)


onUrlChange : Url.Url -> Msg
onUrlChange = always Ignore

onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest = always Ignore

subscriptions : Model -> Sub Msg
subscriptions = always Sub.none

main : Program () Model Msg
main =
    Browser.application
    { init = init
    , onUrlChange = onUrlChange
    , onUrlRequest = onUrlRequest
    , subscriptions = subscriptions
    , update = update
    , view = view
    }