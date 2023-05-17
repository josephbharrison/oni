-- Italicize comments
vim.api.nvim_set_hl(0, "Comment", { italic = true })

-- Set indent to 2 with javascript files
vim.cmd [[
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx Neoformat
]]

-- Prettier formatting
vim.g.neoformat_javascript_prettier = {
  exe = 'prettier',
  args = {'--single-quote', '--trailing-comma=all', '--print-width=80'},
  stdin = 1
}

