-- which-key labels
local wk = require("which-key")
wk.register({
	s = { name = "Color Schemes"},
}, { prefix = "<leader>" })

-- commands
local commands = {
	["cat"] = { "<cmd>colorscheme catppuccin<cr>", desc = "catuppuccin" },
	["cat_frappe"] = { "<cmd>colorscheme  catppuccin-frappe<cr>", desc = "frappe" },
	["cat_latte"] = { "<cmd>colorscheme  catppuccin-latte<cr>", desc = "latte" },
	["cat_mocha"] = { "<cmd>colorscheme  catppuccin-mocha<cr>", desc = "mocha" },
	["cat_macchiato"] = { "<cmd>colorscheme  catppuccin-macchiato<cr>", desc = "macchiato" },
	["kanagawa"] = { "<cmd>colorscheme kanagawa<cr>", desc = "kanagawa" },
	["kanagawa_dragon"] = { "<cmd>colorscheme  kanagawa-dragon<cr>", desc = "dragon" },
	["kanagawa_lotus"] = { "<cmd>colorscheme  kanagawa-lotus<cr>", desc = "lotus" },
	["kanagawa_wave"] = { "<cmd>colorscheme  kanagawa-wave<cr>", desc = "wave" },
	["tokyonight"] = { "<cmd>colorscheme tokyonight<cr>", desc = "tokyonight" },
	["tokyonight_day"] = { "<cmd>colorscheme tokyonight-day<cr>", desc = "day" },
	["tokyonight_moon"] = { "<cmd>colorscheme tokyonight-moon<cr>", desc = "moon" },
	["tokyonight_night"] = { "<cmd>colorscheme tokyonight-night<cr>", desc = "night" },
	["tokyonight_storm"] = { "<cmd>colorscheme tokyonight-storm<cr>", desc = "storm" },
	["astro"] = { "<cmd>colorscheme astrotheme<cr>", desc = "astro" },
	["astro_dark"] = { "<cmd>colorscheme astrodark<cr>", desc = "dark" },
	["astro_light"] = { "<cmd>colorscheme astrolight<cr>", desc = "light" },
}

-- leader mappings
local mappings = {
	["<leader>s"] = false,
	["<leader>sc"] = commands.cat,
	["<leader>scf"] = commands.cat_frappe,
	["<leader>scl"] = commands.cat_latte,
	["<leader>scM"] = commands.cat_mocha,
	["<leader>scm"] = commands.cat_macchiato,
	["<leader>sk"] = commands.kanagawa,
	["<leader>skd"] = commands.kanagawa_dragon,
	["<leader>skl"] = commands.kanagawa_lotus,
	["<leader>skw"] = commands.kanagawa_wave,
	["<leader>st"] = commands.tokyonight,
	["<leader>std"] = commands.tokyonight_day,
	["<leader>stm"] = commands.tokyonight_moon,
	["<leader>stn"] = commands.tokyonight_night,
	["<leader>sts"] = commands.tokyonight_star,
	["<leader>sa"] = commands.astro,
	["<leader>sad"] = commands.astro_dark,
	["<leader>sal"] = commands.astro_light,
}

-- map keys
for k, v in pairs(mappings) do
	if v then 
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end
