# rcwm is a light, fast and easy to use window manager
#     ___  _____
#    / _ \/ ___/    ____ _
#   / , _/ /__| |/|/ /  ' \
#  /_/|_|\___/|__,__/_/_/_/

import
  std/[options, os, sequtils, strutils, parsecfg],
  x11/[xlib, x, xft, xatom, xinerama, xrender],
  types,
  atoms,
  log,
  pixie,
  regex

converter toXBool*(x: bool): XBool = x.XBool
converter toBool*(x: XBool): bool = x.bool

proc getResolution*(): string =
  let
    Resulution: Config = loadConfig("xrandr -d :0")

  result = Resulution.getSectionValue("", "current")

proc getDistroId*(): string =
  let
    osRelease: Config = loadConfig("/etc/os-release")

  result = osRelease.getSectionValue("", "ID")
