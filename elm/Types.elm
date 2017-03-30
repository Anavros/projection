
module Types exposing (..)

import Html exposing (Html)
import Time exposing (Time)
import Math.Matrix4 as M4 exposing (Mat4)
import Math.Vector3 as V3 exposing (Vec3)
import Math.Vector2 as V2 exposing (Vec2)
import Keyboard
import WebGL
import WebGL.Texture as Texture


type Message
    = Animate Time
    | CreateModel (WebGL.Texture -> Model) (Result Texture.Error WebGL.Texture)

type alias Page =
    Html Message

type alias Effect =
    Cmd Message

type alias Model =
    { mesh     : WebGL.Mesh Attributes
    , uniforms : Uniforms
    }

type alias Attributes =
    { lon : Float
    , lat : Float
    , x : Float
    , y : Float
    }

type alias Uniforms =
    { proj : Mat4
    , view : Mat4
    , mdel : Mat4
    , texture : WebGL.Texture
    }

type alias Varyings =
    { tex : Vec2
    }
