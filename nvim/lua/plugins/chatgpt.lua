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
            -- Either setup the env variable with `export OPENAI_API_KEY=<api_key>`
            -- ... or use a secure local secret manager, like `pass`:
            api_key_cmd = "pass show chatgpt/api",
        })
    end
}
