local lsp_zero = require("lsp-zero")

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed =
{
    "java_language_server",
	"tsserver",
	"eslint",
	"lua_ls",
	"gopls",
    "rust_analyzer",
	"pyright",
    "yamlls",
},
  handlers = {
    lsp_zero.default_setup,
  },
})

lsp_zero.preset("recommended")

-- override lsp presets
lsp_zero.preset({
  float_border = 'rounded',
  call_servers = 'local',
  configure_diagnostics = true,
  setup_servers_on_start = true,
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
    set_extra_mappings = true,
    use_luasnip = true,
    set_format = true,
    documentation_window = true,
  },
})

-- configure language servers here --
lsp_zero.configure("yamlls", {
  settings = {
    yaml = {
      keyOrdering = false
    }
  }
})

-- configure language servers here --
lsp_zero.configure("rust_analyzer", {
    filetypes = {"rust"},
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true
            }
        }
    }
})


-- local lsp_config = require("lspconfig")
--
-- lsp_config.lua_ls.setup(lsp.nvim_lua_ls())
--
-- lsp_config['omnisharp'].setup {
--     handlers = {
--         ["textDocument/definition"] = require('omnisharp_extended').handler,
--     },
--     cmd = { '~/.cache/omnisharp-vim/omnisharp-roslyn/run', '--languageserver' },
--     on_init = function(client)
--       client.server_capabilities.semanticTokensProvider = nil
--     end
-- }
--

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
	["<leader>gd"] = commands.goto_def,
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
lsp_zero.on_attach(function(client, bufnr)
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

lsp_zero.setup()

-- cmp commands
local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_action = require('lsp-zero').cmp_action()
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
})

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
  }
})

lsp_zero.setup_nvim_cmp({
	mapping = cmp_mappings
})
