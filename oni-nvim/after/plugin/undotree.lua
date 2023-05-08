-- which-key labels
local wk = require("which-key")
wk.register({
	u = { name = "Undo"},
}, { prefix = "<leader>" })

-- commands
local commands = {
	["undo"] = { vim.cmd.UndotreeToggle, desc = "Toggle Undo" }
}

-- leader mappings
mappings = {
	["<leader>u"] = commands.undo,
}

for k, v in pairs(mappings) do
	if v then 
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end
