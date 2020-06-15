module Board.View exposing (..)

import Board.Model exposing (Model, Msg(..), init)
import Board.Update exposing (update)
import Browser
import Css
import Game exposing (Game)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (class, css)
import Html.Styled.Events exposing (onClick)
import Notation
import Piece exposing (Piece)
import PieceColor
import PieceType
import Position exposing (Position)
import Square exposing (Square)
import SquareFile as File
import SquareRank as Rank



view : Model -> Html Msg
view model =
    div
        []
        [ board (Game.position model.game) 600.0 model.boardIsRotated
        , div
            []
            [ button [ onClick RotateBoard ] [ text "Rotate" ]
            , button [ onClick Back ] [ text "Back" ]
            , button [ onClick Forward ] [ text "Forward" ]
            ]
        , div [] [ text "Prova"
            , input [] []
        , div [] [ text <| Maybe.withDefault "" <| Maybe.map Square.toString model.selectedSquare  ]
        , div [] [
            List.map Notation.toUci model.candidateMoves
            |> Debug.toString
            |> text
        ]
        ]
        ]


board : Position -> Float -> Bool -> Html Msg
board position size isRotated =
    Html.div
        [ css
            [ Css.width (Css.px size)
            , Css.height (Css.px size)
            , Css.position Css.relative
            , Css.marginLeft Css.auto
            , Css.marginRight Css.auto
            ]
        ]
        (List.map
            (\s ->
                square
                    (squareToCoordinates s isRotated)
                    (Position.pieceOn s position)
                    (size / 8)
                    (SquarePressed s)
            )
            Square.all
        )


square : ( Int, Int ) -> Maybe Piece -> Float -> Msg -> Html Msg
square ( col, row ) piece sqSize msg =
    Html.div
        [ css
            [ Css.backgroundColor
                (if modBy 2 (col + row) == 0 then
                    Css.rgb 200 200 200
                 else
                    Css.rgb 140 140 140
                )
            , Css.position Css.absolute
            , Css.top (Css.px (toFloat row * sqSize))
            , Css.left (Css.px (toFloat col * sqSize))
            , Css.width (Css.px sqSize)
            , Css.height (Css.px sqSize)
            ]
        , onClick msg
        ]
        [ case piece of
            Nothing ->
                text ""

            Just piece_ ->
                div
                    [ css
                        [ Css.position Css.absolute
                        , Css.width (Css.px sqSize)
                        , Css.height (Css.px sqSize)
                        , Css.backgroundImage (Css.url (pieceImgUrl piece_))
                        , Css.backgroundSize2 (Css.px sqSize) (Css.px sqSize)
                        ]
                    ]
                    []
        ]


squareToCoordinates : Square -> Bool -> ( Int, Int )
squareToCoordinates square_ isRotated =
    ( if isRotated then
        7 - (square_ |> Square.file |> File.toIndex)
      else
        square_ |> Square.file |> File.toIndex
    , if isRotated then
        square_ |> Square.rank |> Rank.toIndex
      else
        7 - (square_ |> Square.rank |> Rank.toIndex)
    )


pieceImgUrl : Piece -> String
pieceImgUrl piece =
    imgUrlPrefix
        ++ (piece |> Piece.color |> PieceColor.toString)
        ++ (piece |> Piece.kind |> PieceType.toString |> String.toLower)
        ++ ".png"


imgUrlPrefix : String
imgUrlPrefix =
    "http://res.cloudinary.com/ds1kquy7j/image/upload/"
