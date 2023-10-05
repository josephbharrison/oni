-- Italicize comments
vim.api.nvim_set_hl(0, "Comment", { italic = true })

-- Set indent to 2 with javascript and typescript files
vim.cmd [[ autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal tabstop=2 shiftwidth=2 softtabstop=2 ]]

-- Configure Neoformat to use Prettier for js and ts
vim.g.neoformat_enabled_javascript = {'prettier'}
vim.g.neoformat_enabled_typescript = {'prettier'}

-- Set up Prettier options for js and ts
local prettier_args = {'--stdin-filepath', '%:p', '--tab-width=2', '--jsx-single-quote', '--single-quote', '--trailing-comma=all', '--print-width=80'};
vim.g.neoformat_javascriptreact_prettier = { exe = 'prettier', args = prettier_args, stdin = 1 }
vim.g.neoformat_typescriptreact_prettier = { exe = 'prettier', args = prettier_args, stdin = 1 }

-- Configure Neoformat to use Prettier for jsx and tsx
vim.g.neoformat_enabled_javascriptreact = {'prettier'}
vim.g.neoformat_enabled_typescriptreact = {'prettier'}

-- Format on save using BufWritePre
vim.cmd [[ autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx Neoformat ]]

-- Add cargo fmt for Rust files
vim.cmd [[ autocmd BufWritePost *.rs lua FormatRustFile() ]]

function FormatRustFile()
  vim.fn.system('cargo fmt')
  vim.cmd 'edit!'
end
