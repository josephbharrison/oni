return {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    },
    config = function ()
        require("chatgpt").setup({
            -- api_key_cmd = "pass show chatgpt/api",
        })
    end

}
