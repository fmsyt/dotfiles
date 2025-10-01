-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

local tab_size_map = {
  php = 4,
  go = 4,
  python = 4,
}

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("tabsize"),
  pattern = { "*" },
  callback = function()
    local size = 2

    if tab_size_map[vim.bo.filetype] then
      size = tab_size_map[vim.bo.filetype]
    end

    vim.opt.shiftwidth = size
    vim.opt.tabstop = size
    vim.opt.softtabstop = size
  end,
})
