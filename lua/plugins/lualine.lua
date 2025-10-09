return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("lualine").setup({
            options = {
                theme = "onedark",
                -- Arrows :
                -- component_separators = { left = '', right = ''},
                -- section_separators = { left = '', right = ''},
                -- slant : 
                component_separators = {left='\u{e0b9}', right='\u{e0bb}'},
                section_separators = {left='\u{e0b8}', right='\u{e0ba}'},
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { { "branch", icon = "" } },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        })
    end,
}
