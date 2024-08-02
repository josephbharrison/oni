-- which-key labels
local wk = require("which-key")
wk.add({
    { "<leader>h", group = "Harpoon" },
    { "<leader>hm", group = "Harpoon Tmux" },
    { "<leader>ht", group = "Harpoon Terminal" },
})

-- harpoon functions
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local tmux = require("harpoon.ui")
local term = require("harpoon.term")

-- harpoon commands
local commands = {
	["menu"] = { ui.toggle_quick_menu, desc = "Harpoon Menu" },
	["add_file"] = { mark.add_file, desc = "Add File" },
	["nav_next"] = { function() ui.nav_next() end, desc = "Next File" },
	["nav_prev"] = { function() ui.nav_prev() end, desc = "Previous File" },
	["file_1"] = { function() ui.nav_file(1) end, desc = "File 1" },
	["file_2"] = { function() ui.nav_file(2) end, desc = "File 2" },
	["file_3"] = { function() ui.nav_file(3) end, desc = "File 3" },
	["file_4"] = { function() ui.nav_file(4) end, desc = "File 4" },
	["tmux_1"] = { function() tmux.gotoTerminal(1) end, desc = "TMux 1" },
	["tmux_2"] = { function() tmux.gotoTerminal(2) end, desc = "TMux 2" },
	["tmux_3"] = { function() tmux.gotoTerminal(3) end, desc = "TMux 3" },
	["tmux_4"] = { function() tmux.gotoTerminal(4) end, desc = "TMux 4" },
	["term_1"] = { function() tmux.gotoTerminal(1) end, desc = "Terminal 1" },
	["term_2"] = { function() term.gotoTerminal(2) end, desc = "Terminal 2" },
	["term_3"] = { function() term.gotoTerminal(3) end, desc = "Terminal 3" },
	["term_4"] = { function() term.gotoTerminal(4) end, desc = "Terminal 4" },
	["telescope"] = { ":Telescope harpoon marks<cr>", desc = "Telescope Marks" },
}

-- harpoon leader -> function mappings
mappings = {
	["<leader>h"] = false,
	["<leader>ha"] = commands.add_file,
	["<leader>hh"] = commands.menu,
	["<leader>hn"] = commands.nav_next,
	["<leader>hp"] = commands.nav_prev,
	["<leader>h1"] = commands.file_1,
	["<leader>h2"] = commands.file_2,
	["<leader>h3"] = commands.file_3,
	["<leader>h4"] = commands.file_4,
	["<leader>hm1"] = commands.tmux_1,
	["<leader>hm2"] = commands.tmux_2,
	["<leader>hm3"] = commands.tmux_3,
	["<leader>hm4"] = commands.tmux_4,
	["<leader>ht1"] = commands.term_1,
	["<leader>ht2"] = commands.term_2,
	["<leader>ht3"] = commands.term_3,
	["<leader>ht4"] = commands.term_4,
	["<leader>hT"] = commands.telescope,
}

for k, v in pairs(mappings) do
	if v then
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end
