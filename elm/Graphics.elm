
module Graphics exposing (..)

import WebGL
import Math.Vector3 as V3 exposing (Vec3)
import Math.Matrix4 as M4 exposing (Mat4)

import Types exposing (..)


vs : WebGL.Shader Attributes Uniforms Varyings
vs = [glsl|
    precision mediump float;

    attribute float lon;
    attribute float lat;
    attribute float x;
    attribute float y;
    uniform mat4 mdel;
    uniform mat4 view;
    uniform mat4 proj;

    varying vec2 tex;

    vec4 spherical(float rad, float lon, float lat) {
        return vec4(rad*sin(lat)*cos(lon), rad*sin(lat)*sin(lon), rad*cos(lat), 1.0);
    }
    
    void main(void) {
        gl_Position = vec4(proj * view * mdel * spherical(1.0, lon, lat));
        gl_PointSize = 5.0;
        tex = vec2(x, y);
    }
|]

fs : WebGL.Shader {} Uniforms Varyings
fs = [glsl|
    precision mediump float;

    uniform sampler2D texture;
    varying vec2 tex;

    void main(void) {
        gl_FragColor = texture2D(texture, tex);
    }
|]


proj : Mat4
proj = M4.makePerspective 45.0 1.0 1.0 20.0


view : Mat4
view = M4.identity
    |> M4.translate3 0.0 0.0 -3.0 
    |> M4.rotate 1.57 (V3.vec3 1.0 0.0 0.0)


mdel : Mat4
mdel = M4.identity
