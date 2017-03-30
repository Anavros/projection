
module View exposing (..)

import Html
import Html.Events as Events
import Html.Attributes as Attr
import WebGL

import Types exposing (..)

break : Page
break = Html.br [] []

body : WebGL.Shader Attributes Uniforms Varyings -> WebGL.Shader {} Uniforms Varyings -> Maybe Model -> Page
body vs fs model = case model of
    Just {mesh, uniforms} ->
        canvas (WebGL.entity vs fs mesh uniforms)
    Nothing ->
        Html.div [] [Html.text "Not yet loaded!"]

canvas : WebGL.Entity -> Page
canvas planet = WebGL.toHtmlWith
    [ WebGL.clearColor 0.0 0.0 0.0 1.0 ]
    [ Attr.style [ ]
    , Attr.width 500
    , Attr.height 500
    ]
    [planet]
