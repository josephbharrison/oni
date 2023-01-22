return {
    "neovim/nvim-lspconfig",
    config = function()
        require('lspconfig').yamlls.setup {
            settings = {
                yaml = {
                    keyOrdering = false,
                    schemas = {
                        ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
                    },
                },
            }
        }
    end
}
