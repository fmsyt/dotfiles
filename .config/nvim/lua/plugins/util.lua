return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup({
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
        },
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
  {
    "stevearc/overseer.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.output = {
        use_terminal = true,
      }
    end,
  },
  {
    "barrettruth/live-server.nvim",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      local events = require("neo-tree.events")

      opts = opts or {}
      opts.event_handlers = opts.event_handlers or {}

      vim.list_extend(opts.event_handlers, {
        {
          event = events.FILE_OPENED,
          handler = function(_file_path)
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      })
    end,
  },
}
