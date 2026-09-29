local M = {}

--- `snacks.nvim` などのアニメーション機能を利用するかどうか
--- @see vim.g.snacks_disable_scroll_hosts
--- @return boolean
M.animation_disabled = function()
  local ssh_client = os.getenv("SSH_CLIENT")
  if not ssh_client then
    return false
  end

  return true
end

return M
