local utils = {
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
      vim.keymap.set("n", "<Leader>e", function()
        return require("oil").toggle_float(vim.fn.expand("%:p:h"), {
          preview = {
            horizontal = true,
          },
        })
      end, { desc = "Explorer Oil" })

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
    "selimacerbas/live-server.nvim",
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
  {
    "tpope/vim-sleuth",
    lazy = false,
  },
}

local markdown = {
  {
    "selimacerbas/markdown-preview.nvim",
    dependencies = { "selimacerbas/live-server.nvim" },
    cmd = { "MarkdownPreviewRefresh", "MarkdownPreview", "MarkdownPreviewStop" },
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreview<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      require("markdown_preview").setup({
        -- all optional; sane defaults shown
        instance_mode = "takeover", -- "takeover" (one tab) or "multi" (tab per instance)
        port = 0, -- 0 = auto (8421 for takeover, OS-assigned for multi)
        open_browser = true,
        default_theme = "dark", -- "dark" or "light"; initial preview theme
        debounce_ms = 300,
      })

      vim.cmd([[do FileType]])
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      checkbox = {
        enabled = false,
      },
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = require("render-markdown").get,
        set = require("render-markdown").set,
      }):map("<leader>um")
    end,
  },
}

return vim.list_extend(utils, markdown)
