-- which-key labels
local wk = require("which-key")
wk.add({
    { "<leader>m", group = "Magma" },
})

vim.cmd('silent! UpdateRemotePlugins')
vim.g.magma_automatically_open_output = true
vim.g.magma_image_provider = "kitty"

-- magma commands
local commands = {
	["init"] = { ":MagmaInit<cr>", desc = "Init" },
	["initPython"] = { ":MagmaInitPython<cr>", desc = "InitPython" },
	["evalOp"] = { ":MagmaEvaluateOperator<cr>", desc = "Evaluate Operator" },
	["evalLine"] = { ":MagmaEvaluateLine<cr>", desc = "Evaluate Line" },
	["evalVis"] = { ":<C-u>MagmaEvaluateVisual<cr>", desc = "Evaluate Visual" },
	["evalCell"] = { ":MagmaReevaluateCell<cr>", desc = "Evaluate Cell" },
	["delCell"] = { ":MagmaDelete<cr>", desc = "Delete Cell" },
	["showOutput"] = { ":MagmaShowOutput<cr>", desc = "Show Output" },
	["restart"] = { ":MagmaRestart!<cr>", desc = "Restart" },
	["save"] = { ":MagmaSave<cr>", desc = "Save" },
	["load"] = { ":MagmaLoad<cr>", desc = "Load" },
	["enterOutput"] = { ":MagmaEnterOutput<cr>", desc = "Enter Output" },
	["deinit"] = { ":MagmaDeinit<cr>", desc = "Deinit" },
	["nextCell"] = { ":execute  'normal! }j'<cr>", desc = "Next Cell" },
	["prioCell"] = { ":execute  'normal! {{j'<cr>", desc = "Prior Cell" },
}

-- magma leader -> function mappings
local mappings = {
	["<leader>m"] = false,
	["<leader>mi"] = commands.init,
	["<leader>mD"] = commands.deinit,
	["<leader>mo"] = commands.evalOp,
	["<leader>ml"] = commands.evalLine,
	["<leader>mc"] = commands.evalCell,
	["<leader>md"] = commands.delCell,
	["<leader>ms"] = commands.showOutput,
	["<leader>mr"] = commands.restart,
	["<leader>mS"] = commands.save,
	["<leader>mL"] = commands.load,
	["<leader>mO"] = commands.enterOutput,
	["<leader>mp"] = commands.initPython,
}

for k, v in pairs(mappings) do
	if v then
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end

-- Apply specific mapping for visual mode
vim.keymap.set('v', '<C-m>', commands.evalVis[1], {desc=commands.evalVis["desc"]})
vim.keymap.set('n', '<M-m>', commands.evalLine[1], {desc=commands.evalLine["desc"]})
vim.keymap.set('n', '<C-.>', commands.nextCell[1], {desc=commands.nextCell["desc"]})
vim.keymap.set('n', '<C-,>', commands.prioCell[1], {desc=commands.prioCell["desc"]})
