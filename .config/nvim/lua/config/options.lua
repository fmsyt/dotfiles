-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--- @type "phpactor" | "intelephense"
vim.g.lazyvim_php_lsp = "intelephense"

--- @type "codeium" | "copilot"
vim.g.ai_agent = "codeium"

--- `snacks.nvim` のスクロール機能を無効にするIPアドレス
--- @type string[]
vim.g.snacks_disable_scroll_hosts = {}

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
