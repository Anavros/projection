
import WebGL
import Html exposing (Html)
import Math.Vector3 as V3 exposing (Vec3)

import Types exposing (..)
import Graphics
import Geometry
import Update
import View


main = Html.program
    { init = init
    , view = (View.body Graphics.vs Graphics.fs)
    , subscriptions = Update.subscriptions
    , update = Update.dispatch
    }


mesh : WebGL.Mesh Attributes
mesh = Geometry.uvsphere 32


uniforms : Uniforms
uniforms = Uniforms (V3.vec3 0.5 0.5 0.5) Geometry.proj Geometry.view Geometry.mdel


init : (Model, Effect)
init = (Model mesh uniforms 0 0, Cmd.none)
