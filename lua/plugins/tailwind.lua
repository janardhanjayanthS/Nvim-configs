return {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim", -- Optional
        "neovim/nvim-lspconfig",         -- Optional
    },
    opts = {
        document_color = {
            enabled = true,
            kind = "inline", -- or "background"
        },
        conceal = {
            enabled = false,
        },
    },
    {
        'NvChad/nvim-colorizer.lua',  -- colorizer for tailwind etc
        opts = {
            user_default_options = {
                tailwind = true,
                kind = "inline",
            },
        },
    },
}


