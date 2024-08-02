-- which-key labels
-- local wk = require("which-key")

-- Symbols commands
local commands = {
	["toggle"] = { ":SymbolsOutline<cr>", desc = "Symbols Outline" },
}

-- harpoon leader -> function mappings
local mappings = {
	["<leader>O"] = commands.toggle,
}

for k, v in pairs(mappings) do
	if v then
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end
