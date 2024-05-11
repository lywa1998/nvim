local M = {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
}

function M.config()
    require("toggleterm").setup {
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 1,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
    }

    function CountTerms()
        local buffers = vim.api.nvim_list_bufs()
        local terminal_count = 0

        for _, buf in ipairs(buffers) do
            if vim.bo[buf].buftype == "terminal" then
                terminal_count = terminal_count + 1
            end
        end

        return terminal_count
    end

    vim.keymap.set("n", "<leader>tn", function()
        local command = CountTerms() + 1 .. "ToggleTerm"
        vim.cmd(command)
    end, { noremap = true, silent = true, desc = "New Terminal" })

    vim.keymap.set("n", "<leader>tq", function()
        if CountTerms() == 0 then
            return
        end
        vim.api.nvim_win_close(vim.api.nvim_get_current_win(), false)
    end, { noremap = true, silent = true, desc = "Quit current Terminal" })

    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "t -> n" })
end

return M
