-- which-key labels
local wk = require("which-key")
wk.add({
    { "<leader>f", group = "Finder" },
})

-- functions
local telescope = require("telescope.builtin")

-- commands
local commands = {
	["fuzzy_finder"] = { telescope.find_files , desc = "Find files" },
	["git_finder"] = { telescope.git_files,  desc = "Find Git" },
	["live_grep"] = { ":Telescope live_grep<cr>",  desc = "Live Grep" },
	["git_commit"] = { ":Telescope git_commits<cr>",  desc = "Git Commits" },
}

-- leader mappings
local mappings = {
	["<leader>f"] = false,
	["<leader>ff"] = commands.fuzzy_finder,
	["<leader>fg"] = commands.git_finder,
	["<leader>fG"] = commands.live_grep,
	["<leader>fc"] = commands.git_commit,
}

for k, v in pairs(mappings) do
	if v then
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end
