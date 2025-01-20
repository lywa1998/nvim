local M = {
    "olimorris/onedarkpro.nvim",
    lazy = false,   -- make sure load this during startup
    priority = 1000    -- make sure to load this before all the other start plugins
}


function M.config()
    require("onedarkpro").setup({
        options = {
            transparency = true
        }
    })
    vim.cmd("colorscheme onedark")
end

return M
