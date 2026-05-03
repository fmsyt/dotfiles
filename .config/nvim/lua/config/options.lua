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

-- 1. クリップボード設定（お好みで unnamedplus を追加）
vim.opt.clipboard = ""

-- 2. Paste（貼り付け）時にタイムアウトしないためのダミー関数
-- リモートに問い合わせず、自身のレジスタから返す
local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

-- 3. OSC 52 の設定
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}

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
