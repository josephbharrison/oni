-- ~/.config/nvim/lua/utils.lua
local M = {}

function M.is_helm_file(path)
    local check = vim.fs.find("Chart.yaml", { path = vim.fs.dirname(path), upward = true })
    return not vim.tbl_isempty(check)
end

function M.yaml_filetype(path, bufname)
    return M.is_helm_file(path) and "helm.yaml" or "yaml"
end

function M.tmpl_filetype(path, bufname)
    return M.is_helm_file(path) and "helm.tmpl" or "template"
end

function M.tpl_filetype(path, bufname)
    return M.is_helm_file(path) and "helm.tmpl" or "smarty"
end

return M
