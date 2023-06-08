
local zen = require("zen-mode")

local params = {
    window = {
        backdrop = 0.70,
        width = 90,
        options = {
            signcolumn = "no",
            number = true,
            relativenumber = true,
            cursorline = true,
            cursorcolumn = false,
            foldcolumn = "0",
            list = true,
        }
    },
    plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
            enabled = true,
            ruler = true, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
        },
        twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = true }, -- disables git signs
        tmux = { enabled = true }, -- disables the tmux statusline
        -- this will change the font size on wezterm when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
        wezterm = {
            enabled = true,
            font = "+4", -- (10% increase per step)
        },
    },
}

-- which-key labels
local wk = require("which-key")
wk.register({
	z = { name = "Zen"},
}, { prefix = "<leader>" })


-- commands
local commands = {
    ["toggle"] = { function()
        params.plugins.twilight.enabled = false;
        zen.toggle(params)
    end, desc = "Zen Mode" },
    ["toggle_twilight"] = { function()
        params.plugins.twilight.enabled = true;
        zen.toggle(params)
    end, desc = "Twilight Zen Mode" },
}

-- leader mappings
local mappings = {
    ["<leade>z"] = false,
    ["<leader>zz"] = commands.toggle,
    ["<leader>zt"] = commands.toggle_twilight
}

-- map keys
for k, v in pairs(mappings) do
    if v then
        vim.keymap.set('n', k, v[1], {desc=v["desc"]})
    end
end

