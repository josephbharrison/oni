local wezterm = require("wezterm")
local act = wezterm.action

-- Deep copy function to copy tables
local function DeepCopy(obj)
  local copyTable = {}
  local function copy(o)
    if type(o) ~= "table" then
      return o
    end
    local newTable = {}
    copyTable[o] = newTable
    for k, v in pairs(o) do
      newTable[copy(k)] = copy(v)
    end
    return setmetatable(newTable, getmetatable(o))
  end
  copyTable = copy(obj)
  return copyTable
end

local tmuxActions = {
  -- Define Tmux-specific key bindings
  cmd_d = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "|" }) }),
  cmd_shift_d = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "-" }) }),
  cmd_t = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "c" }) }),
  cmd_w = act.SendKey({ key = "d", mods = "CTRL" }),
  cmd_shift_Enter = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "m" }) }),
  cmd_shift_LeftBracket = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "p" }) }),
  cmd_shift_RightBracket = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "n" }) }),
  cmd_ctrl_LeftBracket = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "p" }) }),
  cmd_ctrl_RightBracket = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "n" }) }),
  cmd_opt_i = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "x", mods = "CTRL" }) }),
  cmd_shift_i = act.Multiple({ act.SendKey({ key = "a", mods = "CTRL" }), act.SendKey({ key = "x", mods = "OPT" }) }),
}

local keymap = {
  cmd_d = { key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  cmd_shift_d = { key = "d", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  cmd_k = { key = "k", mods = "CMD", action = act.ClearScrollback("ScrollbackOnly") },
  cmd_RightArrow = { key = "RightArrow", mods = "CMD", action = act.ActivatePaneDirection("Right") },
  cmd_LeftArrow = { key = "LeftArrow", mods = "CMD", action = act.ActivatePaneDirection("Left") },
  cmd_UpArrow = { key = "UpArrow", mods = "CMD", action = act.ActivatePaneDirection("Up") },
  cmd_DownArrow = { key = "DownArrow", mods = "CMD", action = act.ActivatePaneDirection("Down") },
  cmd_RightBracket = { key = "]", mods = "CMD", action = act.ActivatePaneDirection("Next") },
  cmd_LeftBracket = { key = "[", mods = "CMD", action = act.ActivatePaneDirection("Next") },
  cmd_ctrl_LeftBracket = { key = "[", mods = "CMD|CTRL", action = act.ActivateTabRelative(-1) },
  cmd_ctrl_RightBracket = { key = "]", mods = "CMD|CTRL", action = act.ActivateTabRelative(1) },
  cmd_shift_LeftBracket = { key = "{", mods = "CMD", action = act.ActivateTabRelative(-1) },
  cmd_shift_RightBracket = { key = "}", mods = "CMD", action = act.ActivateTabRelative(1) },
  cmd_w = { key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = false }) },
  cmd_shift_Enter = { key = "Enter", mods = "CMD|SHIFT", action = act.TogglePaneZoomState },
  cmd_ctrl_f = { key = "f", mods = "CMD|CTRL", action = act.ToggleFullScreen },
  cmd_shift_k = { key = "k", mods = "CMD|SHIFT", action = act.ActivateKeyTable({ name = "wezterm", one_shot = false, replace_current = true }) },
  cmd_t = { key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
  cmd_shift_t = { key = "t", mods = "CMD|SHIFT", action = act.ActivateKeyTable({ name = "tmux", one_shot = false, replace_current = true }) },
  cmd_shift_w = { key = "w", mods = "CMD|SHIFT", action = act.ActivateKeyTable({ name = "wezterm", one_shot = false, replace_current = true }) },
  cmd_opt_i = { key = "i", mods = "CMD|OPT", action = act.ActivateKeyTable({ name = "wezterm", one_shot = false, replace_current = true }) },
  cmd_shift_i = { key = "i", mods = "CMD|SHIFT", action = act.ActivateKeyTable({ name = "wezterm", one_shot = false, replace_current = true }) },
}

local actionmap = { tmux = tmuxActions }

local function getKeys(name)
  local actions = actionmap[name]
  local newKeys = {}
  local mapCopy = DeepCopy(keymap)
  for k, v in pairs(mapCopy) do
    local newKey = v
    if actions and actions[k] then
      newKey.action = actions[k]
    end
    table.insert(newKeys, newKey)
  end
  return newKeys
end

return {
  key_tables = { tmux = getKeys("tmux"), wezterm = getKeys("wezterm") },
  keys = getKeys("default"),
}
