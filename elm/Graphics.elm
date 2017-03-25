
module Graphics exposing (..)

import WebGL
import Math.Vector3 as V3 exposing (Vec3)

import Types exposing (..)
import Geometry


vShader : WebGL.Shader Attributes Uniforms Varyings
vShader = [glsl|
    precision highp float;
    attribute float lon;
    attribute float lat;
    uniform mat4 mdel;
    uniform mat4 view;
    uniform mat4 proj;
    
    vec4 spherical(float rad, float lon, float lat) {
        return vec4(rad*sin(lat)*cos(lon), rad*sin(lat)*sin(lon), rad*cos(lat), 1.0);
    }
    
    void main(void) {
        gl_Position = vec4(proj * view * mdel * spherical(1.0, lon, lat));
        gl_PointSize = 100.0;
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

uniforms = Uniforms (V3.vec3 0.5 0.5 0.5) Geometry.proj Geometry.view Geometry.mdel

testEntity = WebGL.entity vShader fShader Geometry.mesh uniforms