return {
    'stevearc/aerial.nvim',
    branch = 'nvim-0.11',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
    },
    opts = {},
    config = function()
        require("aerial").setup()
        vim.keymap.set("n", "<leader>O", "<cmd>AerialToggle<cr>", { desc = "Symbols Outline" })
    end
}
