return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    {'neovim/nvim-lspconfig'},
    { -- Optional
      'williamboman/mason.nvim',
      build = function()
        -- Encapsulate the pcall invocation within a function definition
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional
    {'hrsh7th/nvim-cmp'},                  -- Required
    {'hrsh7th/cmp-nvim-lsp'},              -- Required
    {'L3MON4D3/LuaSnip'},                  -- Required
  },
}
