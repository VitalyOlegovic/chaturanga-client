module Board.Model exposing (..)

import Game exposing (Game)
import Move exposing (Move)
import Square exposing (Square)

type alias Model =
    { game : Game
    , boardIsRotated : Bool
    , selectedSquare : Maybe Square -- Square tapped by the user
    , candidateMoves : List Move -- List of legal moves from selected square
    }

initialModel : Model
initialModel =
    { game = Game.empty
    , boardIsRotated = False
    , selectedSquare = Nothing
    , candidateMoves = []
    }

init : () -> ( Model, Cmd msg )
init _ =
    ( initialModel
    , Cmd.none
    )

type Msg
    = SquarePressed Square
    | DoMove Move
    | RotateBoard
    | Back
    | Forward