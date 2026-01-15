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
      local utils = require("utils")
      opts.scroll.enabled = utils.animation_disabled() ~= true
    end,
  },
}
