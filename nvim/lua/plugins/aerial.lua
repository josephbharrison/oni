return {
    'stevearc/aerial.nvim',
    version = '*',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
    },
    opts = {},
    config = function()
        require("aerial").setup()
    end
}

