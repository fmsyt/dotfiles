local M = {}

---@return boolean
M.animation_disabled = function()
  local ssh_client = os.getenv("SSH_CLIENT")
  if not ssh_client then
    return false
  end

  local disable_hosts = vim.g.snacks_disable_scroll_hosts or {}
  local ssh_host = vim.split(ssh_client, " ")[1]

  for _, host in ipairs(disable_hosts) do
    if ssh_host == host then
      vim.notify("Animations disabled for host: " .. host, vim.log.levels.INFO)
      return true
    end
  end

  return false
end

return M
