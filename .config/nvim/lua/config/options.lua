-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.g.lazyvim_php_lsp = "phpactor"
vim.g.lazyvim_php_lsp = "intelephense"

-- ./local.lua があれば読み込み

local has_local = pcall(require, "config.local")
if has_local then
  require("config.local")
end

if vim.fn.has("win32") == 1 then
  vim.opt.shell = "powershell.exe"
  if vim.fn.executable("pwsh.exe") == 1 then
    vim.opt.shell = "pwsh.exe"
  end
end
