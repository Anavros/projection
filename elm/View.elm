
module View exposing (..)

import Html
import Html.Events as Events
import Html.Attributes as Attr
import WebGL
import Style

import Types exposing (..)


break : Page
break = Html.br [] []


body : WebGL.Shader Attributes Uniforms Varyings -> WebGL.Shader {} Uniforms Varyings -> Maybe Model -> Page
body vs fs model = case model of
    Just {mesh, uniforms} -> Html.div
        [Style.container]
        [ canvas (WebGL.entity vs fs mesh uniforms)
        , pauseButton
        ]
    Nothing -> Html.div
        [Style.container]
        [Html.text "Loading..."]


canvas : WebGL.Entity -> Page
canvas planet = WebGL.toHtmlWith
    [ WebGL.clearColor 0.0 0.0 0.0 1.0
    , WebGL.depth 1
    , WebGL.antialias
    ]
    [ Style.canvas
    , Attr.width 500
    , Attr.height 500
    ]
    [planet]


pauseButton : Page
pauseButton = Html.button
    [ Events.onClick TogglePause ]
    [ Html.text "Pause" ]
