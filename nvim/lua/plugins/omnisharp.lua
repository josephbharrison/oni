return {
    -- "Hoffs/omnisharp-extended-lsp.nvim",
    "OmniSharp/omnisharp-vim",
    -- config = function()
    --     local pid = vim.fn.getpid()
    --     local omnisharp_bin = "/Users/work/.cache/omnisharp-vim/omnisharp-roslyn/run"
    --     local command = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }
    --     -- for _, v in pairs(command) do
    --     --     print(v)
    --     -- end
    --     require'lspconfig'.omnisharp.setup{
    --         handlers = {
    --             ["textDocument/definition"] = require('omnisharp_extended').handler,
    --         },
    --         cmd = command,
    --         omnisharp = {
    --             useModernNet = true,
    --             -- useGlobalMono = "always",
    --             -- monoPath = "/Library/Frameworks/Mono.framework/Versions/Current/Commands"
    --         }
    --     }
    -- end
}

