return {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'nvim-tree/nvim-tree.lua',
    },
    config = function()
        require("bufferline").setup( {
            options = {
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = true
                    }
                }
            }
        })
    end,
}
