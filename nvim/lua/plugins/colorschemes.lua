return {
    "rebelot/kanagawa.nvim",
    "folke/tokyonight.nvim",
    "catppuccin/nvim",
    config = function()
        require('kanagawa').setup({
            compile = false,
            undercurl = true,
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true},
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false,
            dimInactive = false,
            terminalColors = true,
            colors = {
                palette = {},
                theme = {
                    wave = {},
                    lotus = {},
                    dragon = {},
                    all = {}
                },
            },
            overrides = function(colors)
                if colors then
                    print(colors)
                end
                return {}
            end,
            theme = "wave",
            background = {
                dark = "wave",
                light = "lotus"
            },
        });
    end
}
