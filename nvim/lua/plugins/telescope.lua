return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-media-files.nvim',
    },
    config = function()
        require('telescope').setup({
            extensions = {
                media_files = {
                    filetypes = {
                        "png",
                        "webp",
                        "jpg",
                        "jpeg",
                    }
                },
                find_cmd = "rg"
                -- find_cmd = "wezterm imgcat",
            }
        })
    end

}
