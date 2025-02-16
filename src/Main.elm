module Main exposing (..)

import Browser
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


type Faction
    = IronSamurai
    | TheSyndicate
    | NeonUnderground
    | Slummers


factions : List Faction
factions =
    [ IronSamurai
    , TheSyndicate
    , NeonUnderground
    , Slummers
    ]


type ActionType
    = Challenge
    | Opposed


type Domain
    = Kinetic
    | Hacking
    | Stealth


type alias Model =
    { faction : Maybe Faction
    }


type alias Ability =
    { name : String
    , type_ : ActionType
    , domain : Domain
    , difference : String
    , effect : String
    }


type alias Unit =
    { name : String
    , personalHonour : Int
    , move : Int
    , kinetic : Int
    , stealth : Int
    , hacking : Int
    , ability : List String
    , equipment : List String
    }


init : Model
init =
    { faction = Nothing }


type Msg
    = SelectFaction Faction


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectFaction faction ->
            { model | faction = Just faction }


view : Model -> Html Msg
view model =
    layout []
        (viewPageColumn
            model
        )


viewPageColumn : Model -> Element Msg
viewPageColumn model =
    column
        [ width fill
        , height fill
        ]
        [ viewHeader
        , viewFactionList
        , viewUnits model
        , viewCrew
        ]


viewHeader : Element Msg
viewHeader =
    row
        [ width fill
        , padding 10
        ]
        [ el [ centerX ] (text "Crew Builder") ]


viewFactionList : Element Msg
viewFactionList =
    el
        [ paddingXY 0 20
        , centerX
        ]
        (wrappedRow
            [ width fill
            , padding 10
            , spacing 20
            ]
            (List.map viewFaction factions)
        )


viewUnits : Model -> Element msg
viewUnits model =
    row
        [ paddingXY 40 20
        , spacing 10
        , width fill
        , clipX
        , scrollbarX
        ]
    <|
        case model.faction of
            Nothing ->
                []

            Just faction ->
                List.map viewUnit (factionToUnits faction)


viewUnit : Unit -> Element msg
viewUnit unit =
    el
        [ Border.width 1
        , padding 10
        , width (px 250)
        , Border.rounded 4
        ]
        (column []
            [ paragraph [] [ text unit.name ]
            , text (String.fromInt unit.personalHonour)
            , text (String.fromInt unit.move)
            , text (String.fromInt unit.kinetic)
            , text (String.fromInt unit.stealth)
            , text (String.fromInt unit.hacking)
            ]
        )


viewCrew : Element msg
viewCrew =
    row [ paddingXY 40 20 ] [ text "Crew" ]


factionToString : Faction -> String
factionToString faction =
    case faction of
        IronSamurai ->
            "Iron Samurai"

        TheSyndicate ->
            "The Syndicate"

        NeonUnderground ->
            "Neon Underground"

        Slummers ->
            "Slummers"


factionToUnits : Faction -> List Unit
factionToUnits faction =
    case faction of
        IronSamurai ->
            [ { name = "Iron Samurai Soldier", personalHonour = 0, move = 0, kinetic = 0, stealth = 0, hacking = 0, ability = [], equipment = [] }
            , { name = "Iron Samurai Duelist", personalHonour = 0, move = 0, kinetic = 0, stealth = 0, hacking = 0, ability = [], equipment = [] }
            , { name = "Iron Samurai Flesh-smith", personalHonour = 0, move = 0, kinetic = 0, stealth = 0, hacking = 0, ability = [], equipment = [] }
            , { name = "S.U.M.O", personalHonour = 0, move = 0, kinetic = 0, stealth = 0, hacking = 0, ability = [], equipment = [] }
            ]

        TheSyndicate ->
            [ { name = "Accountant", personalHonour = 0, move = 0, kinetic = 0, stealth = 0, hacking = 0, ability = [], equipment = [] }
            , { name = "Lawyer", personalHonour = 0, move = 0, kinetic = 0, stealth = 0, hacking = 0, ability = [], equipment = [] }
            ]

        NeonUnderground ->
            []

        Slummers ->
            []


viewFaction : Faction -> Element Msg
viewFaction faction =
    Input.button
        [ Border.width 1
        , padding 10
        , width (px 100)
        , height (px 50)
        , Font.center
        , Border.rounded 4
        ]
        { onPress = Just (SelectFaction faction)
        , label =
            paragraph
                [ Font.size 12
                , Font.center
                ]
                [ text (factionToString faction) ]
        }
