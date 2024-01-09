local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
}

function M.config()
    local configs = require "nvim-treesitter.configs"

    configs.setup {
        ensure_installed = { "cpp", "vim", "vimdoc", "go", "lua", "rust" },

        highlight = { enable = true },
        autopairs = { enable = true },
        indent = { enable = true },
    }
end

return M
