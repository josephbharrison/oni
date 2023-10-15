return {
    "josephbharrison/onitheme",
    config = function()
        require("onitheme").setup({
            palette = "onirust",
            termguicolors = true,
            terminal_color = true,
            plugin_default = "auto",
            plugins = {
                ["bufferline.nvim"] = false,
            },
            palettes = {
                global = {},
                onirust = {
                    LightPink = "#AE95B8",
                    red = "#D39668",
                    green = "#B6BC72",
                    LightBlue = "#ADD8E6",
                    white = "#C5C8C5",
                    DarkGray = "#1E1F21",
                },
            },
            highlights = {
                global = {
                    modify_hl_groups = function(hl, c)
                        hl.PluginColor4 = {fg = c.my_grey, bg = c.none }
                    end,
                    ["@String"] = {fg = "#ff00ff", bg = "NONE"},
                },
                onirust = {
                    modify_hl_groups = function(hl, c)
                        hl.Comment.italic = true
                        hl.Keyword = {fg = c.LightPink}
                        hl.Include = {fg = c.white}
                        hl.StorageClass = {fg = c.LightPink}
                        hl.Type = {fg = c.red}
                        hl.Operator = {fg = c.white}
                        hl.Function = {fg = c.white}
                        hl.rustSigil = {fg = c.white}
                        hl.rustModPathSep = {fg = c.white}
                        hl.rustFuncName = {fg = c.LightBlue}
                        hl.Normal = {fg = c.white, bg = c.DarkGray}
                    end,
                    ["@String"] = {fg = "#ff00ff", bg = "NONE"},
                },
            },
            patterns = {
                -- Custom pattern for highlighting the 'main' function
                rustFuncName = {
                    'main',
                },
            },
        })
    end
}
