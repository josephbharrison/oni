-- set <leader> to Space
vim.g.mapleader = " "

-- Make current file executable
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
-- Move selected visual mode lines with indent
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- Move lower line up, without EOL
vim.keymap.set("n", "J", "mzJ`z")
-- Up and Down half-page nav 
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Continue last search string
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- force format of current buffer
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)
-- source current file
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)
-- Noop Shift-Q
vim.keymap.set("n", "Q", "<nop>")

-- -- remaps not yet used
-- vim.keymap.set("n", "Y", "yg$") -- Keep vim and exernal copy buffer separat
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") -- start tmux session
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>y", "\"+y")
-- vim.keymap.set("v", "<leader>y", "\"+y")
-- vim.keymap.set("n", "<leader>Y", "\"+Y")
-- vim.keymap.set("n", "<leader>d", "\"_d")
-- vim.keymap.set("v", "<leader>d", "\"_d")
