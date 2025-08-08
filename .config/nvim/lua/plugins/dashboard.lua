-- $ toilet -f ivrit 'NEOVIM'
local logo = [[
 _   _ _____ _____     _____ __  __
| \ | | ____/ _ \ \   / /_ _|  \/  |
|  \| |  _|| | | \ \ / / | || |\/| |
| |\  | |__| |_| |\ V /  | || |  | |
|_| \_|_____\___/  \_/  |___|_|  |_|
]]

return {
  {
    "nvimdev/dashboard-nvim",
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    opts = function(_, opts)
      opts = opts or {}

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      opts.theme = "doom"
      opts.config.header = vim.split(logo, "\n")

      return opts
    end,
  },
}
