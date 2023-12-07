return {
    'crusj/bookmarks.nvim',
    branch = 'main',
    keys = {
        {"<tab><tab>", mode = {"n"}, desc = "Bookmarks"},
        {"<tab>b", mode = {"n"}, desc = "Add Bookmarks"},
        {"<tab>o", mode = {"n"}, desc = "Order Bookmarks"},
        {"<tab>d", mode = {"n"}, desc = "Delete Bookmark"},
    },
    dependencies = { 'nvim-web-devicons' },
    config = function()
        require("bookmarks").setup({
            keymap = {
                toggle = "<tab><tab>",
                add = "<tab>b",
                order = "<tab>o",
                delete_on_virt = "<tab>d",
            },
            preview_ratio = 0.40
        })
        require("telescope").load_extension("bookmarks")
    end
}
