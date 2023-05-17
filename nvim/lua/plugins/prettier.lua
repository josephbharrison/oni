return {
    "MunifTanjim/prettier.nvim",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
        require("prettier").setup()
    end
}
