-- IMPORTS
import XMonad
import Data.Monoid
import System.Exit

import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.Loggers

import XMonad.Layout.Spacing

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

main = do
  xmproc <- spawnPipe "xmobar ~/.config/xmonad/xmobar/.xmobarrc"
  xmonad $ docks
         $ ewmh
         $ defaults {
         logHook = dynamicLogWithPP xmobarPP {
                  ppCurrent = xmobarColor bg "" . wrap "[" "]"
                , ppHidden  = xmobarColor bgTint "" . wrap " " ""
                , ppUrgent  = xmobarColor red "" . wrap " " ""
                , ppTitle   = (\str -> "")
                , ppLayout  = (\str -> "")
                , ppOutput  = hPutStrLn xmproc
         }
      }

-- VARIABLES
myModMask       = mod4Mask
myTerminal      = "kitty"
myFileManager   = "pcmanfm"
myBrowser       = "firefox"
myLauncher      = "rofi -show run"
myScreenshot    = "maim"
myWorkspaces    = map show [1..9]

-- THEME
base00 = "#0F1419"
base01 = "#131721"
base02 = "#272D38"
base03 = "#3E4B59"
base04 = "#BFBDB6"
base05 = "#E6E1CF"
base06 = "#E6E1CF"
base07 = "#F3F4F5"
base08 = "#F07178"
base09 = "#FF8F40"
base0A = "#FFB454"
base0B = "#B8CC52"
base0C = "#95E6CB"
base0D = "#59C2FF"
base0E = "#D2A6FF"
base0F = "#E6B673"

-- COLORS
bg = base00
bgTint = base01
fg = base05
fgShade = base04
fgTint = base07
red = base08
darkOrange = base09
lightOrange = base0A
green = base0B
cyan = base0C
blue = base0D
violet = base0E
yellow = base0F

myNormalBorderColor  = base02
myFocusedBorderColor = base04

-- WINDOW RULES
myManageHook = composeAll
    [ className =? "Gimp"           --> doCenterFloat
    , className =? "Godot_Engine"   --> doCenterFloat
    , className =? "Steam"          --> doCenterFloat
    , resource  =? "desktop_window" --> doIgnore 
    , isFullscreen                                --> (doF W.focusDown <+> doFullFloat)
    -- , isFullscreen                             --> doFullFloat
    ]

-- LAYOUTS
myBorderWidth   = 2
myGap           = 4

myLayoutHook = avoidStruts (spacingRaw False (Border 0 myGap myGap myGap) True (Border 8 myGap myGap myGap) True
             $ tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- STARTUP
myStartupHook = do
  setWMName "LG3D"

-- KEYBINDS
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- launch rofi
    , ((modm,               xK_d     ), spawn myLauncher)

    -- launch a file manager
    , ((modm,               xK_f     ), spawn myFileManager)

    -- launch a browser
    , ((modm .|. shiftMask, xK_Return), spawn myBrowser)

    -- close focused window
    , ((modm,               xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp)

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster)

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_m     ), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown)

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp)

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- End session
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayoutHook,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        startupHook        = myStartupHook
    }
