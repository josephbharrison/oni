-- fast loader
vim.loader.enable()

-- lazy.nvim loader setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load global mappings
require("core.mappings")

-- Install plugins
local plugins = require("plugins")
require("lazy").setup(plugins)

-- Load user preferences
require("user")

-- Highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})

local function preview_location_callback(_, method, result)
  if result == nil or vim.tbl_isempty(result) then
    vim.lsp.log.info(method, 'No location found')
    return nil
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.preview_location(result[1])
  else
    vim.lsp.util.preview_location(result)
  end
end

function fold_comments()
  -- Save the initial cursor position
  local initial_cursor_pos = vim.api.nvim_win_get_cursor(0)

  -- Define the search pattern for comments
  local search_pattern = [[\v^\s*(//|\*/)]]

  -- Move to the beginning of the document to start search from the top
  vim.api.nvim_command('1')

  -- Keep track of the current position to avoid infinite loops
  local current_line = 0
  local last_line = vim.api.nvim_buf_line_count(0)

  while true do
    -- Perform the search from the current cursor position
    local found_line = vim.fn.search(search_pattern, 'W')

    -- Break the loop if no more comments are found or if we have returned to the start
    if found_line == 0 or found_line <= current_line or found_line >= last_line then
      break
    end

    -- Update current_line to the line where the comment was found
    current_line = found_line

    -- Determine if the current line is a single-line comment (//)
    local is_single_line_comment = vim.fn.getline(found_line):match("^%s*//")

    if is_single_line_comment then
      -- Check if the next line is also a single-line comment
      local next_line_comment = vim.fn.getline(found_line + 1):match("^%s*//")
      if next_line_comment then
        -- Toggle fold only if the next line is also a single-line comment
        vim.api.nvim_command('normal! za')
      end
    else
      -- If it's a block comment (or any other line matched by the pattern), toggle the fold without additional checks
      vim.api.nvim_command('normal! za')
    end

    -- Move cursor to the next line to continue search
    vim.api.nvim_command('normal j')
  end

  -- Restore the initial cursor position
  vim.api.nvim_win_set_cursor(0, initial_cursor_pos)
end

-- Map the function to a key, e.g., <leader>f
vim.api.nvim_set_keymap('n', '<leader>f', ':lua fold_comments()<CR>', {noremap = true, silent = true})
