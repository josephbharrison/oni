return {
    "nvim-tree/nvim-tree.lua",
    keys = {
        { "<leader>o", "<cmd>NvimTreeToggle<cr>", desc = "Tree View" },
    },
    config = function()
        require("nvim-tree").setup()
    end
}
