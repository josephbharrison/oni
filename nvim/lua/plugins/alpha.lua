return {
    'goolord/alpha-nvim',
    version = '*',
    opts = {},
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
}

