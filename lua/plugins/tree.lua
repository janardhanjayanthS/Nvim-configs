return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            filters = {
                dotfiles = false,  -- Show hidden files (files starting with .)
                custom = {},       -- Remove any custom filters
                exclude = {},      -- Don't exclude anything
            },
            git = {
                enable = true,
                ignore = false,    -- Show files from .gitignore
            },
            renderer = {
                hidden_display = "all",  -- Show all hidden files
                indent_markers = {
                    enable = true,          -- turn on the lines
                    inline_arrows = false,  -- keep arrows at start of line
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        bottom = "─",
                        none = " ",
                    },
                },
            },
            view = {
                width = 35,
            },
        }

        -- Keymaps
        vim.keymap.set("n", "<leader>t", function() vim.cmd("NvimTreeToggle") end)
        vim.keymap.set("n", "<leader>to", function() vim.cmd("NvimTreeOpen") end)
        vim.keymap.set("n", "<leader>tc", function() vim.cmd("NvimTreeClose") end)
        vim.keymap.set("n", "<leader>tf", function() vim.cmd("NvimTreeFocus") end)
        vim.keymap.set("n", "<leader>tF", function() vim.cmd("NvimTreeFindFile") end)
    end,
}
