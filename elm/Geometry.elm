
module Geometry exposing (..)

import WebGL
import Types exposing (..)


pi : Float
pi = 3.14


uvsphere : Int -> WebGL.Mesh Attributes
uvsphere n = WebGL.indexedTriangles
    ( combine (verts n) (texes n) )
    ( indices n )

verts n = grid n (-pi, pi) (0, pi)
texes n = grid n (0, 1) (0, 1)

combine : List (Float, Float) -> List (Float, Float) -> List Attributes
combine verts texes =
    List.map2 (\(lon, lat) (x, y) -> Attributes lon lat x y) verts texes

grid : Int -> (Float, Float) -> (Float, Float) -> List (Float, Float)
-- Create a two-dimensional linear space where x ranges from [xMin, xMax] and
-- y [yMin, yMax], inclusive. Dimensions are actually (n+1, n+1), not (n, n).
-- Example: grid 2 (0, 1) (0, 1) =
--   [ (0.0,0.0), (0.5,0.0), (1.0,0.0)
--   , (0.0,0.5), (0.5,0.5), (1.0,0.5)
--   , (0.0,1.0), (0.5,1.0), (1.0,1.0)
--   ]
grid n (xMin, xMax) (yMin, yMax) =
    let
        xs = divide n xMin xMax
        ys = divide n yMin yMax
    in
        List.concatMap (row xs) ys

row : List Float -> Float -> List (Float, Float)
row xs y =
    List.map (\x -> (x, y)) xs

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


-- These are indices for the triangle rendering method.
-- For some reason, triangle_strip doesn't have an indexed version.
indices : Int -> List (Int, Int, Int)
indices n = evenStep ((n-1)^2 * 2) 0 n

evenStep : Int -> Int -> Int -> List (Int, Int, Int)
evenStep n even odd =
    if n <= 1 then
        [(even, even+1, odd)]
    else
        (even, even+1, odd) :: (oddStep (n-1) (even+1) odd)

oddStep : Int -> Int -> Int -> List (Int, Int, Int)
oddStep n even odd =
    if n <= 1 then
        [(even, odd, odd+1)]
    else
        (even, odd, odd+1) :: (evenStep (n-1) even (odd+1))
