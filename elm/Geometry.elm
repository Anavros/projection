
module Geometry exposing (..)

import WebGL
import Types exposing (..)


uvsphere : Int -> WebGL.Mesh Attributes
uvsphere n = WebGL.indexedTriangles
    ( (lats n) |> List.map (buildRow (lons n)) |> List.concat |> List.unzip |> toAttrs )
    ( indices n )

buildRow : List Float -> Float -> List (Float, Float)
buildRow lons lat =
    List.map (\lon -> (lon, lat)) lons

toAttrs : (List Float, List Float) -> List Attributes
toAttrs (lons, lats) = 
    List.map2 (\lon lat -> Attributes lon lat) lons lats


pi : Float
pi = 3.14

lons : Int -> List Float
lons n = divide n -pi pi

lats : Int -> List Float
lats n = divide n 0 pi


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
