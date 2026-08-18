return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local ok, lsp_file_operations = pcall(require, "lsp-file-operations")
        if ok then
            capabilities = vim.tbl_deep_extend(
                "force",
                capabilities,
                lsp_file_operations.default_capabilities()
            )
        end

        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        vim.lsp.enable("sourcekit")

        vim.lsp.config("yamlls", {
            settings = {
                yaml = {
                    keyOrdering = false,
                    schemas = {
                        ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
                    },
                },
            },
        })
    end,
}
