return {
    "AstroNvim/astrotheme",
    config = function()
        require("astrotheme").setup({
            palette = "astrodark",

            termguicolors = true,

            terminal_color = true,

            plugin_default = "auto",

            plugins = {
                ["bufferline.nvim"] = false,
            },

            palettes = {
                global = {
                    my_grey = "#ebebeb",
                    my_color = "#ffffff"
                },
                astrodark = {
                    red = "#800010",
                    my_color = "#000000"
                },
            },

            highlights = {
                global = {
                    modify_hl_groups = function(hl, c)
                        hl.PluginColor4 = {fg = c.my_grey, bg = c.none }
                    end,
                    ["@String"] = {fg = "#ff00ff", bg = "NONE"},
                },
                astrodark = {
                    modify_hl_groups = function(hl, c)
                        hl.Comment.fg = c.my_color
                        hl.Comment.italic = true
                    end,
                    ["@String"] = {fg = "#ff00ff", bg = "NONE"},
                },
            },
        })
    end
}
