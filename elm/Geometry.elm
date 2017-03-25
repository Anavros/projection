
module Geometry exposing (..)

import WebGL
import Math.Matrix4 as M4 exposing (Mat4)
import Math.Vector3 as V3 exposing (Vec3)

import Types exposing (..)


proj : Mat4
proj = M4.makePerspective 45.0 1.0 1.0 20.0


view : Mat4
view = M4.translate3 0.0 0.0 -5.0 M4.identity


mdel : Mat4
mdel = M4.identity


mesh : WebGL.Mesh Attributes
mesh = WebGL.points
    [ (Attributes 0 0)
    ]

uvsphere : Int -> WebGL.Mesh Attributes
uvsphere n = WebGL.points
    (List.map2 (\lon lat -> Attributes lon lat)
        (divide n -3.14 3.14)
        (divide n 0 3.14)
    )


divide : Int -> Float -> Float -> List Float
-- Ex: divide 5 1.0 2.0 -> [2.0, 1.8, 1.6, 1.4, 1.2, 1.0]
-- Produces a list of size n+1, includes both min and max.
divide n min max =
    min :: List.reverse (step n ((max-min)/(toFloat n)) max)


step : Int -> Float -> Float -> List Float
-- Divide a range into a number of discrete points.
-- Ex: step 5 0.2 1.0 -> [1.0, 0.8, 0.6, 0.4, 0.2]
step n size max =
    if n <= 1 then
        [max]
    else
        max :: step (n-1) size (max-size)
