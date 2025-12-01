return {
	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP Completion
			"williamboman/mason.nvim", -- LSP Installer
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-buffer",
			"WhoIsSethDaniel/mason-tool-installer.nvim", -- auto installs linters, formatters, debuggers
		},

		config = function()
			-- Configure TypeScript/JavaScript LSP
			vim.lsp.config("ts_ls", {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = {
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
				},
				root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
			})

			-- Configure Tailwind CSS LSP
			vim.lsp.config("tailwindcss", {
				cmd = { "tailwindcss-language-server", "--stdio" },
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
				},
				root_markers = {
					"tailwind.config.js",
					"tailwind.config.ts",
					"package.json",
					".git",
				},
				settings = {},
			})

			-- Attach LSP keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
				callback = function(event)
					local opts = { buffer = event.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- takes to definition of function, variable, etc
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- shows the hover information of a variable
					vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts) -- serach for a symbol in entire workspace
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts) -- opens a floating window displaying diagnostics (error, warnings, hint)
					vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts) -- shows possible code actions that you can apply to current line
					vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts) -- shows all references to the symbol under the cursor in th code
					vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts) -- allows to rename the symbol under the cursor and automatically updates all references in the code
					vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts) -- show function signatures (return type, params) for the funtion under the cursor
				end,
			})

			-- LSP Capabilities for Completion
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Mason Setup
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"jdtls",
					"ts_ls",
					"lua_ls",
				}, -- Specify LSPs
				handlers = {
					function(server_name)
						if server_name ~= "jdtls" then
							-- Use vim.lsp.enable for simple server start
							vim.lsp.enable(server_name)
						end
					end,
					lua_ls = function()
						vim.lsp.config("lua_ls", {
							cmd = { "lua-language-server" },
							root_markers = {
								".luarc.json",
								".luarc.jsonc",
								".luacheckrc",
								".stylua.toml",
								"stylua.toml",
								"selene.toml",
								"selene.yml",
								".git",
							},
							settings = {
								Lua = {
									runtime = { version = "LuaJIT" },
									diagnostics = { globals = { "vim" } },
									workspace = {
										library = { vim.env.VIMRUNTIME },
									},
								},
							},
						})
						vim.lsp.enable("lua_ls")
					end,
				},
			})

			-- for additional packages for java using mason tool installer
			require("mason-tool-installer").setup({
				ensure_installed = {
					"java-debug-adapter",
					"java-test",
				},
			})

			vim.api.nvim_command("MasonToolsInstall")

			-- Enable the following language servers
			--
			-- Add any additional override configuration in the following tables. Available keys are:
			-- - cmd (table): Override the default command used to start the server
			-- - filetypes (table): Override the default list of associated filetypes for the server
			-- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			-- - settings (table): Override the default settings passed when initializing the server.
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								library = vim.api.nvim_get_runtime_file("", true),
							},
							diagnostics = {
								globals = { "vim" },
								disable = { "missing-fields" },
							},
							format = {
								enable = false,
							},
						},
					},
				},
				-- pylsp = {
				-- 	settings = {
				-- 		pylsp = {
				-- 			plugins = {
				--
				-- 				pyflakes = { enabled = false },
				-- 				pycodestyle = { enabled = false },
				-- 				autopep8 = { enabled = false },
				-- 				yapf = { enabled = false },
				-- 				mccabe = { enabled = false },
				-- 				pylsp_mypy = { enabled = false },
				-- 				pylsp_black = { enabled = false },
				-- 				pylsp_isort = { enabled = false },
				-- 				jedi_completion = {
				-- 					enabled = true,
				-- 					include_params = true,
				-- 					fuzzy = true,
				-- 				},
				-- 				jedi_definition = { enabled = true },
				-- 				jedi_references = { enabled = true },
				-- 				jedi_symbols = { enabled = true },
				-- 			},
				-- 			-- KEY ADDITION: Enable workspace scanning
				-- 			configurationSources = { "pycodestyle" },
				-- 		},
				-- 	},
				-- },
				basedpyright = {
					-- Config options: https://github.com/DetachHead/basedpyright/blob/main/docs/settings.md
					settings = {
						basedpyright = {
							disableOrganizeImports = true, -- Using Ruff's import organizer
							disableLanguageServices = false,
							analysis = {
								ignore = { "*" }, -- Ignore all files for analysis to exclusively use Ruff for linting
								typeCheckingMode = "basic",
								diagnosticMode = "workspace", -- analyse the entire workspace
								useLibraryCodeForTypes = true,
								autoImportCompletions = true, -- whether pyright offers auto-import completions
							},
						},
					},
				},
				ruff = {
					init_options = {
						settings = {
							-- Enable workspace diagnostics
							organizeImports = true,
							fixAll = true,
						},
					},
				},
				jsonls = {},
				sqlls = {},
				terraformls = {},
				yamlls = {},
				bashls = {},
				dockerls = {},
				docker_compose_language_service = {},
				-- tailwindcss = {},
				-- graphql = {},
				html = { filetypes = { "html", "twig", "hbs" } },
				-- cssls = {},
				-- ltex = {},
				-- texlab = {},
			}

			-- Ensure the servers and tools above are installed
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for server, cfg in pairs(servers) do
				-- For each LSP server (cfg), we merge:
				-- 1. A fresh empty table (to avoid mutating capabilities globally)
				-- 2. Your capabilities object with Neovim + cmp features
				-- 3. Any server-specific cfg.capabilities if defined in `servers`
				cfg.capabilities = vim.tbl_deep_extend("force", {}, lsp_capabilities, cfg.capabilities or {})

				vim.lsp.config(server, cfg)
				vim.lsp.enable(server)
			end
		end,
	},
	--
	-- Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip", -- Snippet Engine
			"saadparwaiz1/cmp_luasnip", -- LuaSnip Source for nvim-cmp
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		build = "make install_jsregexp",

		config = function()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({ -- Keymaps for auto complete
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select), -- ctrl + p : select previous item in completeion list
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select), -- ctrl + n : select next item in completeion list
					["<C-z>"] = cmp.mapping.confirm({ select = true }), -- ctrl + y : select current item in completeion list
					["<C-Space>"] = cmp.mapping.complete(), -- ctrl + space : trigger the completion popup manually
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
