-- which-key labels
local wk = require("which-key")
wk.register({
	f = { name = "Finder"},
}, { prefix = "<leader>" })

-- functions
local telescope = require("telescope.builtin")

-- commands
local commands = {
	["fuzzy_finder"] = { telescope.find_files , desc = "Find files" },
	["git_finder"] = { telescope.git_files,  desc = "Find Git" },
	["grep_finder"] = {
		function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") });
		end, desc = "Grep files" },
	}

-- leader mappings
local mappings = {
	["<leader>f"] = false,
	["<leader>ff"] = commands.fuzzy_finder,
	["<leader>fg"] = commands.git_finder,
	["<leader>fG"] = commands.grep_finder,
}

for k, v in pairs(mappings) do
	if v then
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end
