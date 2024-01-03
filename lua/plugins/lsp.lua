local M = {
    "neovim/nvim-lspconfig",
    lazy = false,
    event = { BufReadPre },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate",
        },
        "williamboman/mason-lspconfig.nvim"
    }
}

function M.config()
    local servers = {
        lua_ls = {},
        -- rust_analyzer = {},
        gopls = {},
        typst_lsp = {
            settings = {
                exportPdf = "onType"
            }
        },
        pyright = {},
        clangd = {},
    }
    require("mason").setup()
    require("mason-lspconfig").setup {
        ensure_installed = vim.tbl_keys(servers),
    }

    for server, config in pairs(servers) do
        require("lspconfig")[server].setup(
            vim.tbl_deep_extend(
                "keep",
                { on_attach = on_attach, capabilities = require("cmp_nvim_lsp").default_capabilities() },
                config
            )
        )
    end

    -- Enable lsconfig --
    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            -- We need a specific threat for the "term_toggle", it must be a global mapping, not a buffer mapping.
            vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>",
                { noremap = true, silent = true })
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', require "telescope.builtin".lsp_definitions, opts)
            vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
            vim.keymap.set('n', 'K', "<cmd>Lspsaga hover_doc<CR>", opts)
            vim.keymap.set('n', '<leader>gi', require "telescope.builtin".lsp_implementations, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>da', require "telescope.builtin".diagnostics, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', "<cmd>Lspsaga rename ++project<CR>", opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', "<cmd>Lspsaga code_action<CR>", opts)
            vim.keymap.set('n', 'gr', require "telescope.builtin".lsp_references, opts)
            -- vim.keymap.set('n', '<space>f', function()
            --     vim.lsp.buf.format { async = true }
            -- end, opts)
        end,
    })
--     local cmp_nvim_lsp = require "cmp_nvim_lsp"
--
--     local capabilities = vim.lsp.protocol.make_client_capabilities()
--     capabilities.textDocument.completion.completionItem.snippetSupport = true
--     capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
--
--     local function lsp_keymaps(bufnr)
--         local opts = { noremap = true, silent = true }
--         local keymap = vim.api.nvim_buf_set_keymap
--         keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--         keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--         keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--         keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--         keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--         keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
--         keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
--         keymap(bufnr, "n", "<leader>lI", "<cmd>Mason<cr>", opts)
--         keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
--         keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
--         keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
--         keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
--         keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
--         keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
--     end
--
--     local lspconfig = require "lspconfig"
--     local on_attach = function(client, bufnr)
--         lsp_keymaps(bufnr)
--         require("illuminate").on_attach(client)
--     end
--
--     for _, server in pairs(require("utils").servers) do
--         Opts = {
--             on_attach = on_attach,
--             capabilities = capabilities,
--         }
--
--         server = vim.split(server, "@")[1]
--
--         local require_ok, conf_opts = pcall(require, "settings." .. server)
--         if require_ok then
--             Opts = vim.tbl_deep_extend("force", conf_opts, Opts)
--         end
--
--     lspconfig[server].setup(Opts)
--     end
--
--     local signs = {
--         { name = "DiagnosticSignError", text = "" },
--         { name = "DiagnosticSignWarn", text = "" },
--         { name = "DiagnosticSignHint", text = "" },
--         { name = "DiagnosticSignInfo", text = "" },
--     }
--
--     for _, sign in ipairs(signs) do
--         vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
--     end
--
--     local config = {
--         -- disable virtual text
--         virtual_text = false,
--         -- show signs
--         signs = {
--             active = signs,
--         },
--         update_in_insert = true,
--         underline = true,
--         severity_sort = true,
--         float = {
--             focusable = false,
--             style = "minimal",
--             border = "rounded",
--             source = "always",
--             header = "",
--             prefix = "",
--             suffix = "",
--         },
--     }
--
--     vim.diagnostic.config(config)
--
--     vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--         border = "rounded",
--     })
--
--     vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--         border = "rounded",
--     })
end    

return M
