return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "I", vim.lsp.buf.hover, desc = "Hover" }
    end,
  },
}
