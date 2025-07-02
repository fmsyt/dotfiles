-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local ns = {
  noremap = true,
  silent = true,
}

-- common
vim.keymap.set("n", "J", "5j", ns)
vim.keymap.set("n", "K", "5k", ns)
vim.keymap.set("n", "U", ":redo<CR>", ns)
vim.keymap.set("n", "*", "*N", ns)

vim.keymap.set("n", "<leader>q", ":q<CR>", ns)

-- folke/flash.nvim
vim.keymap.del("n", "s")

-- window
vim.keymap.set("n", "ss", ":split<CR>", ns)
vim.keymap.set("n", "sv", ":vsplit<CR>", ns)
vim.keymap.set("n", "<C-\\>", ":vsplit<CR>", ns)
vim.keymap.set("n", "sc", ":close<CR>", ns)
vim.keymap.set("n", "gh", "<C-w>h", ns)
vim.keymap.set("n", "gj", "<C-w>j", ns)
vim.keymap.set("n", "gk", "<C-w>k", ns)
vim.keymap.set("n", "gl", "<C-w>l", ns)
