local M = {
    "nvim-treesitter/nvim-treesitter",
}

function M.config()
    local treesitter = require "nvim-treesitter"
    local configs = require "nvim-treesitter.configs"

    configs.setup {
        ensure_installed = { "c", "cmake", "cpp", "go", "lua", "python", "rust" },

        highlight = {
            enable = true,
        },
        autopairs = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    }
end

return M
