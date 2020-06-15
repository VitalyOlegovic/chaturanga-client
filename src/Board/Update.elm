module Board.Update exposing (..)

import Board.Model exposing (..)
import Game
import Move exposing (Move)
import Position
import Square exposing (Square)



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SquarePressed sq ->
            squarePressed sq model

        DoMove move ->
            ( { model
                | game = Game.addMove move model.game
                , selectedSquare = Nothing
                , candidateMoves = []
              }
            , Cmd.none
            )

        RotateBoard ->
            ( { model | boardIsRotated = not model.boardIsRotated }
            , Cmd.none
            )

        Back ->
            ( { model | game = Game.back model.game }
            , Cmd.none
            )

        Forward ->
            ( { model | game = Game.forward model.game }
            , Cmd.none
            )


squarePressed : Square -> Model -> ( Model, Cmd Msg )
squarePressed s model =
    let
        moves =
            List.filter (\m -> Move.to m == s) model.candidateMoves
    in
        case List.head moves of
            Just m ->
                update (DoMove m) model

            Nothing ->
                let
                    newMoves =
                        Game.position model.game |> Position.movesFrom s
                in
                    ( { model
                        | candidateMoves = newMoves
                        , selectedSquare =
                            if List.length newMoves == 0 then
                                Nothing
                            else
                                Just s
                      }
                    , Cmd.none
                    )
