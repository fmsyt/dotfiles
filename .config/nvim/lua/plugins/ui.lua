return {
  {
    -- ファイルの現在位置を可視化してくれるプラグイン
    "petertriho/nvim-scrollbar",
    opts = function()
      require("scrollbar").setup()
    end,
  },
  {
    "snacks.nvim",
    opts = function(_, opts)
      local ssh_client = os.getenv("SSH_CLIENT")
      if not ssh_client then
        opts.scroll.enabled = true
        return
      end

      local disable_hosts = vim.g.snacks_disable_scroll_hosts or {}
      local ssh_host = vim.split(ssh_client, " ")[1]

      for _, host in ipairs(disable_hosts) do
        if ssh_host == host then
          opts.scroll.enabled = false
          return
        end
      end

      opts.scroll.enabled = true
    end,
  },
}
