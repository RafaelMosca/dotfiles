import XMonad

main = do
  xmonad $ defaultConfig
         { modMask             = mod4Mask
         , focusFollowsMouse   = False
         , borderWidth         = 2
         , normalBorderColor   = "#DDDDDD"
         , focusedBorderColor  = "#1E90FF"
         }
