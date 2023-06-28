-- which-key labels
local wk = require("which-key")

wk.register({
	G = { name = "ChatGPT"},
    Gr = { name = "ChatGPT Run"}
}, { prefix = "<leader>" })

-- ChatGPT functions
local chatgpt = require("chatgpt")

-- ChatGPT commands
local commands = {
	["chat"] = { function() chatgpt.openChat() end, desc = "ChatGPT Chat" },
	["auto_complete"] = { function() chatgpt.complete_code() end, desc = "Complete code" },
	["edit_with_instructions"] = { function() chatgpt.edit_with_instructions() end, desc = "Edit with instructions" },
	["select_awesome_prompt"] = { function() chatgpt.selectAwesomePrompt() end, desc = "Select awesome prompt" },
    ["run_grammar_correction"] = { "<cmd>ChatGPTRun grammar_correction<cr>", desc = "Grammar correction" },
	["run_translate"] = { "<cmd>ChatGPTRun translate<cr>", desc = "Translate" },
	["run_keywords"] = { "<cmd>ChatGPTRun keywords<cr>", desc = "Keywords" },
	["run_docstring"] = { "<cmd>ChatGPTRun docstring<cr>", desc = "Docstring" },
	["run_add_tests"] = { "<cmd>ChatGPTRun add_tests<cr>", desc = "Add tests" },
	["run_optimize_code"] = {"<cmd>ChatGPTRun optimize_code<cr>", desc = "Optimize code" },
	["run_summarize"] = { "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize" },
	["run_fix_bugs"] = { "<cmd>ChatGPTRun fix_bugs<cr>", desc = "Fix bugs" },
	["run_explain_code"] = { "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain code" },
	["run_roxygen_edit"] = { "<cmd>ChatGPTRun roxygen_edit<cr>", desc = "Roxygen edit" },
	["run_code_reliability_analysis"] = { "<cmd>ChatGPTRun code_reliability_analysis<cr>", desc = "Code reliability analysis" },
}

-- ChatGPT leader -> function mappings
local mappings = {
	["<leader>G"] = false,
	["<leader>Gg"] = commands.chat,
	["<leader>Gc"] = commands.auto_complete,
	["<leader>Gs"] = commands.select_awesome_prompt,
	["<leader>Ge"] = commands.edit_with_instructions,
	["<leader>Grg"] = commands.run_grammar_correction,
	["<leader>Grt"] = commands.run_translate,
	["<leader>Grk"] = commands.run_keywords,
	["<leader>Grd"] = commands.run_docstring,
	["<leader>GrT"] = commands.run_add_tests,
	["<leader>Gro"] = commands.run_optimize_code,
	["<leader>Grs"] = commands.run_summarize,
	["<leader>Grf"] = commands.run_fix_bugs,
	["<leader>Grx"] = commands.run_explain_code,
	["<leader>Grr"] = commands.run_roxygen_edit,
	["<leader>Gra"] = commands.run_code_reliability_analysis,
}

for k, v in pairs(mappings) do
	if v then 
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end
