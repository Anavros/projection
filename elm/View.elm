
module View exposing (..)

import Html
import Html.Events as Events
import WebGL

import Types exposing (..)

break : Page
break = Html.br [] []

body : WebGL.Shader Attributes Uniforms Varyings -> WebGL.Shader {} Uniforms Varyings -> Model -> Page
body vs fs model =
    Html.div []
        [ canvas (WebGL.entity vs fs model.mesh model.uniforms)
        , break
        , Html.text ("DX: " ++ (toString model.dx))
        , break
        , Html.text ("DY: " ++ (toString model.dy))
        ]

canvas : WebGL.Entity -> Page
canvas planet = WebGL.toHtmlWith
    [ WebGL.clearColor 0.0 0.0 0.0 1.0 ]
    []
    [planet]
