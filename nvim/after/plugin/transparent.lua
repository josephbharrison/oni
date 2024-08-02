
-- commands
local commands = {
	["toggle_transparency"] = { "<cmd>TransparentToggle<cr>", desc = "Transparent (Toggle)" },
}

-- leader mappings
local mappings = {
	["<leader>T"] = false,
	["<leader>t"] = commands.toggle_transparency
}

-- map keys
for k, v in pairs(mappings) do
	if v then
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end
