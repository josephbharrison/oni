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

vim.lsp.config('helm_ls', {
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
})

vim.lsp.config('yamlls', {
    settings = {
        yaml = {
            keyOrdering = false
        }
    }
})

vim.lsp.config('rust_analyzer', {
    filetypes = { "rust" },
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true
            }
        }
    }
})

vim.lsp.config('pyright', {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "strict",
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                disableTaggedHints = true,
                diagnosticSeverityOverrides = {
                    reportUnusedVariable = false,
                    reportUnusedImport = "warning",
                    reportMissingImports = "error",
                },
                venvPath = ".",
                venv = "venv",
            },
        },
    },
})

-- Additional diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    float = { border = 'rounded' },
})
