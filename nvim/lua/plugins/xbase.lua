return {
   {
        "xbase-lab/xbase",
        run = "make install", -- make free_space (not recommended, longer build time)
        requires = {
            "nvim-lua/plenary-nvim",
            "nvim-telescope/telescope.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
        require ("xbase").setup({}) -- see default configuration bellow
        end,
    }
}
