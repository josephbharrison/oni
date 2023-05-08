return {
  "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>o", "<cmd>Neotree toggle<cr>", desc = "Tree View" },
    },
    dependencies = { 
	    "nvim-lua/plenary.nvim",
	    "nvim-tree/nvim-web-devicons",
	    "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({})
    end,
}
