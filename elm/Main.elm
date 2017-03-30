
import WebGL
import WebGL.Texture as Texture
import Html exposing (Html)
import Math.Vector3 as V3 exposing (Vec3)

import Types exposing (..)
import Graphics
import Geometry
import Update
import View
import Task


main = Html.program
    { init = init
    , view = (View.body Graphics.vs Graphics.fs)
    , subscriptions = Update.subscriptions
    , update = Update.dispatch
    }


mesh : WebGL.Mesh Attributes
mesh = Geometry.uvsphere 32


texture = Task.attempt TextureUpdate (Texture.load "planet.png")


uniforms : Uniforms
uniforms = Uniforms (V3.vec3 0.4 0.6 0.7) Graphics.proj Graphics.view Graphics.mdel Nothing


init : (Model, Effect)
init = (Model mesh uniforms 0.0 0.0, Cmd.none)
