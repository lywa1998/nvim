local M = {
  "nvim-lualine/lualine.nvim",
  event = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
}

function M.config()
    require("lualine").setup({
        options = {
            theme = "onedark",
        },
    })
end

return M
