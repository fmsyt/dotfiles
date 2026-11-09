local function show_git_diff(base, group, current_buffer_filename)
  current_buffer_filename = current_buffer_filename or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")

  require("snacks.picker").git_diff({
    base = base,
    group = group,
    exclude = { "pnpm-lock.yaml", "package-lock.json", "*.lock" },

    ---@param a snacks.picker.Item
    ---@param b snacks.picker.Item
    ---@return boolean
    sort = function(a, b)
      -- 表示中のバッファが含まれる場合は、先頭に表示する
      local f1 = vim.fn.fnamemodify(a.file, ":p")
      local f2 = vim.fn.fnamemodify(b.file, ":p")

      if f1 == current_buffer_filename then
        return true
      elseif f2 == current_buffer_filename then
        return false
      end

      return a.idx < b.idx
    end,
  })
end

return {
  {
    "folke/noice.nvim",
    ---@module "noice"
    ---@param opts NoiceConfig
    opts = function(_, opts)
      opts.lsp = opts.lsp or {}
      opts.lsp.hover = opts.lsp.hover or {}

      -- これによって `vim.lsp.buf.hover()` を迂回していたので無効化
      opts.lsp.hover.enabled = false
    end,
  },
  {
    -- ファイルの現在位置を可視化してくれるプラグイン
    "petertriho/nvim-scrollbar",
    dependencies = {
      "lewis6991/gitsigns.nvim",
    },
    opts = function()
      local config = require("scrollbar.config").get()
      require("scrollbar").setup(config)
      require("scrollbar.handlers.gitsigns").setup()
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
    keys = {
      {
        "<leader>gd",
        function()
          show_git_diff("HEAD")
        end,
        desc = "Git Diff Modified",
      },
      {
        "<leader>gD",
        function()
          local current_buffer_filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")

          require("snacks.picker").git_branches({
            all = true,
            filter = {
              filter = function(item)
                return not item.current
              end,
            },
            confirm = function(picker, item)
              picker:close()
              if item and item.branch then
                vim.schedule(function()
                  show_git_diff(item.branch, true, current_buffer_filename)
                end)
              end
            end,
          })
        end,
        desc = "Git Diff Against Branch",
      },
    },
  },
}
