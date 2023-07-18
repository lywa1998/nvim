local M = {
    "folke/tokyonight.nvim",
    lazy = false,   -- make sure load this during startup
    priority = 1000,    -- make sure to load this before all the other start plugins
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
}


function M.config()
    vim.cmd[[colorscheme tokyonight-night]]
end

return M
