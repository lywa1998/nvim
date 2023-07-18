local M = {
    "kyazdani42/nvim-tree.lua",
    event = "VimEnter",
}

function M.config()
    require("nvim-tree").setup {
        sort_by = "case_sensitive",
        view = {
            width = 30,
            side = "left",
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
    }
end

return M
