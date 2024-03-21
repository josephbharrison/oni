
-- which-key labels
local wk = require("which-key")

wk.register({
	m = { name = "Todo"},
}, { prefix = "<leader>" })

-- todo commands
local commands = {
	["todo"] = { ":TodoLocList<cr>", desc = "Todo List" },
}

-- todo leader -> function mappings
local mappings = {
	["<leader>T"] = commands.todo,
}

for k, v in pairs(mappings) do
	if v then
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end
