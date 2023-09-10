local modules = {
    "aerial",
    "alpha",
    "astrotheme",
    "base16",
    "better-escape",
    "bufdelete",
    "bufferline",
    "chatgpt",
    "colorizer",
    "colorschemes",
    "comment",
    "copilot",
    "dressing",
    "friendly-snippets",
    "fugitive",
    "gitsigns",
    "harpoon",
    "heirline",
    "indent-blankline",
    "lspkind",
    "lspzero",
    "lspconfig",
    "neo-tree",
    "neoconf",
    "neodev",
    "neoformat",
    "nvim-dap",
    "nvim-dap-ui",
    "nvim-ts-autotag",
    "nvim-ts-context-commentstring",
    "nvim-window-picker",
    "smart-splits",
    "telescope",
    "todo-comments",
    "toggleterm",
    "transparent",
    "treesitter",
    "treesitter-playground",
    "twilight",
    "ufo",
    "undotree",
    "vim-tmux-navigator",
    "which-key",
    "zen-mode",
}

local plugins = {}

for i, module in ipairs(modules) do
    local plugin = require("plugins." .. module)
    plugins[i] = plugin
end

return { plugins }
