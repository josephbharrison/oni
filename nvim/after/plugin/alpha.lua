local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local header = {
    "",
    "",
    "  ░░░░░░  ░░░    ░░ ░░   ░░░    ░░ ░░    ░░ ░░ ░░░    ░░░ ",
    " ▒▒    ▒▒ ▒▒▒▒   ▒▒ ▒▒   ▒▒▒▒   ▒▒ ▒▒    ▒▒ ▒▒ ▒▒▒▒  ▒▒▒▒ ",
    " ▒▒    ▒▒ ▒▒ ▒▒  ▒▒ ▒▒   ▒▒ ▒▒  ▒▒ ▒▒    ▒▒ ▒▒ ▒▒ ▒▒▒▒ ▒▒ ",
    " ▓▓    ▓▓ ▓▓  ▓▓ ▓▓ ▓▓   ▓▓  ▓▓ ▓▓  ▓▓  ▓▓  ▓▓ ▓▓  ▓▓  ▓▓ ",
    "  ██████  ██   ████ ██   ██   ████   ████   ██ ██      ██ ",
}
dashboard.section.header.val = header
dashboard.section.header.opts = {
    position = "center",
    -- hl = "Exception"
    -- hl = "Identifier"
    -- hl = "Macro"
    -- hl = "Special"
    -- hl = "Constant"
    -- hl = "Operator"
    -- hl = "String"
    -- hl = "Type"
    -- hl = "TypeDef"
    -- hl = "@method"
    -- hl = "@parameter"
    -- hl = "@namespace"
    -- hl = "@function.builtin"
    -- hl = "@constant.builtin"
    -- hl = "@variable"
    hl = "@exception"
}
alpha.setup(dashboard.config)
