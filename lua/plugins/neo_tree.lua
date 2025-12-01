return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			close_if_last_window = false,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			default_component_configs = {
				indent = {
					indent_size = 2,
					padding = 1,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					default = "*",
				},
				git_status = {
					symbols = {
						added = "✚",
						modified = "",
						deleted = "✖",
						renamed = "➜",
						untracked = "★",
						ignored = "◌",
						unstaged = "✗",
						staged = "✓",
						conflict = "",
					},
				},
			},
			window = {
				position = "left",
				width = 35,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
			},
			filesystem = {
				filtered_items = {
					visible = true, -- Show hidden files
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false, -- only works on Windows for hidden files/directories
				},
				follow_current_file = {
					enabled = false,
				},
				use_libuv_file_watcher = true,
			},
		})

		-- Keymaps matching your nvim-tree setup
		vim.keymap.set("n", "<leader>t", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })
		vim.keymap.set("n", "<leader>to", "<cmd>Neotree show<cr>", { desc = "Open Neo-tree" })
		vim.keymap.set("n", "<leader>tc", "<cmd>Neotree close<cr>", { desc = "Close Neo-tree" })
		vim.keymap.set("n", "<leader>tf", "<cmd>Neotree focus<cr>", { desc = "Focus Neo-tree" })
		vim.keymap.set("n", "<leader>tF", "<cmd>Neotree reveal<cr>", { desc = "Find file in Neo-tree" })
	end,
}
