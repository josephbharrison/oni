-- Italicize comments
vim.api.nvim_set_hl(0, "Comment", { italic = true })

-- Set indent to 4 with javascript files
vim.cmd [[
  autocmd FileType javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4
]]

-- Configure Neoformat to use Prettier
vim.g.neoformat_enabled_javascript = {'prettier'}

-- Set up Prettier options
vim.g.neoformat_javascript_prettier = {
  exe = 'prettier',
  args = {'--stdin-filepath', '%:p', '--tab-width=4', '--single-quote', '--trailing-comma=all', '--print-width=80'},
  stdin = 1
}

-- Format on save using BufWritePre
vim.cmd [[
  autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx Neoformat
]]

-- --
-- --
--
-- -- Italicize comments
-- vim.api.nvim_set_hl(0, "Comment", { italic = true })
--
-- -- Set indent to 4 with javascript files
-- vim.cmd [[
--   autocmd FileType javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4
-- ]]
--
-- -- Format on save using BufWritePre
-- vim.cmd [[
--   autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx Prettier
-- ]]
