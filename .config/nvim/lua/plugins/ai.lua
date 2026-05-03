---@type LazyRootSpec[]
local conf = {
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    opts = function(_, opts) end,
  },

  {
    "Exafunction/codeium.nvim",
    enabled = false,
  },
}

return conf
