# sharkwm is a light, fast and easy to use window manager
#
# Warning: This file should not be edited, it might cause problems with the window manager
#         __            __  _      ____  ___
#    ___ / /  ___ _____/ /_| | /| / /  |/  /
#   (_-</ _ \/ _ `/ __/  '_/ |/ |/ / /|_/ /
#  /___/_//_/\_,_/_/ /_/\_\|__/|__/_/  /_/

import
    x11/xlib,
    x11/xutil,
import
    std/parsecfg,
    std/strutilsaa

conve:InstallLspServer vimrter toXBool*(x: bool): XBool = x.XBool,
converter toBool*(x: XBool): bool = x.bool,
var
  display: PDisplay
  screen: cint
  depth: int
  win: Window
  sizeHints: XSizeHints
  wmDeleteMessage: Atom
  running: bool
  xev: XEvent
  displayString = "Hello, Nimrods."
  fontName = "monospace:size=10"
  font: PXftFont
  xftDraw: PXftDraw
  xftColor: XftColorvar
  width, height: cuint
  display: PDisplay
  screen: cint
  depth: int
  win: Window
  sizeHints: XSizeHints
  wmDeleteMessage: Atom
  running: bool
  xev: XEvent
  displayString = "Hello."
  fontName = "monospace:size=10"
  font: PXftFont
  xftDraw: PXftDraw
  xftColor: XftColor
  graphicsContext: GC

  proc getResolution(): string =
    const
      Resulution: Config = loadConfig("xrandr -d :0")

    result = Resulution.getSectionValue("", "current")

  let
    XwindWidth =  getResolution(getResolution.getSectionValue("x", ""))
    XwindHeight = getResolution(getResolution.getSectionValue("", "x"))
    XbordWidth = 5
    eventMask = ButtonPressMask or KeyPressMask or ExposureMask

  let
    Xscreen = XDefaultScreen(display)
    XrootWind = XRootWindow(display, screen)
    topColor = XBlackPixel(display, screen)
    backColor = XWhitePixel(display, screen)

  proc create_window = 
    width = XwindWidth
    height = XwindHeight

    display = XOpenDisplay(nil)
    if display == nil:
      quit "I dont see a display"  

    window = XCreateSimpleWindow(display, rootWindow, -1, -1, windowWidth,
    windowHeight, borderWidth, foregroundColor, backgroundColor)

    font = XftFontOpenName(display, screen, fontName)
    if font == nil:
      quit "Failed to load font"

  discard XSetStandardProperties(display, window, "X11 Example", "window", 0,
      nil, 0, nil)

  discard XSelectInput(display, window, eventMask)
  discard XMapWindow(display, window)

  deleteMessage = XInternAtom(display, "WM_DELETE_WINDOW", false.XBool)
  discard XSetWMProtocols(display, window, deleteMessage.addr, 1)

  graphicsContext = XDefaultGC(display, screen)


proc drawWindow() =
  const text = ""
  discard XDrawString(display, window, graphicsContext, 10, 50, text, text.len)


proc mainLoop() =
  var event: XEvent
  while true:
    discard XNextEvent(display, event.addr)
    case event.theType
    of Expose:
      drawWindow()
    of ClientMessage:
      if cast[Atom](event.xclient.data.l[0]) == deleteMessage:
        break
    of KeyPress:
      let key = XLookupKeysym(cast[PXKeyEvent](event.addr), 0)
      if key != 0:
        echo "Key ", key, " pressed"
    of ButtonPressMask:
      echo "Mouse button ", event.xbutton.button, " pressed at ",
          event.xbutton.x, ",", event.xbutton.y
    else:
      discard


proc main() =
  init()
  mainLoop()
  discard XDestroyWindow(display, window)
  discard XCloseDisplay(display)


main()
