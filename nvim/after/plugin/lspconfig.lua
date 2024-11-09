-- Set up Mason and ensure language servers are installed
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        "eslint",
        "lua_ls",
        "gopls",
        "rust_analyzer",
        "pyright",
        "ts_ls",
        "helm_ls",
        "yamlls",
    }
})

-- Sign icons for diagnostics
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- on_attach function to set key mappings
local function on_attach(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    local keymap = vim.keymap.set
    keymap('n', 'K', vim.lsp.buf.hover, opts)
    keymap('n', 'gd', vim.lsp.buf.definition, opts)
    keymap('n', 'gD', vim.lsp.buf.declaration, opts)
    keymap('n', 'gi', vim.lsp.buf.implementation, opts)
    keymap('n', 'go', vim.lsp.buf.type_definition, opts)
    keymap('n', 'gr', vim.lsp.buf.references, opts)
    keymap('n', 'gs', vim.lsp.buf.signature_help, opts)
    keymap('n', '<F2>', vim.lsp.buf.rename, opts)
    keymap({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts)
    keymap('n', '<F4>', vim.lsp.buf.code_action, opts)

    -- Custom mappings
    keymap('n', '[d', vim.diagnostic.goto_next, opts)
    keymap('n', ']d', vim.diagnostic.goto_prev, opts)
end

-- Configure each language server
local lspconfig = require('lspconfig')

lspconfig.helm_ls.setup {
    on_attach = on_attach,
    filetypes = { "helm.yaml" },
    settings = {
        ['helm-ls'] = {
            logLevel = "info",
            valuesFiles = {
                mainValuesFile = "values.yaml",
                lintOverlayValuesFile = "values.lint.yaml",
                additionalValuesFilesGlobPattern = "values*.yaml"
            },
            yamlls = {
                enabled = true,
                enabledForFilesGlob = "*.{yaml,yml}",
                diagnosticsLimit = 50,
                showDiagnosticsDirectly = false,
                path = "yaml-language-server",
                config = {
                    schemas = {
                        kubernetes = "templates/**",
                    },
                    completion = true,
                    hover = true,
                    -- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
                }
            }
        }
    }
}

lspconfig.yamlls.setup({
    on_attach = on_attach,
    settings = {
        yaml = {
            keyOrdering = false
        }
    }
})

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    filetypes = { "rust" },
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true
            }
        }
    }
})

lspconfig.eslint.setup({ on_attach = on_attach })
lspconfig.lua_ls.setup({ on_attach = on_attach })
lspconfig.gopls.setup({ on_attach = on_attach })
lspconfig.pyright.setup({ on_attach = on_attach })
lspconfig.ts_ls.setup({ on_attach = on_attach }) -- Use `tsserver` for TypeScript

-- Configure nvim-cmp for auto-completion
local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- assuming you're using luasnip
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-f>'] = cmp.mapping(function(fallback)
            if require('luasnip').jumpable(1) then
                require('luasnip').jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-b>'] = cmp.mapping(function(fallback)
            if require('luasnip').jumpable(-1) then
                require('luasnip').jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }),
})

-- Additional diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    float = { border = 'rounded' },
})
