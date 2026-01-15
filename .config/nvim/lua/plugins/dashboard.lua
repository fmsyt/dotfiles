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
      opts.theme = "doom" -- "hyper" | "doom"

      local path = vim.fn.stdpath("config") .. "/dashboard.txt"
      if not vim.fn.filereadable(path) then
        logo = string.rep("\n", 8) .. logo .. "\n\n"
        opts.config.header = vim.split(logo, "\n")

        return opts
      end

      logo = table.concat(vim.fn.readfile(path), "\n")

      -- ロゴの各行で最も長い行の長さを取得
      local file_width = 1
      for line in logo:gmatch("[^\n]+") do
        if #line > file_width then
          file_width = #line
        end
      end

      if vim.fn.executable("tte") then
        opts.preview = {
          command = 'command cat "' .. path .. '" | tte beams && sleep 30',
          file_path = "",
          file_width = file_width,
          file_height = 10,
        }
      elseif vim.fn.executable("lolcat") then
        opts.preview = {
          command = 'lolcat "' .. path .. '" && sleep 30',
          file_path = "",
          file_width = file_width,
          file_height = 10,
        }
      end

      return opts
    end,
  },
}
