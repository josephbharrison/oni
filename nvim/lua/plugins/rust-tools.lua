return {
    "simrat39/rust-tools.nvim",
	dependencies = { 'VonHeikemen/lsp-zero.nvim' },
    config = function()
        local lsp = require('lsp-zero')
        lsp.preset('recommended')
        local rust_lsp = lsp.build_options('rust_analyzer', {})
        lsp.setup()
        require('rust-tools').setup({
            tools = {
                inlay_hints = {
                    -- automatically set inlay hints (type hints)
                    -- default: true
                    auto = true,

                    -- Only show inlay hints for the current line
                    only_current_line = false,

                    -- whether to show parameter hints with the inlay hints or not
                    -- default: true
                    show_parameter_hints = true,

                    -- prefix for parameter hints
                    -- default: "<-"
                    parameter_hints_prefix = "<- ",

                    -- prefix for all the other hints (type, chaining)
                    -- default: "=>"
                    other_hints_prefix = "=> ",

                    -- whether to align to the length of the longest line in the file
                    max_len_align = false,

                    -- padding from the left if max_len_align is true
                    max_len_align_padding = 1,

                    -- whether to align to the extreme right or not
                    right_align = false,

                    -- padding from the right if right_align is true
                    right_align_padding = 7,

                    -- The color of the hints
                    highlight = "Comment",
                },
            };
            server = rust_lsp;
            capabilities = lsp.capabilities;
        })
    end
}
