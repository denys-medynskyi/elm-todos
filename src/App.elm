module App exposing (..)

import Html exposing (Html, text, div, img, input, form)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Debug


type alias Todo = { name:String }
type alias Model = { todos : List Todo, newTodo : String }


init : String -> ( Model, Cmd Msg )
init path =
    ( { todos = [ { name = "Finish up" }  ], newTodo = "" }, Cmd.none )


-- UPDATE

type Msg
  = Change String | AddTodo

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Change newContent ->
      ( { model | newTodo = newContent }, Cmd.none )
    AddTodo ->
      ( { model | todos = [] }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
    [
        div []
            [
               Html.form []
               [
                    input [ type_ "text", placeholder "New Todo", onInput Change] [],
                    input [ type_ "submit", value "Add", onSubmit AddTodo, onWithOptions "submit" { stopPropagation = True, preventDefault = True }  (Json.succeed AddTodo) ] []
               ]
            ],
        div []
            ( List.map todoDiv model.todos )
    ]

todoDiv : Todo -> Html Msg
todoDiv todo =
    div []
        [ text todo.name ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
