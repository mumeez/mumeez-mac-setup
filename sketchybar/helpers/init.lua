-- Add the sketchybar module to the package cpath
package.cpath = package.cpath .. ";/Users/" .. os.getenv("USER") .. "/.local/share/sketchybar_lua/?.so"

local home = os.getenv("HOME")
os.execute("(cd " .. home .. "/.config/sketchybar/helpers && make)")
