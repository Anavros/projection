
import WebGL
import WebGL.Texture as Texture
import Html exposing (Html)
import Math.Vector3 as V3 exposing (Vec3)

import Types exposing (..)
import Graphics
import Geometry
import Update
import View
import Task exposing (Task)


main = Html.program
    { init = init
    , view = View.body Graphics.vs Graphics.fs
    , subscriptions = Update.subscriptions
    , update = Update.dispatch
    }


planet : WebGL.Texture -> Model
planet texture = Model
    --(Geometry.uvsphere 8)
    --(Geometry.uvsphere 32)
    --(Geometry.uvpoints 8)
    (Geometry.uvpoints 32)
    (Uniforms Graphics.proj Graphics.view Graphics.mdel texture)


init : (Maybe Model, Effect)
init = (Nothing, Task.attempt (CreateModel planet) (Texture.load "planet.png"))
