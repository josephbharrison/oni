return {
    "simrat39/rust-tools.nvim",
	dependencies = { 'VonHeikemen/lsp-zero.nvim' },
    config = function()
        local lsp = require('lsp-zero')
        lsp.preset('recommended')
        local rust_lsp = lsp.build_options('rust_analyzer', {})
        lsp.setup()
        require('rust-tools').setup({
            server = rust_lsp;
            capabilities = lsp.capabilities;
        })
    end
}
