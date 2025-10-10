return {
  { "savq/melange-nvim" },
  {
    "craftzdog/solarized-osaka.nvim",
    config = function()
      require("solarized-osaka").setup({
        transparent = true,
      })
    end,
  },
  {
    "ribru17/bamboo.nvim",
    config = function()
      require("bamboo").setup({
        transparent = true,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "solarized-osaka",
      colorscheme = "bamboo",
    },
  },
}
