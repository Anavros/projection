
import WebGL
import Html exposing (Html)

import Types exposing (..)
import Graphics


{- Main -}
main : Page
main = WebGL.toHtmlWith
    [ WebGL.clearColor 0.0 0.0 0.0 1.0 ]
    []
    [Graphics.testEntity]
