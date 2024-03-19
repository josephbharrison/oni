-- after/plugin/pyright.lua
local lspconfig = require('lspconfig')

lspconfig.pyright.setup{
    -- on_attach = function(client, bufnr)
    --     -- Custom setup, like key mappings and buffer-specific settings, goes here
    -- end,
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
            venvPath = ".",
            venv = "venv",
        },
        venvPath = ".",
        venv = "venv",
    },
}
