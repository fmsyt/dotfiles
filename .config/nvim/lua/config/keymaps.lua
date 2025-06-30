-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- default keymaps
vim.api.nvim_set_keymap("n", "J", "5j", { noremap = true })
vim.api.nvim_set_keymap("n", "K", "5k", { noremap = true })
vim.api.nvim_set_keymap("n", "U", ":redo<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "*", "*N", { noremap = true, silent = true })

-- folke/flash.nvim
vim.keymap.del("n", "s")
