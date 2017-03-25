
module Graphics exposing (..)

import WebGL
import Types exposing (..)
import Math.Vector3 as V3 exposing (Vec3)

vShader : WebGL.Shader Attributes Uniforms Varyings
vShader = [glsl|
    attribute vec3 pos;
    void main(void) {
        gl_Position = vec4(pos, 1.0);
    }
|]

fShader : WebGL.Shader {} Uniforms Varyings
fShader = [glsl|
    precision highp float;
    uniform vec3 color;
    void main(void) {
        gl_FragColor = vec4(color, 1.0);
    }
|]

mesh : WebGL.Mesh Attributes
mesh = WebGL.triangles
    [ ( (Attributes (V3.vec3  1.0  1.0 0.0))
      , (Attributes (V3.vec3 -1.0 -1.0 0.0))
      , (Attributes (V3.vec3  1.0 -1.0 0.0))
      )
    ]

uniforms = Uniforms (V3.vec3 0.0 0.0 0.0)

testEntity = WebGL.entity vShader fShader mesh uniforms
