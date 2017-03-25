
module Types exposing (..)

import Html exposing (Html)
import Math.Matrix4 as M4 exposing (Mat4)
import Math.Vector3 as V3 exposing (Vec3)


type Message
    = Pass

type alias Page =
    Html Message

type alias Attributes =
    { lon : Float
    , lat : Float
    }

type alias Uniforms =
    { color : Vec3
    , proj : Mat4
    , view : Mat4
    , mdel : Mat4
    }

type alias Varyings =
    { }


