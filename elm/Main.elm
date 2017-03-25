
import WebGL
import Html exposing (Html)

import Types exposing (..)
import Graphics


{- Main -}
main : Page
main = WebGL.toHtml [] [Graphics.testEntity]
