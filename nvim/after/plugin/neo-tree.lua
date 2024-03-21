-- commands
local commands = {
	["explore"] = { "<cmd>NeoTreeFocusToggle<CR>", desc = "File Explorer" },
	["toggle"] = { "<cmd>Neotree toggle<CR>", desc = "File Explorer" },
}

-- leader mappings
local mappings = {
	["<leader>o"] = commands.toggle
}

-- map keys
for k, v in pairs(mappings) do
	if v then
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end
