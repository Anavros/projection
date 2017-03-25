
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
        37 -> ({model|dx = f bool -1.0 model.dx}, Cmd.none)
        38 -> ({model|dy = f bool -1.0 model.dy}, Cmd.none)
        39 -> ({model|dx = f bool  1.0 model.dx}, Cmd.none)
        40 -> ({model|dy = f bool  1.0 model.dy}, Cmd.none)
        _ -> (model, Cmd.none)
    Animate dt ->
        ({model|uniforms = (step model.uniforms model.dx model.dy)}, Cmd.none)


f : Bool -> Float -> Float -> Float
f pressed mod speed =
    if pressed then
        if speed == 0 then
            mod
        else
            speed
    else
        0


subscriptions : Model -> Sub Message
subscriptions _ =
    Sub.batch
        [ Keyboard.ups (Key False)
        , Keyboard.downs (Key True)
        , AnimationFrame.diffs Animate
        ]


step : Uniforms -> Float -> Float -> Uniforms
step uniforms dx dy =
    if dx < 0 then
        {uniforms|mdel = rotL uniforms.mdel}
    else if dx > 0 then
        {uniforms|mdel = rotR uniforms.mdel}
    else if dy < 0 then
        {uniforms|mdel = rotD uniforms.mdel}
    else if dy > 0 then
        {uniforms|mdel = rotU uniforms.mdel}
    else
        uniforms


rotL : Mat4 -> Mat4
rotL mat =
    M4.rotate 0.03 (V3.vec3 0.0 1.0 0.0) mat

rotR : Mat4 -> Mat4
rotR mat =
    M4.rotate -0.03 (V3.vec3 0.0 1.0 0.0) mat

rotU : Mat4 -> Mat4
rotU mat =
    M4.rotate 0.03 (V3.vec3 1.0 0.0 0.0) mat

rotD : Mat4 -> Mat4
rotD mat =
    M4.rotate -0.03 (V3.vec3 1.0 0.0 0.0) mat
