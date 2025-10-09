return {
    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",    -- LSP Completion
            "williamboman/mason.nvim", -- LSP Installer
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-buffer",
            'WhoIsSethDaniel/mason-tool-installer.nvim' -- auto installs linters, formatters, debuggers
        },

        config = function()
            local lsp_config = require('lspconfig')

            lsp_config.ts_ls.setup({
                filetypes = {
                    "javascript",
                    "typescript",
                    "javascriptreact",
                    "typescriptreact",
                }
            })

            lsp_config.tailwindcss.setup({
                cmd = { "tailwindcss-language-server", "--stdio" },
                filetypes = { 
                    "html", "css", "scss", "javascript", "javascriptreact",
                    "typescript", "typescriptreact", "vue"
                },
                root_dir = require('lspconfig').util.root_pattern(
                    "tailwind.config.js", "tailwind.config.ts", "package.json", ".git", "*.html"
                ),
                settings = {},
            })

            -- Attach LSP keymaps
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)   			    -- takes to definition of function, variable, etc
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)				        -- shows the hover information of a variable
                    vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)	-- serach for a symbol in entire workspace
                    vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)   	-- opens a floating window displaying diagnostics (error, warnings, hint)
                    vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)	  	-- shows possible code actions that you can apply to current line 
                    vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts) 		-- shows all references to the symbol under the cursor in th code
                    vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)		    -- allows to rename the symbol under the cursor and automatically updates all references in the code 
                    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts) 		    -- show function signatures (return type, params) for the funtion under the cursor
                end,
            })

            -- LSP Capabilities for Completion
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Mason Setup
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = { 'pyright', 'jdtls', 'ts_ls'}, 			-- Specify LSPs
                handlers = {
                    function(server_name)
                        if server_name ~= 'jdtls' then
                            require('lspconfig')[server_name].setup({
                                capabilities = lsp_capabilities,
                            })
                        end
                    end,
                    lua_ls = function()
                        require('lspconfig').lua_ls.setup({
                            capabilities = lsp_capabilities,
                            settings = {
                                Lua = {
                                    runtime = { version = 'LuaJIT' },
                                    diagnostics = { globals = { 'vim' } },
                                    workspace = {
                                        library = { vim.env.VIMRUNTIME },
                                    },
                                },
                            },
                        })
                    end,
                },
            })

            -- for additional packages for java using mason tool installer
            require('mason-tool-installer').setup({
                ensure_installed = {
                    'java-debug-adapter',
                    'java-test'
                }
            })

            vim.api.nvim_command('MasonToolsInstall')
        end,
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",          -- Snippet Engine
            "saadparwaiz1/cmp_luasnip",  -- LuaSnip Source for nvim-cmp
            { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
        },
        build = "make install_jsregexp",

        config = function()
            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({                       -- Keymaps for auto complete
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),   -- ctrl + p : select previous item in completeion list
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),   -- ctrl + n : select next item in completeion list
                    ['<C-z>'] = cmp.mapping.confirm({ select = true }),     -- ctrl + y : select current item in completeion list
                    ['<C-Space>'] = cmp.mapping.complete(),                 -- ctrl + space : trigger the completion popup manually
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                        { name = 'buffer' },
                    }),
            })
        end,
    },
}

