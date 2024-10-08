local M = {
    "akinsho/bufferline.nvim",
    branch = 'main',
    dependencies = { { "famiu/bufdelete.nvim"}, },
}

function M.config()
    require("bufferline").setup {
        options = {
            offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        },
    }
end

return M
