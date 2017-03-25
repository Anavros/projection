
module Types exposing (..)

import Html exposing (Html)
import Math.Vector3 as V3 exposing (Vec3)


type Message
    = Pass

type alias Page =
    Html Message

type alias Attributes =
    { pos : Vec3
    }

type alias Uniforms =
    { color : Vec3
    }

type alias Varyings =
    { }


