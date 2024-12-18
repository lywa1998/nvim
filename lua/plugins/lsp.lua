local M = {
    "neovim/nvim-lspconfig",
    version = "0.1.8",
    lazy = false,
    event = { BufReadPre },
    dependencies = {
        'saghen/blink.cmp',
        -- "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    }
}


function M.config()
    local servers = {
        lua_ls = {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {'vim'}
                    }
                }
            }
        },
        gopls = {},
        pyright = {},
        clangd = {},
        tinymist = {
            --- todo: these configuration from lspconfig maybe broken
            single_file_support = true,
            root_dir = function()
                return vim.fn.getcwd()
            end,
            --- See [Tinymist Server Configuration](https://github.com/Myriad-Dreamin/tinymist/blob/main/Configuration.md) for references.
            settings = {
                formatterMode = "typstyle"
            }
        }
    }
    require("mason").setup()
    require("mason-lspconfig").setup {
        ensure_installed = vim.tbl_keys(servers),
    }

    for server, config in pairs(servers) do
        require("lspconfig")[server].setup(
            vim.tbl_deep_extend(
                "keep",
                { on_attach = on_attach, capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities) },
                config
            )
        )
    end

    -- Autocmds are automatically loaded on the VeryLazy event
    -- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
    -- Add any additional autocmds here
    vim.api.nvim_create_autocmd(
        {
            "BufNewFile",
            "BufRead",
        },
        {
            pattern = "*.typ",
            callback = function()
                local buf = vim.api.nvim_get_current_buf()
                vim.api.nvim_set_option_value("filetype", "typst", buf)
            end
        }
    )

    -- Enable lsconfig --
    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(args)
            -- Enable lsp completion
            -- vim.lsp.completion.enable(true, args.data.client_id, args.buf, {autotrigger=true})
            -- Enable native inlay hints
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

            -- Enable completion triggered by <c-x><c-o>
            vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = args.buf }
            -- We need a specific threat for the "term_toggle", it must be a global mapping, not a buffer mapping.
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', require "telescope.builtin".lsp_definitions, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<leader>gi', require "telescope.builtin".lsp_implementations, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

            -- diagnostic
            vim.keymap.set('n', '<leader>ds', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages'})
            vim.keymap.set('n', '<leader>dl', require "telescope.builtin".diagnostics, opts)

            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', 'gr', require "telescope.builtin".lsp_references, opts)
            vim.keymap.set('n', '<space>f', vim.lsp.buf.format, opts) -- format code
        end,
    })
end

return M
