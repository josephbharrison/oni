return {
    "nvim-tree/nvim-tree.lua",
    keys = {
        { "<leader>o", "<cmd>NvimTreeToggle<cr>", desc = "Tree View" },
    },
    config = function()
        require("nvim-tree").setup({
            actions = {
               open_file = {
                   quit_on_open = true
               }
            }
        })
    end
}
