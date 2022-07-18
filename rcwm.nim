# rcwm is a light, fast and easy to use window manager
#     ___  _____
#    / _ \/ ___/     ____ _
#   / , _/ /__ | |/|/ /  ' \
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

proc getRam*(): string =
  let
     fileSeq: seq[string] = readLines("/proc/meminfo", 3)

   let
     memTotalSeq: seq[string] = fileSeq[0].split(" ")
     memAvailableSeq: seq[string] = fileSeq[2].split(" ")

     memTotalInt: int = parseInt(memTotalSeq[^2]) div 1024
     memAvailableInt: int = parseInt(memAvailableSeq[^2]) div 1024

     memUsedInt: int = memTotalInt - memAvailableInt

   result = $(memUsedInt) & " | " & $(memTotalInt) & " MiB"
