return {
    "dense-analysis/ale",
    config = function()
        -- ALE specific configurations
        vim.g.ale_linters_explicit = 1
        vim.g.ale_fix_on_save = 1
        vim.g.ale_lint_on_enter = 1

        -- Define linters and fixers
        vim.g.ale_linters = {
            javascript = {'eslint'},
            python = {'pylint'},
            go = {'golint'},
            cs = {'omnisharp'},
            -- Add other linters as needed
        }

        vim.g.ale_fixers = {
            ['*'] = {'remove_trailing_lines', 'trim_whitespace'},
            javascript = {'eslint'},
            python = {'autopep8'},
            go = {'gofmt'},
            -- Add other fixers as needed
        }

        -- Keybindings for ALE functionality
        vim.api.nvim_set_keymap('n', '<leader>a', ':ALEFix<CR>', {noremap = true, silent = true})
        vim.api.nvim_set_keymap('n', '<leader>d', ':ALEDetail<CR>', {noremap = true, silent = true})
        vim.api.nvim_set_keymap('n', '<leader>n', ':ALENext<CR>', {noremap = true, silent = true})
        vim.api.nvim_set_keymap('n', '<leader>p', ':ALEPrevious<CR>', {noremap = true, silent = true})
    end
}
