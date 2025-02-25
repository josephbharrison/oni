-- dependencies = "Hoffs/omnisharp-extended-lsp.nvim",
return {
    "OmniSharp/omnisharp-vim",
    config = function()
        -- -- Set OmniSharp settings
        vim.g.OmniSharp_popup = 1
        vim.g.OmniSharp_popup_position = 'peek'
        vim.g.OmniSharp_server_use_net6 = 1
        -- vim.g.OmniSharp_server_use_mono = 1
        -- vim.g.OmniSharp_server_stdio = 1

        vim.g.OmniSharp_popup_options = {
            winblend = 30,
            winhl = 'Normal:Normal,FloatBorder:ModeMsg',
            border = 'rounded',
        }

        -- ALE linter configuration for C#
        vim.g.ale_linters = { cs = { 'OmniSharp' } }

        -- OmniSharp highlight groups
        vim.g.OmniSharp_highlight_groups = {
            FieldName = 'Normal',
            LocalName = 'Normal',
            ParameterName = 'MoreMsg',
            PropertyName = 'Normal',
            ConstantName = 'StatusLine',
            EnumName = 'Typedef',
            EnumMemberName = 'Normal',
        }

        -- Autocommands and key mappings
        vim.api.nvim_create_augroup('omnisharp_commands', { clear = true })

        -- -- CursorHold for type information
        -- vim.api.nvim_create_autocmd('CursorHold', {
        --     pattern = '*.cs',
        --     command = 'OmniSharpTypeLookup',
        --     group = 'omnisharp_commands',
        -- })

        -- Define the key mappings for C# file type
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'cs',
            callback = function()
                local buffer = vim.api.nvim_get_current_buf()
                local function map(mode, lhs, rhs)
                    vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, { noremap = true, silent = true })
                end

                -- Key mappings
                map('n', 'K', '<Plug>(omnisharp_type_lookup)')
                map('n', 'gd', '<Plug>(omnisharp_go_to_definition)')
                -- map('n', '<leader>gd', ':vsplit<CR><Plug>(omnisharp_go_to_definition)')
                -- map('n', '<leader>osfu', '<Plug>(omnisharp_find_usages)')
                -- map('n', '<leader>osfi', '<Plug>(omnisharp_find_implementations)')
                -- map('n', '<leader>ospd', '<Plug>(omnisharp_preview_definition)')
                -- map('n', '<leader>ospi', '<Plug>(omnisharp_preview_implementations)')
                -- map('n', '<leader>ost', '<Plug>(omnisharp_type_lookup)')
                -- map('n', '<leader>osd', '<Plug>(omnisharp_documentation)')
                -- map('n', '<leader>osfs', '<Plug>(omnisharp_find_symbol)')
                -- map('n', '<leader>osfx', '<Plug>(omnisharp_fix_usings)')
                -- map('n', '<C-\\>', '<Plug>(omnisharp_signature_help)')
                -- map('i', '<C-\\>', '<Plug>(omnisharp_signature_help)')
                -- map('n', '[[' , '<Plug>(omnisharp_navigate_up)')
                -- map('n', ']]', '<Plug>(omnisharp_navigate_down)')
                -- map('n', '<leader>osgcc', '<Plug>(omnisharp_global_code_check)')
                -- map('n', '<leader>osca', '<Plug>(omnisharp_code_actions)')
                -- map('x', '<leader>osca', '<Plug>(omnisharp_code_actions)')
                -- map('n', '<leader>os.', '<Plug>(omnisharp_code_action_repeat)')
                -- map('x', '<leader>os.', '<Plug>(omnisharp_code_action_repeat)')
                -- map('n', '<leader>os=', '<Plug>(omnisharp_code_format)')
                -- map('n', '<leader>osnm', '<Plug>(omnisharp_rename)')
                -- map('n', '<leader>osre', '<Plug>(omnisharp_restart_server)')
                -- map('n', '<leader>osst', '<Plug>(omnisharp_start_server)')
                -- map('n', '<leader>ossp', '<Plug>(omnisharp_stop_server)')
            end,
            group = 'omnisharp_commands',
        })
    end
}
