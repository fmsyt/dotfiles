return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git", "target", "build" },
        },
      })
    end,
  },
  {
    -- テキストを編集するようにファイルを操作できるプラグイン
    "stevearc/oil.nvim",

    ---@param opts oil.SetupOpts
    opts = function(_, opts)
      vim.keymap.set("n", "<Leader>r", function()
        return require("oil").toggle_float(vim.fn.expand("%:p:h"))
      end, { desc = "Open parent directory in Oil" })

      opts.view_options = opts.view_options or {}
      opts.view_options.show_hidden = true

      opts.float = opts.float or {}
      opts.float.border = "rounded"

      return opts
    end,
  },
}
