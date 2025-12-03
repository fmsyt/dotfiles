-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local n = { noremap = true }
local ns = { noremap = true, silent = true }

-- common
vim.keymap.set("n", "r", "cl", ns) -- as s
vim.keymap.set("n", "J", "5j", ns)
vim.keymap.set("n", "K", "5k", ns)
vim.keymap.set("n", "U", ":redo<CR>", n)
vim.keymap.set("n", "*", "*N", ns)

-- window
vim.keymap.set("n", "ss", ":split<CR>", n)
vim.keymap.set("n", "sv", ":vsplit<CR>", n)
vim.keymap.set("n", "sc", ":close<CR>", n)
vim.keymap.set("n", "sh", "<C-w>h", ns)
vim.keymap.set("n", "sj", "<C-w>j", ns)
vim.keymap.set("n", "sk", "<C-w>k", ns)
vim.keymap.set("n", "sl", "<C-w>l", ns)

-- commands
vim.keymap.set("c", "Q", "qa", n)

vim.keymap.set("n", "<ScrollWheelUp>", "2<C-Y>", ns)
vim.keymap.set("n", "<ScrollWheelDown>", "2<C-E>", ns)
vim.keymap.set("i", "<ScrollWheelUp>", "<C-O>2<C-Y>", ns)
vim.keymap.set("i", "<ScrollWheelDown>", "<C-O>2<C-E>", ns)
vim.keymap.set("v", "<ScrollWheelUp>", "2<C-Y>", ns)
vim.keymap.set("v", "<ScrollWheelDown>", "2<C-E>", ns)

if vim.env.SSH_CLIENT then
  vim.keymap.set("v", "<leader> y", '"+y', ns)
end
