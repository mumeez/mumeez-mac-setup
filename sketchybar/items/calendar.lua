local settings = require("settings")
local colors = require("colors")

-- Padding item
sbar.add("item", { position = "right", width = 3 }) -- Reduced padding

local cal = sbar.add("item", "widgets.calendar", {
  position = "right",
  icon = { drawing = false },
  label = {
    color = 0xff37F499,
    padding_left = 5,   -- Reduced padding
    padding_right = 5,  -- Reduced padding
    font = { 
      family = "SF Pro", 
      style = "Bold",
      size = 16.0 
    },
    align = "right",
  },
  update_freq = 30,
  background = {
    color = colors.bg1,
    border_color = colors.black,
    border_width = 1,
    height = 26,
  },
  click_script = "open -a 'Calendar'"
})

-- Common bracket
sbar.add("bracket", "widgets.calendar.bracket", { cal.name }, {
  background = { color = colors.bg1 }
})

-- Padding item
sbar.add("item", { position = "right", width = 3 }) -- Reduced padding

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
  local time = os.date("%I:%M %p"):gsub("^0", "")
  cal:set({ label = { string = time } })
end)
