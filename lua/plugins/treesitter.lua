-- Syntax highlighting
return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },  -- Lazy loading
	build = ":TSUpdate",  -- Ensure parsers up to date
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require('nvim-treesitter.configs')

		treesitter.setup({
			auto_install = true,  -- Automatically install parsers for missing languages
			sync_install = false,  -- Disable synchronous parser installation to avoid blocking
			-- Enable highlighting, indenting, auto-tagging based on tree-sitter
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			-- autotag = { enable = true },
			-- Parsers for specific languages
			ensure_installed = {
				'json',
				'javascript',
                'typescript',
                'tsx',
				'yaml',
				'html',
				'css',
				'markdown',
				'markdown_inline',
				'bash',
	 		    'lua',
				'vim',
				'dockerfile',
				'python',
				'gitignore',
				'c',
                'java',
			},
			ignore_install = {},
			-- Incremental and decremental selection (C-Space and BS)
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<C-Space>',
					node_incremental = '<C-Space>',
					scope_incremental = false,
					node_decremental = '<bs>',
				},
			},
		})
        -- Auto tag config
        require('nvim-ts-autotag').setup({
            opts = {
                -- Defaults
                enable_close = true, -- Auto close tags
                enable_rename = true, -- Auto rename pairs of tags
                enable_close_on_slash = false -- Auto close on trailing </
            },
            -- Also override individual filetype configs, these take priority.
            -- Empty by default, useful if one of the "opts" global settings
            -- doesn't work well in a specific filetype
            -- per_filetype = {
            --     ["html"] = {
            --         enable_close = false
            --     }
            -- }
        })
	end,
}
