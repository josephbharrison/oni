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

