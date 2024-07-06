local wezterm = require("wezterm")
local act = wezterm.action
local key_bindings = require("key_bindings")
local color_scheme = require("color_scheme")

local check_count = 0  -- Initialize a counter for environment checks
local log_file = os.getenv("HOME") .. "/wezterm_keybinding_log.txt"
local last_update_time = 0  -- Variable to store the last update time
local update_interval = 1  -- Interval between updates in seconds

-- Function to generate a unique session ID
local function generate_session_id()
  return tostring(os.time()) .. tostring(math.random(100000, 999999))
end

-- Generate and set WEZTERM_SESSION
local session_id = generate_session_id()

-- Logging function to write messages to a file
local function log_message(message)
  local f = io.open(log_file, "a")
  if f then
    f:write(message .. "\n")
    f:close()
  else
    print("Failed to open log file for writing")
  end
end

-- Function to check if file exists
local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

-- Function to check if running inside Tmux
local function isTmux()
  local filename = "/tmp/.wezterm_" .. session_id
  return file_exists(filename)
end

-- Function to update the title and key table based on the environment
local function updateTitleAndKeys(window, pane)
  check_count = check_count + 1  -- Increment the counter
  local title
  if isTmux() then
    title = "Tmux"
    window:perform_action(act.ActivateKeyTable({ name = "tmux", one_shot = false, replace_current = true }), pane)
    -- log_message("Switching to tmux key table")
  else
    title = "WezTerm"
    window:perform_action(act.ActivateKeyTable({ name = "wezterm", one_shot = false, replace_current = true }), pane)
    -- log_message("Switching to wezterm key table")
  end
  -- window:set_title(title .. " | Poll Count: " .. check_count)  -- Update the title with the counter
  -- log_message("Title set to: " .. title .. " | Poll Count: " .. check_count)
end

-- Set up a periodic timer to call updateTitleAndKeys
wezterm.on("update-right-status", function(window, pane)
  local current_time = os.time()
  if current_time - last_update_time >= update_interval then
    last_update_time = current_time
    updateTitleAndKeys(window, pane)
  end
end)

wezterm.on("window-config-reloaded", function(window, pane)
  -- Force an initial update when the window config is reloaded
  updateTitleAndKeys(window, pane)
end)

-- Other necessary event listeners
wezterm.on("window-focus-changed", function(window, pane)
  updateTitleAndKeys(window, pane)
end)

wezterm.on("mux-start", function()
  for _, window in ipairs(wezterm.mux.all_windows()) do
    for _, tab in ipairs(window:tabs()) do
      for _, pane in ipairs(tab:panes()) do
        updateTitleAndKeys(window, pane)
      end
    end
  end
end)

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
  if isTmux() then
    return "Tmux | Poll Count: " .. check_count
  else
    return "WezTerm | Poll Count: " .. check_count
  end
end)

return {
  set_environment_variables = {
    WEZTERM_SESSION = session_id,
  },
  initial_cols = 112,
  initial_rows = 34,
  enable_tab_bar = false,
  font = wezterm.font_with_fallback({
    { family = "Hack Nerd Font", weight = "Regular" },
    { family = "SauceCodePro Nerd Font", weight = "DemiBold" },
    "Hack Nerd Font",
    "SauceCodePro Nerd Font",
    "Hack",
    "SauceCodePro",
  }),
  font_size = 16,
  window_padding = { left = 4, right = 4, top = 4, bottom = 0 },
  use_fancy_tab_bar = true,
  colors = color_scheme.kanagawa,
  scrollback_lines = 5000,
  enable_scroll_bar = true,
  min_scroll_bar_height = "2cell",
  background = {
    {
      source = { File = wezterm.config_dir .. "/dark_tile.png" },
      repeat_x = "Repeat",
      repeat_y = "Repeat",
      opacity = 0.50,
      hsb = { brightness = 0.92, hue = 1.000, saturation = 1.000 },
    },
    {
      source = { File = wezterm.config_dir .. "/background.png" },
      width = "58cell",
      height = "29cell",
      vertical_offset = "-1cell",
      repeat_x = "Repeat",
      repeat_y = "Repeat",
      opacity = 0.75,
      hsb = { brightness = 0.020, hue = 1.00, saturation = 0.33 },
    },
    {
      source = { File = wezterm.config_dir .. "/purple_tile.png" },
      repeat_x = "Repeat",
      repeat_y = "Repeat",
      opacity = 0.38,
      hsb = { brightness = 0.25, hue = 1.000, saturation = 1.000 },
    },
    {
      source = { File = wezterm.config_dir .. "/dark_tile.png" },
      repeat_x = "Repeat",
      repeat_y = "Repeat",
      opacity = 0.25,
      hsb = { brightness = 0.92, hue = 1.000, saturation = 1.000 },
    },
  },
  key_tables = key_bindings.key_tables,
  keys = key_bindings.keys,
}
