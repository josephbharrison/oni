return {
    "stevearc/resession.nvim",
    enabled = vim.g.resession_enabled == true,
    opts = {
        buf_filter = function(bufnr) return require("astronvim.utils.buffer").is_valid(bufnr) end,
        tab_buf_filter = function(tabpage, bufnr) return vim.tbl_contains(vim.t[tabpage].bufs, bufnr) end,
        extensions = { astronvim = {} },
    },
}

