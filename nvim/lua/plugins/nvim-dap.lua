return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "wojciech-kulik/xcodebuild.nvim",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        local xcodebuild = require("xcodebuild.integrations.dap")
        -- TODO: change it to your local codelldb path
        local codelldbPath = os.getenv("HOME") .. ".vscode/extensions/vadimcn.vscode-lldb-1.10.0/adapter/codelldb"
        -- "/tools/codelldb-aarch64-darwin/extension/adapter/codelldb"
        xcodebuild.setup(codelldbPath)
        vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
        vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
        vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
        vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
        vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
        vim.keymap.set("n", "<leader>B", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
        vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })
    end,
}
