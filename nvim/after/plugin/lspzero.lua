local lsp = require("lsp-zero")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"lua_ls",
	"rust_analyzer",
	"gopls",
	"pyright",
    "yamlls",
})

lsp.preset("recommended")

-- override lsp presets
lsp.preset({
  float_border = 'rounded',
  call_servers = 'local',
  configure_diagnostics = true,
  setup_servers_on_start = true,
  -- set_lsp_keymaps = false,
  sign_icons = {
    error = '',
    warn = '',
    hint = '',
    info = '',
  },
  set_lsp_keymaps = { omit = { '<tab>', '<Tab>', '<C-k>' } },
  manage_nvim_cmp = {
    set_sources = 'recommended',
    set_basic_mappings = true,
    set_extra_mappings = false,
    use_luasnip = true,
    set_format = true,
    documentation_window = true,
  },
})

-- configure language servers here --
lsp.configure("yamlls", {
  settings = {
    yaml = {
      keyOrdering = false
    }
  }
})

-- LSP commands
local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

-- mapping commands
local commands = {
	["goto_def"] = { function() vim.lsp.buf.definition() end, desc = "Goto definition" },
	["hover"] = { function() vim.lsp.buf.hover() end, desc = "Hover" },
	["ws_symbol"] = { function() vim.lsp.buf.workspace_symbol('⌘') end, desc = "Workspace symbol" },
	["diag"] = { function() vim.diagnotics.open_float() end, desc = "Diagnostics" },
	["diag_next"] = { function() vim.diagnotics.goto_next() end, desc = "Next diagnostics" },
	["diag_prev"] = { function() vim.diagnotics.goto_prev() end, desc = "Prev diagnostics" },
	["code_action"] = { function() vim.lsp.buf.code_action() end, desc = "Code action" },
	["references"] = { function() vim.lsp.buf.references() end, desc = "References" },
	["rename"] = { function() vim.lsp.buf.rename() end, desc = "Rename" },
	["sig_help"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature help" },
}

-- leader mappings
local n_mappings = {
	["K"] = commands.hover,
	["[d"] = commands.diag_next,
	["]d"] = commands.diag_prev,
	["<leader>Gd"] = commands.goto_def,
	["<leader>vws"] = commands.ws_symbol,
	["<leader>vd"] = commands.diag,
	["<leader>vca"] = commands.code_action,
	["<leader>frr"] = commands.references,
	["<leader>vrn"] = commands.rename,
}

local i_mappings = {
	["<C-s>"] = commands.sig_help,
}

-- map keys
lsp.on_attach(function(client, bufnr)
    local print_client = false
	if print_client then
		print(client)
	end
	local opts = {buffer = bufnr, remap = false, desc = "none"}

	-- n map keys
	for k, v in pairs(n_mappings) do
		if v then
			opts["desc"] = v["desc"]
			vim.keymap.set('n', k, v[1], opts)
		end
	end

	-- i map keys
	for k, v in pairs(i_mappings) do
		if v then
			opts["desc"] = v["desc"]
			vim.keymap.set('i', k, v[1], opts)
		end
	end
end)

lsp.setup()
