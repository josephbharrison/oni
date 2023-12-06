local modules = {
    "which-key",
    "harpoon",
    -- "aerial", -- prefer symbol-outline
    "alpha",
    "astrotheme",
    "base16",
    "better-escape",
    "bookmarks",
    "bufdelete",
    "bufferline",
    "chatgpt",
    "colorizer",
    "colorschemes",
    "comment",
    "copilot",
    "docs-view",
    "dressing",
    "friendly-snippets",
    "fugitive",
    "gitsigns",
    "heirline",
    "hover",
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
    "onitheme",
    "omnisharp",
    "prettier",
    "rust-tools",
    "smart-splits",
    "symbols-outline",
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
    "zen-mode",
}

local plugins = {}

for i, module in ipairs(modules) do
    local plugin = require("plugins." .. module)
    plugins[i] = plugin
end

return { plugins }
