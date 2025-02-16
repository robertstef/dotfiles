return {
    -- autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-buffer', -- source for in text buffer
            'hrsh7th/cmp-path', -- source for file system paths
            'L3MON4D3/LuaSnip', -- snippet engine
            'saadparwaiz1/cmp_luasnip', -- for autocompletion
            'rafamadriz/friendly-snippets', -- useful snippets
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            -- loads vscode style snippets from installed plugins (.e.g. friendly-snippets)
            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
                completion = {
                    completeopt = 'menu,menuone,preview,noselect',
                },
                snippet = { -- configure how nvim-cmp interacts with snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-k>'] = cmp.mapping.select_prev_item(), -- prev suggestion
                    ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-space>'] = cmp.mapping.complete(), -- show completion suggestions
                    ['<C-e>'] = cmp.mapping.abort(), -- close completion window
                    ['<CR>'] = cmp.mapping.confirm({ select = false })
                }),
                -- sources for autocompletion (order determines priority)
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' }, -- lsp
                    { name = 'luasnip' }, -- snippets
                    { name = 'buffer' }, -- text within current buffer
                    { name = 'path' }, -- files system paths
                }),
            })
        end,
    },

    -- LSP SETUP

    -- Mason
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            local mason = require('mason')
            local mason_lspconfig = require('mason-lspconfig')
            mason.setup({
                ui = {
                    icons = {
                        package_installed = '✓',
                        package_pending = '➜',
                        package_uninstalled = '✗',
                    },
                },
            })

            mason_lspconfig.setup({
                ensure_installed = {
                    'clangd',
                    'bashls',
                    'jedi_language_server',
                    'lua_ls',
                    'ruff',
                    'debugpy'
                },

                -- auto-install configured servers
                automatic_installation = true,
            })
        end,
    },

    -- lspconfig
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BuFNewFile'},
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            {'antosha417/nvim-lsp-file-operations', config = true },

        },
        config = function()
            local lspconfig = require('lspconfig')
            local cmp_nvim_lsp = require('cmp_nvim_lsp')
            local keymap = vim.keymap
            local opts = {noremap = true, silent = true}
            local on_attach = function(client, bufnr)
                opts.buffer = bufnr

                -- set keybindings
                opts.desc = 'Show LSP references'
                keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)

                opts.desc = 'Go to declaration'
                keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

                opts.desc = 'Show LSP definitions'
                keymap.set('n', 'gR', '<cmd>Telescope lsp_definitions<CR>', opts)

                opts.desc = 'Show LSP implementations'
                keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

                opts.desc = 'Show LSP type definitions'
                keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

                opts.desc = 'See available code actions'
                keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts)

                opts.desc = 'Smart rename'
                keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

                opts.desc = 'Show buffer diagnostics'
                keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

                opts.desc = 'Show line diagnostics'
                keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

                opts.desc = 'Go to previous diagnostic'
                keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

                opts.desc = 'Go to next diagnostic'
                keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

                opts.desc = 'Show documentation for what is under cursor'
                keymap.set('n', 'K', vim.lsp.buf.hover, opts)

                opts.desc = 'Restart LSP'
                keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts)
            end

            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- Change the diagnostic symbols in gutter
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " "}
            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
            end

            lspconfig['jedi_language_server'].setup({
                capabilities = capabilities,
                on_attach = on_attach
            })
            lspconfig['ruff'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig['clangd'].setup({
                capabilities = capabilities,
                on_attach = on_attach
            })

            lspconfig['lua_ls'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        diagnostics = { globals = { 'vim' } }
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.stdpath('config') .. '/lua'] = true
                        }
                    }
                },
            })

            lspconfig['bashls'].setup({
                capabilities = capabilities,
                on_attach = on_attach
            })
        end
    }
}
