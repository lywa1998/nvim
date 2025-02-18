local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-project.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' }
    },
    config = function()
        require("telescope").setup {
            defaults = {
                file_ignore_patterns = { "node_modules", "target", ".git", ".cargo", ".rustup", ".venv", ".config", ".vim" },
            },
            extensions = {
                project = {
                    base_dirs = {
                        { '~/.config/nvim' },               -- neovim configuration
                        -- { '~/Github', max_depth = 2 },      -- github project
                        -- { '~/Project', max_depth = 2 },     -- personal project
                    },
                    hidden_files = true,
                    order_by = "recent",
                    search_by = "title",
                    sync_with_nvim_tree = true,
                },
                fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            }
        }

        require("telescope").load_extension("fzf")
        require("telescope").load_extension("project")

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader><space>', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fp', ":lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>", { noremap = true, silent = true})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
}

return M
