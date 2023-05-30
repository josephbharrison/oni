local randPort = function()
    local port = math.random(30000, 40000)
    return port
end

local goPort = randPort()

vim.api.nvim_set_hl(0, "Comment", { italic = true })

-- Global DAP Setup
local dap = require "dap"
require("dap.ext.vscode").load_launchjs()

-- Adapters
dap.adapters.go = { -- go adapter
    type = "server",
    port = goPort,
    executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:" .. goPort },
    },
}
dap.adapters.python = { -- python adapter
    type = "executable",
    command = os.getenv("HOME") .. "/.pyenv/versions/debugpy/bin/python",
    args = { "-m", "debugpy.adapter" },
}

-- Configurations
dap.configurations.go = { -- go configuration
    {
        type = 'go',
        name = 'Debug Current File',
        request = 'launch',
        program = '${file}',
    },
    {
        type = 'go',
        name = 'Attach to Running Process...',
        request = 'attach',
        processId = function() require('dap.utils').pick_process(); end
    },
}
dap.configurations.python = { -- python configuration
	{
		type = "python",
		request = "launch",
		name = "Debug Current File",
		program = "${file}",
		pythonPath = function()
			local venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return venv .. "/bin/python"
			else
				return "/usr/bin/python"
			end
		end,
	},
	{
		type = "python",
		request = "attach",
		name = "Attach to remote process...",
		connect = {
			host = function()
				return vim.fn.input("Host: ")
			end,
			port = function()
				return vim.fn.input("Port: ")
			end,
		},
		mode = "remote",
		pythonPath = function()
			local venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return venv .. "/bin/python"
			else
				return "/usr/bin/python"
			end
		end,
	},
}

local function all_trim(s)
	return s:match("^%s*(.-)%s*$")
end

-- Breakpoint def
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error" })

-- Add pythonPath to user defined configurations
for _, config in pairs(dap.configurations.python) do
    if not config.pythonPath then
        config.pythonPath = function()
            local venv = os.getenv("VIRTUAL_ENV")
            if venv then
                return venv .. "/bin/python"
            else
                return "/usr/bin/python"
            end
        end
    end
end

-- Add dlvFlags for go configs
for _, config in pairs(dap.configurations.go) do
    if not config.dlvFlags then
        config.dlvFlags = {
            "--output",
            "__debug_bin_" .. config.name:gsub(" ", "_"),
        }
    end
end

-- Placeholder expansion for launch directives
local placeholders = { 
    ["${file}"] = function(_) return vim.fn.expand("%:p") end,
    ["${fileBasename}"] = function(_) return vim.fn.expand("%:t") end,
    ["${fileBasenameNoExtension}"] = function(_) return vim.fn.fnamemodify(vim.fn.expand("%:t"), ":r") end,
    ["${fileDirname}"] = function(_) return vim.fn.expand("%:p:h") end,
    ["${fileExtname}"] = function(_) return vim.fn.expand("%:e") end,
    ["${relativeFile}"] = function(_) return vim.fn.expand("%:.") end,
    ["${relativeFileDirname}"] = function(_) return vim.fn.fnamemodify(vim.fn.expand("%:.:h"), ":r") end,
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
            -- Verify file exists
            local f = io.open(filePath, "r")
            if f ~= nil then
                for line in io.lines(filePath) do
                    local words = {}
                    for word in string.gmatch(line, "[^=]+") do
                        table.insert(words, all_trim(word))
                    end
                    if not config.env then
                        config.env = {}
                    end
                    config.env[words[1]] = words[2]
                end
            end
        end
    end
end

-- which-key labels
local wk = require("which-key")
wk.register({
	D = { name = "DAP"},
}, { prefix = "<leader>" })


-- commands
local commands = {
  ["debug_start"] = { function() require("dap").continue() end, desc = "Debugger: Start (F5)" },
  ["debug_stop"] = { function() require("dap").terminate() end, desc = "Debugger: Stop (Shift+F5)" }, -- Shift+F5,
  ["debug_restart"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart (Ctrl+F5)" }, -- Control+F5
  ["dubug_pause"] = { function() require("dap").pause() end, desc = "Debugger: Pause" },
  ["debug_breakpoint_toggle"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint" },
  ["debug_step_over"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over" },
  ["debug_stop_into"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into" },
  ["debug_setp_out"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out (Shift+F11)" }, -- Shift+F11
  ["debug_clear_breakpoints"] = { function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" },
  ["debug_close"] = { function() require("dap").close() end, desc = "Close Session" },
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
    ["<leader>DQ"] = commands.debug_stop,
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
