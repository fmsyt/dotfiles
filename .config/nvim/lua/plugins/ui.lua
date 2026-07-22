return {
  {
    -- ファイルの現在位置を可視化してくれるプラグイン
    "petertriho/nvim-scrollbar",
    opts = function()
      require("scrollbar").setup()
    end,
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.lazygit = opts.lazygit or {}
      opts.lazygit.configure = true
      opts.lazygit.config = vim.tbl_deep_extend("force", opts.lazygit.config or {}, {
        os = {
          editPreset = "nvim-remote",
        },
      })

      local utils = require("utils")
      opts.scroll.enabled = utils.animation_disabled() ~= true
    end,
  },
}
