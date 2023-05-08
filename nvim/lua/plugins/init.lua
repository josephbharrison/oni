local modules = {
  "neoconf",
  "neodev",
  "which-key",
  "colorschemes",
  "telescope",
  "treesitter",
  "treesitter-playground",
  "neo-tree",
  "harpoon",
  "undotree",
  "fugative",
  "lspzero",
  "comment",
  "friendly-snippets",
  "arial",
  "alpha",
  "better-escape",
  "bufdelete",
  "bufferline",
  "dressing",
  "gitsigns",
  "heirline",
  "indent-blankline",
  "lspkind",
  "nvim-dap",
  "nvim-dap-ui",
  "nvim-ts-autotag",
  "nvim-ts-context-commentstring",
  "smart-splits",
  "todo-comments",
  "toggleterm",
  "twilight",
  "zen-mode",
  "resession",
  "nvim-window-picker",
}

local plugins = {}

for i, module in ipairs(modules) do
    local plugin = require("plugins." .. module)
    plugins[i] = plugin
end

return { plugins }
