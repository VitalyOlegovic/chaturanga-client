module View exposing (view)

import Board.View
import Html exposing (Attribute, Html, a, i, img, option, p, small, span, strong, text)
import Html.Attributes exposing (attribute, class, href, id, placeholder, rel, src, style)
import Browser

import Bulma.CDN exposing (..)
import Bulma.Modifiers exposing (..)
import Bulma.Modifiers.Typography exposing (textCentered)
import Bulma.Form exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Components exposing (..)
import Bulma.Columns exposing (..)
import Bulma.Layout exposing (..)

import Html.Events exposing (onInput)
import Html.Styled
import Model exposing (..)

exampleNavbar : Html msg
exampleNavbar
  = navbar navbarModifiers []
    [ navbarBrand []
      ( navbarBurger False []
        [ span [] []
        , span [] []
        , span [] []
        ]
      )
      [ navbarItem False []
        [
        ]
      ]
    , navbarMenu False []
      [ navbarStart []
        [ navbarItemLink False [] [ text "Home"  ]
        , navbarItemDropdown False Down [] ( navbarLink [] [ text "Docs" ] )
          [ navbarDropdown True Left []
            [ navbarItemLink False [] [ text "Crud"     ]
            , navbarItemLink False [] [ text "Detritus" ]
            , navbarItemLink True  [] [ text "Refuse"   ]
            , navbarItemLink False [] [ text "Trash"    ]
            ]
          ]
        ]
      , navbarEnd []
        [ navbarItem False []
          [ fields Left []
            [ controlButton { buttonModifiers | color = Info    } [] [] [ icon Standard [] [ i [ class "fa fa-twitter"  ] [] ], span [] [ text "Tweet"    ] ]
            , controlButton { buttonModifiers | color = Primary } [] [] [ icon Standard [] [ i [ class "fa fa-download" ] [] ], span [] [ text "Download" ] ]
            ]
          ]
        ]
      ]
    ]


demoArticle : String -> List (Html msg) -> Html msg
demoArticle aTitle someHtmls
  = columns columnsModifiers []
    [ column (myColumnModifiers Auto (Just Width2)) []
      [ title H4 [] [ strong [] [ text aTitle ] ]
      ]
    , column (myColumnModifiers Auto (Just Auto)) []
      someHtmls
    ]

exampleElementsAndComponents : model -> Section msg
exampleElementsAndComponents model
  = section NotSpaced []
    [ container []
      [ demoArticle ""
        [ demoSection "" []
          [
            field []
            [ controlLabel [] [ text "Move from" ]
            , controlInput controlInputModifiers [id "move_from"] [ placeholder "Input" ] []
            ]
            ,field [] [ controlLabel [] [ text "Move to" ]
            , controlInput controlInputModifiers [id "move_to"] [ placeholder "Input" ] []
            ]
          ]
        ]
      ]
    ]

myColumnModifiers : Width -> Maybe Width -> ColumnModifiers
myColumnModifiers offset width
  = let widths : Devices (Maybe Width)
        widths = columnModifiers.widths
    in { columnModifiers
         | offset
           = offset
         , widths
           = { widths
               | tablet     = width
               , desktop    = width
               , widescreen = width
               , fullHD     = width
             }
       }

demoSection : String -> List (Attribute msg) -> List (Html msg) -> Html msg
demoSection aSubtitle someAttrs someHtmls
  = columns columnsModifiers someAttrs
    [ column (myColumnModifiers Auto (Just Width3)) []
      [ subtitle H4 [] [ text aSubtitle ]
      ]
    , column (myColumnModifiers Auto (Just Auto)) []
      someHtmls
    ]

exampleFooter : Html msg
exampleFooter
  = footer []
    [ container []
      [ content Standard [ textCentered ]
        [ p []
          [ strong [] [ text "Bulma" ]
          , text " by "
          , a [ href "https://jgthms.com" ] [ text "Jeremy Thomas" ]
          , text ". The source code is licensed "
          , a [ href "http://opensource.org/licenses/mit-license.php" ] [ text "MIT" ]
          , text ". The website content is licensed "
          , a [ href "http://creativecommons.org/licenses/by-nc-sa/4.0" ] [ text "CC BY NC SA 4.0" ]
          , text "."
          ]
        ]
      ]
    ]

fontAwesomeCDN
  = Html.node "link"
    [ rel "stylesheet"
    , href "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
    ]
    []

boardWrapper : Model -> Section Msg
boardWrapper model =
    section NotSpaced [] [
        container [] [
            Board.View.view model.board
            |> Html.Styled.toUnstyled
            |> Html.map BoardMsg

        ]
    ]

view : Model -> Browser.Document Msg
view model = { title = "Chaturanga", body = body model}


body : Model -> List (Html.Html Msg)
body model = [ stylesheet
    , fontAwesomeCDN
    , exampleNavbar
    , boardWrapper model
    --, exampleElementsAndComponents model
    , exampleFooter
    ]

