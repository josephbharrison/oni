local randPort = function()
    local port = math.random(30000, 40000)
    return port
end

local goPort = randPort()

-- -- Transparency setting
-- require("notify").setup {
--     background_colour = "#000000",
-- }

vim.api.nvim_set_hl(0, "Comment", { italic = true })

-- Global DAP configuration
local dap = require "dap"
require("dap.ext.vscode").load_launchjs()

local placeholders = {
    ["${file}"] = function(_) return vim.fn.expand "%:p" end,
    ["${fileBasename}"] = function(_) return vim.fn.expand "%:t" end,
    ["${fileBasenameNoExtension}"] = function(_) return vim.fn.fnamemodify(vim.fn.expand "%:t", ":r") end,
    ["${fileDirname}"] = function(_) return vim.fn.expand "%:p:h" end,
    ["${fileExtname}"] = function(_) return vim.fn.expand "%:e" end,
    ["${relativeFile}"] = function(_) return vim.fn.expand "%:." end,
    ["${relativeFileDirname}"] = function(_) return vim.fn.fnamemodify(vim.fn.expand "%:.:h", ":r") end,
    ["${workspaceFolder}"] = function(_) return vim.fn.getcwd() end,
    ["${workspaceFolderBasename}"] = function(_) return vim.fn.fnamemodify(vim.fn.getcwd(), ":t") end,
    ["${env:([%w_]+)}"] = function(match) return os.getenv(match) or "" end,
}

for type, _ in pairs(dap.configurations) do
    for _, config in pairs(dap.configurations[type]) do
        if config.envFile then
            local filePath = config.envFile
            for key, fn in pairs(placeholders) do
                filePath = filePath:gsub(key, fn)
            end
            for line in io.lines(filePath) do
                local words = {}
                for word in string.gmatch(line, "[a-zA-Z0-9_]+") do
                    table.insert(words, word)
                end
                if not config.env then config.env = {} end
                config.env[words[1]] = words[2]
            end
        end
    end
end


dap.adapters.go = {
    type = "server",
    port = goPort,
    executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:" .. goPort },
    },
}


-- which-key labels
local wk = require("which-key")
wk.register({
	D = { name = "DAP"},
}, { prefix = "<leader>" })





-- commands
local commands = {
  ["debug_start"] = { function() require("dap").continue() end, desc = "Debugger: Start" },
  ["debug_stop"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" }, -- Shift+F5,
  ["debug_restart"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" }, -- Control+F5
  ["dubug_pause"] = { function() require("dap").pause() end, desc = "Debugger: Pause" },
  ["debug_breakpoint_toggle"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint" },
  ["debug_step_over"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over" },
  ["debug_stop_into"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into" },
  ["debug_setp_out"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out" }, -- Shift+F11
  ["debug_clear_breakpoints"] = { function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" },
  ["debug_continue"] = { function() require("dap").continue() end, desc = "Start/Continue (F5)" },
  ["debug_close"] = { function() require("dap").close() end, desc = "Close Session" },
  ["debug_terminate"] = { function() require("dap").terminate() end, desc = "Terminate Session (S-F5)" },
  ["debug_repl_toggle"] = { function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
  ["debug_ui"] = { function() require("dapui").toggle() end, desc = "Toggle Debugger UI" },
  ["debug_hover"] = { function() require("dap.ui.widgets").hover() end, desc = "Debugger Hover" },
}

-- leader mappings
local mappings = {
    ["<leader>D"] = false,
    ["<F5>"] = commands.debug_start,
    ["<F17>"] = commands.debug_stop,
    ["<F29>"] = commands.debug_restart,
    ["<F6>"] = commands.debug_pause,
    ["<F9>"] = commands.debug_breakpoint_toggle,
    ["<F10>"] = commands.debug_step_over,
    ["<F11>"] = commands.debug_step_into,
    ["<F23>"] = commands.debug_step_out,
    ["<leader>Db"] = commands.debug_breakpoint_toggle,
    ["<leader>DB"] = commands.debug_clear_breakpoints,
    ["<leader>Dc"] = commands.debug_start,
    ["<leader>Di"] = commands.debug_step_into,
    ["<leader>Do"] = commands.debug_step_over,
    ["<leader>DO"] = commands.debug_step_out,
    ["<leader>Dq"] = commands.debug_close,
    ["<leader>DQ"] = commands.debug_terminate,
    ["<leader>Dp"] = commands.debug_pause,
    ["<leader>Dr"] = commands.debug_restart,
    ["<leader>DR"] = commands.debug_repl_toggle,
    ["<leader>Du"] = commands.debug_ui,
    ["<leader>Dh"] = commands.debug_hover,
}

-- map keys
for k, v in pairs(mappings) do
	if v then
		vim.keymap.set('n', k, v[1], {desc=v["desc"]})
	end
end
