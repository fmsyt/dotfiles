--- @type LazyRootSpec[]
local conf = {
  {
    "zbirenbaum/copilot.lua",
    enabled = vim.g.ai_agent == "copilot",
  },
  {
    "Exafunction/codeium.nvim",
    enabled = vim.g.ai_agent == "codeium",
  },
}

return conf
