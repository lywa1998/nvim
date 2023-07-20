local M = {
    "folke/flash.nvim",
    event = "VeryLazy",
}

function M.config()
    require("flash").setup()
    vim.keymap.set({"n","x","o"},"s",
        function()
            require("flash").jump({
                search = {
                    mode = function(str)
                        return "\\<" .. str
                    end,
                },
            })
        end
    )
    vim.keymap.set({"n","x","o"},"S",
        function()
            require("flash").treesitter()
        end
    )
    vim.keymap.set({"o"},"r",
        function()
            require("flash").remote()
        end
    )
    vim.keymap.set({"o","x"},"R",
        function()
            require("flash").treesitter_search()
        end
    )
end

return M
