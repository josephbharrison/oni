-- -- Forcibly delete current buffer
-- require('bufdelete').bufdelete(0, true)
-- -- Wipeout buffer number 100 without force
-- require('bufdelete').bufwipeout(100)
-- -- Delete every buffer from buffer 7 to buffer 30 without force
-- require('bufdelete').bufdelete({7, 30})
-- -- Delete buffer matching foo.txt with force
-- require('bufdelete').bufdelete("foo.txt", true)

-- -- which-key labels
-- local wk = require("which-key")
-- wk.register({
-- 	b = { name = "Buffer"},
-- }, { prefix = "<leader>" })

-- commands
local commands = {
    ["close_buffer"] = { function() require("bufdelete").bufdelete(0, false) end, desc = "Close Buffer" },
    ["force_close_buffer"] = { function() require("bufdelete").bufdelete(0, true) end, desc = "Force close buffer" }
}

-- leader mappings
local mappings = {
    ["<leader>c"] = commands.close_buffer,
    ["<leader>C"] = commands.force_close_buffer
}

-- map keys
for k, v in pairs(mappings) do
    if v then
        vim.keymap.set('n', k, v[1], {desc=v["desc"]})
    end
end

