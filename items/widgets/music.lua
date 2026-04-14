-- ~/.config/sketchybar/items/widgets/music.lua
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- --- tuning ---------------------------------------------------------------
local COVER_SIZE = 26
local COVER_SCALE = 0.04
local COVER_RADIUS = 5
local SHOW_ON_RIGHT = false
local POLL_SECONDS = 2.0
local STARTUP_DELAY = 0.5 

local function side()
	return SHOW_ON_RIGHT and "right" or "left"
end

-- temp artwork file
local ART_PATH = "/tmp/sketchybar_music_art.jpg"

-- --- items ---------------------------------------------------------------
-- For LEFT position: order of creation is order of appearance (left to right)
-- [Cover] [Title/Artist] [Prev] [PP] [Next]

local cover = sbar.add("item", "widgets.music.cover", {
	position = side(),
	background = {
		image = { string = ART_PATH, scale = COVER_SCALE, corner_radius = COVER_RADIUS },
		color = colors.transparent,
		height = COVER_SIZE,
	},
	icon = { 
		string = "􀑪", 
		font = { size = 14.0 },
		color = colors.grey,
		padding_left = 10,
		padding_right = 10,
	},
	label = { drawing = false },
	padding_left = 0,
	padding_right = 6,
	updates = true,
})

local MAX_CHARS = 26

local artist = sbar.add("item", "widgets.music.artist", {
	position = side(),
	width = 0, -- overlay
	padding_left = -5,
	padding_right = 0,
	y_offset = -6, 
	icon = { drawing = false },
	label = {
		max_chars = MAX_CHARS,
		align = "left",
		font = { family = settings.font.numbers, style = settings.font.style_map["Bold"], size = 10 },
		color = 0xffF3A34A,
	},
})

local title = sbar.add("item", "widgets.music.title", {
	position = side(),
	padding_left = -5,
	padding_right = 12, -- More space after text
	y_offset = 6, 
	icon = { drawing = false },
	label = {
		max_chars = MAX_CHARS,
		align = "left",
		font = { family = settings.font.numbers, style = settings.font.style_map["Bold"], size = 11 },
		color = 0xff37F499,
	},
})

local btn_prev = sbar.add("item", "widgets.music.prev", {
	position = side(),
	icon = { string = icons.media.back, font = { size = 12.0 } },
	label = { drawing = false },
	padding_left = 4,
	padding_right = 4,
})

local btn_pp = sbar.add("item", "widgets.music.pp", {
	position = side(),
	icon = { string = icons.media.play_pause, font = { size = 12.0 } },
	label = { drawing = false },
	padding_left = 4,
	padding_right = 4,
})

local btn_next = sbar.add("item", "widgets.music.next", {
	position = side(),
	icon = { string = icons.media.forward, font = { size = 12.0 } },
	label = { drawing = false },
	padding_left = 4,
	padding_right = 8,
})

-- Chip bracket
sbar.add(
	"bracket",
	"widgets.music.bracket",
	{ btn_prev.name, btn_pp.name, btn_next.name, artist.name, title.name, cover.name },
	{ background = { color = colors.bg1, border_color = colors.black, border_width = 1, height = 26 } }
)

-- Spacing after widget
sbar.add("item", "widgets.music.padding", {
	position = side(),
	width = settings.group_paddings,
})

-- --- actions ---
btn_prev:subscribe("mouse.clicked", function() sbar.exec("nowplaying-cli previous") end)
btn_pp:subscribe("mouse.clicked", function() sbar.exec("nowplaying-cli togglePlayPause") end)
btn_next:subscribe("mouse.clicked", function() sbar.exec("nowplaying-cli next") end)

local current_app = "Music"
for _, it in ipairs({ cover, title, artist }) do
	it:subscribe("mouse.clicked", function()
		if current_app and current_app ~= "" then
			sbar.exec([[open -a "]] .. current_app .. [["]])
		else
			sbar.exec([[open -a "Music"]])
		end
	end)
end

local APPLESCRIPT_ART = ([[
if application "Music" is running then
  tell application "Music"
    try
      if (player state as string) is "stopped" then return ""
      if (count of artworks of current track) is 0 then return ""
      set outFile to POSIX file "%s"
      set d to data of artwork 1 of current track
      try
        set fh to open for access outFile with write permission
        set eof of fh to 0
        write d to fh
        close access fh
      on error
        try
          close access outFile
        end try
        return ""
      end try
      return "ok"
    on error
      return ""
    end try
  end tell
end if
return ""
]]):format(ART_PATH)

local function ensure_visible()
	cover:set({ drawing = "on" })
	btn_prev:set({ drawing = "on" })
	btn_pp:set({ drawing = "on" })
	btn_next:set({ drawing = "on" })
	title:set({ drawing = "on" })
	artist:set({ drawing = "on" })
end

local function show_placeholder()
	ensure_visible()
	title:set({ label = { string = "—" } })
	artist:set({ label = { string = "" } })
	cover:set({ icon = { drawing = true }, background = { image = { string = "" } } })
end

local function refresh_once()
	sbar.exec("nowplaying-cli get title artist playerState bundleIdentifier", function(out)
		if not out or out == "" then show_placeholder() return end

		local lines = {}
		for line in string.gmatch(out, "[^\r\n]+") do lines[#lines + 1] = line end
		
		local t, ar, st, bid = lines[1] or "", lines[2] or "", lines[3] or "stopped", lines[4] or ""
		
		if bid:find("com.apple.Music") then current_app = "Music"
		elseif bid:find("com.spotify.client") then current_app = "Spotify"
		elseif bid:find("com.google.Chrome") then current_app = "Google Chrome"
		elseif bid:find("com.apple.Safari") then current_app = "Safari"
		else current_app = nil end

		title:set({ label = { string = (t ~= "null" and t ~= "" and t or "—") } })
		artist:set({ label = { string = (ar ~= "null" and ar ~= "" and ar or "") } })

		if current_app == "Music" then
			sbar.exec("/usr/bin/osascript -e '" .. APPLESCRIPT_ART:gsub("'", [["]]) .. "'", function(ok)
				if ok and ok:match("ok") then
					cover:set({ icon = { drawing = false }, background = { image = { string = ART_PATH, scale = COVER_SCALE, corner_radius = COVER_RADIUS } } })
				else
					cover:set({ icon = { drawing = true }, background = { image = { string = "" } } })
				end
			end)
		else
			cover:set({ icon = { drawing = true }, background = { image = { string = "" } } })
		end
		ensure_visible()
	end)
end

local function loop() refresh_once() sbar.delay(POLL_SECONDS, loop) end
sbar.delay(STARTUP_DELAY, loop)
cover:subscribe("system_woke", refresh_once)
