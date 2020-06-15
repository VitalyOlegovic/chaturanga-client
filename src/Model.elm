module Model exposing (..)

import Board.Model as BM

type Msg
    = BoardMsg BM.Msg
    | Ignore


type alias Model =
    { moveFrom : String
    , moveTo : String
    , board: BM.Model}

initialModel = Model "" "" BM.initialModel