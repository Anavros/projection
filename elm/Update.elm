
module Update exposing (..)

import WebGL
import WebGL.Texture
import Keyboard
import Math.Matrix4 as M4 exposing (Mat4)
import Math.Vector3 as V3 exposing (Vec3)
import AnimationFrame

import Types exposing (..)


dispatch : Message -> Maybe Model -> (Maybe Model, Cmd Message)
dispatch msg model = case msg of
    Animate dt -> case model of
        Just model ->
            (Just {model|uniforms = (step model.uniforms)}, Cmd.none)
        Nothing ->
            (model, Cmd.none)
    CreateModel planet result -> case result of
        Ok texture ->
            (Just (planet texture), Cmd.none)
        Err _ ->
            (model, Cmd.none)


subscriptions : Maybe Model -> Sub Message
subscriptions _ =
    AnimationFrame.diffs Animate


step : Uniforms -> Uniforms
step uniforms =
    {uniforms|mdel = M4.rotate -0.01 (V3.vec3 0.0 0.0 1.0) uniforms.mdel}
