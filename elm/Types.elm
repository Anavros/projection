
module Types exposing (..)

import Html exposing (Html)
import Time exposing (Time)
import Math.Matrix4 as M4 exposing (Mat4)
import Math.Vector3 as V3 exposing (Vec3)
import Keyboard
import WebGL


type Message
    = Key Bool Keyboard.KeyCode
    | Animate Time

type alias Page =
    Html Message

type alias Effect =
    Cmd Message

type alias Model =
    { mesh     : WebGL.Mesh Attributes
    , uniforms : Uniforms
    , dx : Float
    , dy : Float
    }

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
