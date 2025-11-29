vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- tab space of 2 for html and css files
local set_indent = vim.api.nvim_create_augroup("set_indent", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"html", "css" },  -- filetypes
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.expandtab = true
    end,
    group = set_indent,
})


vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false    -- highlights search
vim.opt.incsearch = true    -- increamental search

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

-- cursor
vim.o.guicursor = "i:block-blinkwait700-blinkon400-blinkoff250"

-- autosave
vim.opt.autowrite = true
vim.opt.autowriteall = true
