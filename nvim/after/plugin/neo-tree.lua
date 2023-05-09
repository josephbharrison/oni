local neotree = require("neo-tree")

local is_neotree_focused = function()
    -- Get our current buffer number
    local bufnr = vim.api.nvim_get_current_buf and vim.api.nvim_get_current_buf() or vim.fn.bufnr()
    -- Get all the available sources in neo-tree
    for _, source in ipairs(require("neo-tree").config.sources) do
        -- Get each sources state
        local state = require("neo-tree.sources.manager").get_state(source)
        -- Check if the source has a state, if the state has a buffer and if the buffer is our current buffer
        if state and state.bufnr and state.bufnr == bufnr then
            print("Neotree is focused!")
            return true
        end
    end
    print("Neotree is not focused!")
    return false
end

local map_function = function()
    if not is_neotree_focused() then
        neotree.focus()
    else
        neotree.close_all()
    end
end


-- commands
local commands = {
	["explore"] = { function() map_function() end, desc = "File Explorer" },
}

-- leader mappings
local mappings = {
	["<leader>o"] = commands.explore
}

-- map keys
for k, v in pairs(mappings) do
	if v then 
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end

