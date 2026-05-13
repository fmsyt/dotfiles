return {
  {
    -- ファイルの現在位置を可視化してくれるプラグイン
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      --- @type dap.Configuration[]
      local php_configurations = {}

      local xdebug_config = os.getenv("XDEBUG_CONFIG") or ""
      if xdebug_config ~= "" then
        local host = xdebug_config:match("client_host=([^%s;]+)") or "127.0.0.1"

        --- @type string
        local idekey = xdebug_config:match("idekey=([^%s;]+)") or "motsuni"
        --- @type number
        local client_port = tonumber(xdebug_config:match("client_port=(%d+)")) or 9003

        vim.list_extend(php_configurations, {
          {
            type = "php",
            request = "launch",
            name = "Listen for XDebug via DBGp",
            port = 9004,
            proxy = {
              host = host,
              port = client_port,
              key = idekey .. "-neovim",
            },
          },
        })
      end

      dap.configurations.php = php_configurations
    end,
  },
}
