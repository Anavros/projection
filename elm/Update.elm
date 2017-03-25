
module Update exposing (..)

import WebGL
import Keyboard
import Math.Matrix4 as M4 exposing (Mat4)
import Math.Vector3 as V3 exposing (Vec3)
import AnimationFrame

import Types exposing (..)


dispatch : Message -> Model -> (Model, Cmd Message)
dispatch msg model = case msg of
    Key bool code -> case code of
        37 ->
            ({model|dx = if bool then model.dx - 1 else model.dx + 1}, Cmd.none)
        38 ->
            ({model|dy = if bool then model.dx - 1 else model.dy + 1}, Cmd.none)
        39 ->
            ({model|dx = if bool then model.dx + 1 else model.dx - 1}, Cmd.none)
        40 ->
            ({model|dy = if bool then model.dx + 1 else model.dy - 1}, Cmd.none)
        _ ->
            (model, Cmd.none)
    Animate dt ->
        ({model|uniforms = (step model.uniforms model.dx model.dy)}, Cmd.none)


subscriptions : Model -> Sub Message
subscriptions _ =
    Sub.batch
        [ Keyboard.ups (Key False)
        , Keyboard.downs (Key True)
        , AnimationFrame.diffs Animate
        ]


step : Uniforms -> Int -> Int -> Uniforms
step uniforms dx dy =
    {uniforms|mdel = M4.rotate 1 (V3.vec3 (toFloat dx) (toFloat dy) 0.5) uniforms.mdel}
