
module Geometry exposing (..)

import WebGL
import Math.Matrix4 as M4 exposing (Mat4)
import Math.Vector3 as V3 exposing (Vec3)

import Types exposing (..)


proj : Mat4
proj = M4.makePerspective 45.0 1.0 1.0 20.0


view : Mat4
view = M4.translate3 0.0 0.0 -4.0 M4.identity


mdel : Mat4
mdel = M4.identity


mesh : WebGL.Mesh Attributes
mesh = WebGL.points
    [ (Attributes 0 0)
    ]

uvsphere : Int -> WebGL.Mesh Attributes
uvsphere n = WebGL.points []
