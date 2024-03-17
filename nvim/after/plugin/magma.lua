-- which-key labels
local wk = require("which-key")

wk.register({
	m = { name = "Magma"},
}, { prefix = "<leader>" })

-- harpoon commands
local commands = {
	["init"] = { ":MagmaInit<cr>", desc = "Init" },
	["evalOp"] = { ":MagmaEvaluateOperation<cr>", desc = "Evaluate Operation" },
	["evalLine"] = { ":MagmaEvaluateLine<cr>", desc = "Evaluate Line" },
	["evalVis"] = { ":<C-u>MagmaEvaluateVisual<cr>", desc = "Evaluate Visual" },
	["evalCell"] = { ":MagmaReevaluateCell<cr>", desc = "Reevaluate Cell" },
	["delCell"] = { ":MagmaDelete<cr>", desc = "Delete Cell" },
	["showOutput"] = { ":MagmaShowOutput<cr>", desc = "Show Output" },
	["restart"] = { ":MagmaRestart!<cr>", desc = "Restart" },
	["save"] = { ":MagmaSave<cr>", desc = "Save" },
}

-- harpoon leader -> function mappings
local mappings = {
	["<leader>m"] = false,
	["<leader>mi"] = commands.init,
	["<leader>mo"] = commands.evalOp,
	["<leader>ml"] = commands.evalLine,
	["<leader>mv"] = commands.evalVis,
	["<leader>mc"] = commands.evalCell,
	["<leader>md"] = commands.delCell,
	["<leader>ms"] = commands.showOutput,
	["<leader>mr"] = commands.restart,
	["<leader>mm"] = commands.save,
}

for k, v in pairs(mappings) do
	if v then
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end
