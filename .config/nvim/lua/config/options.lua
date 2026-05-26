-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--- @type "phpactor" | "intelephense"
vim.g.lazyvim_php_lsp = "intelephense"

--- @type "codeium" | "copilot"
vim.g.ai_agent = "copilot"

--- `snacks.nvim` のスクロール機能を無効にするIPアドレス
--- @type string[]
vim.g.snacks_disable_scroll_hosts = {}

vim.opt.clipboard = ""

--- @see [OSC 52 による Neovim とクリップボードの連携](https://zenn.dev/goropikari/articles/506e08e7ad52af)
local function apply_osc52_settings()
  -- Paste時にタイムアウトしないためのダミー関数
  -- リモートに問い合わせず、自身のレジスタから返す
  local function paste()
    return {
      vim.fn.split(vim.fn.getreg(""), "\n"),
      vim.fn.getregtype(""),
    }
  end

  -- OSC 52 の設定
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
end

apply_osc52_settings()

-- ./local.lua があれば読み込み
local has_local = pcall(require, "config.local")
if has_local then
  require("config.local")
end

-- === POST-LOCAL SETTINGS ===

local default_disable_auto_format_excludes = vim.g.default_disable_auto_format_excludes or {}
for _, pattern in ipairs(default_disable_auto_format_excludes) do
  vim.api.nvim_create_autocmd("BufRead", {
    pattern = pattern,
    callback = function()
      vim.b.autoformat = false
      vim.notify("Auto Format is disabled for this file", vim.log.levels.INFO, { title = "Auth Format" })
    end,
  })
end

if vim.fn.has("win32") == 1 then
  vim.opt.shell = "powershell.exe"
  if vim.fn.executable("pwsh.exe") == 1 then
    vim.opt.shell = "pwsh.exe"
  end
end
