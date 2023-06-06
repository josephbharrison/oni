-- which-key labels
local wk = require("which-key")
wk.register({
	g = { name = "Git"},
}, { prefix = "<leader>" })

-- commands
local commands = {
	
	["git_menu"] = { "<cmd>Git<cr>", desc = "Git Menu" },
	["git_add"] = { "<cmd>Git add<cr>", desc = "Git add" },
	["git_commit"] = { "<cmd>Git commt<cr>", desc = "Git commit" },
	["git_diff"] = { "<cmd>Git diff<cr>", desc = "Git diff" },
	["git_merge"] = { "<cmd>Git merge<cr>", desc = "Git merge" },
	["git_push"] = { "<cmd>Git push<cr>", desc = "Git push" },
	["git_pull"] = { "<cmd>Git pull<cr>", desc = "Git pull" },
	["git_init"] = { "<cmd>Git init<cr>", desc = "Git init" },
	["git_diff_left"] = { "<cmd>diffget //2<cr>", desc = "Git init" },
	["git_diff_right"] = { "<cmd>diffget //3<cr>", desc = "Git init" },
}

-- leader mappings
mappings = {
	["<leader>g"] = false,
	["<leader>gg"] = commands.git_menu,
	["<leader>ga"] = commands.git_add,
	["<leader>gc"] = commands.git_commit,
	["<leader>gd"] = commands.git_diff,
	["<leader>gm"] = commands.git_merge,
	["<leader>gp"] = commands.git_pull,
	["<leader>gP"] = commands.git_push,
	["<leader>gi"] = commands.git_init,
	["<leader>gh"] = commands.git_diff_left,
	["<leader>gl"] = commands.git_diff_right,
}

-- map keys
for k, v in pairs(mappings) do
	if v then 
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end
