return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
        -- Telescope setup configuration (if needed)
        local builtin = require("telescope.builtin")

        -- Key mappings
        vim.keymap.set("n", "<leader>pf", builtin.find_files, {desc = "Telescope find files"})
        vim.keymap.set("n", "<C-g>", builtin.git_files, {desc = "Telescope Git files"})
        -- vim.keymap.set("n", "<leader>ps", function()
        --     builtin.grep_sting({ search = vim.fn.input('Grep >') }) end)
    end
}
