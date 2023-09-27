-- Italicize comments
vim.api.nvim_set_hl(0, "Comment", { italic = true })

-- Set indent to 4 with javascript and typescript files
vim.cmd [[
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal tabstop=4 shiftwidth=4 softtabstop=4
]]

-- Configure Neoformat to use Prettier for js and ts
vim.g.neoformat_enabled_javascript = {'prettier'}
vim.g.neoformat_enabled_typescript = {'prettier'}

-- Set up Prettier options for js and ts
vim.g.neoformat_javascript_prettier = {
  exe = 'prettier',
  args = {'--stdin-filepath', '%:p', '--tab-width=2', '--single-quote', '--trailing-comma=all', '--print-width=80'},
  stdin = 1
}
vim.g.neoformat_typescript_prettier = {
  exe = 'prettier',
  args = {'--stdin-filepath', '%:p', '--tab-width=2', '--single-quote', '--trailing-comma=all', '--print-width=80'},
  stdin = 1
}

-- Configure Neoformat to use Prettier for jsx and tsx
vim.g.neoformat_enabled_javascriptreact = {'prettier'}
vim.g.neoformat_enabled_typescriptreact = {'prettier'}

-- Format on save using BufWritePre
vim.cmd [[
  autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx Neoformat
]]

-- Add cargo fmt for Rust files
vim.cmd [[
  autocmd BufWritePost *.rs lua FormatRustFile()
]]

function FormatRustFile()
  vim.fn.system('cargo fmt')
  vim.cmd 'edit!'
end
