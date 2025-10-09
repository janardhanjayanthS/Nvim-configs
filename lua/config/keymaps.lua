-- for clarification : https://www.youtube.com/watch?v=w7i4amO_zaE

vim.g.mapleader = " "                         -- leader = space
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- in normal mode : leader(from above) pv -> :Ex (to enter netrw)

-- These commands are used to move highlighted text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.keymap.set("n", "J", "mzJ`z") -- makes the cursor stay at start when using J.
-- stays the cursor at middle while half-page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Makes cursor stay in middle while searching for a word
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Restart LSP
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever : " p" for preserving p while pasting
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland : for pasting stuff in clipboard and using it elsewhere
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d") -- deleting with same above functions

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- for switching projects - Using TMUX
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quickfix List navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- search and replace the word under cursor
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })              -- make current file executable


-- reload Neovim Configuration
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

--
-- -- For Go programming language
-- vim.keymap.set( -- insert Go error handling vlock
--     "n",
--     "<leader>ee",
--     "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
-- )
--
-- vim.keymap.set( -- insert assert.Noerror - for testing
--     "n",
--     "<leader>ea",
--     "oassert.NoError(err, \"\")<Esc>F\";a"
-- )
--
-- vim.keymap.set( -- insert Go error handling block with log.Fatallf
--     "n",
--     "<leader>ef",
--     "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj"
-- )
--
-- vim.keymap.set( -- insert Go error handling block with .logger.Error
--     "n",
--     "<leader>el",
--     "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i"
-- )
