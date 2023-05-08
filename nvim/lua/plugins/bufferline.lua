return {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'nvim-tree/nvim-tree.lua',
    },
    opts = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true -- use a "true" to enable the default, or set your own character
            }
        }
    },
    config = function() require("bufferline").setup({
        options = {
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    separator = true -- use a "true" to enable the default, or set your own character
                }
            }
        }
    })
end
}

