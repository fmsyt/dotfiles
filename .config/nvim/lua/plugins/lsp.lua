---@type LazyRootSpec[]
local conf = {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "K", false },
            { "<Leader>ch", vim.lsp.buf.hover, desc = "Hover" },
            { "M", vim.lsp.buf.hover, desc = "Hover" },
            { "<F2>", vim.lsp.buf.rename, desc = "Rename" },
            { "<Leader>b[", "<Cmd>bprevious<CR>", desc = "Previous Buffer" },
            { "<Leader>b]", "<Cmd>bnext<CR>", desc = "Next Buffer" },
            {
              "gd",
              function()
                -- DO NOT RESUSE WINDOW
                require("telescope.builtin").lsp_definitions({ reuse_win = false })
              end,
              desc = "Goto Definition",
              has = "definition",
            },
          },
        },
      },
    },
  },
  {
    "davidmh/mdx.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "biome",
        "css-lsp",
        "intelephense",
        -- "mdx-analyzer",
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      format = {
        indent_size = 2,
      },

      servers = {
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        denols = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")(...)
          end,
        },
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern("package.json")(...)
          end,
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        html = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        -- marksman = {
        --   supported_filetypes = { "markdown", "md" },
        -- },
        -- mdx_analyzer = {
        --   single_file_support = true,
        --   supported_filetypes = { "mdx" },
        -- },
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      },
      phpactor = {
        enabled = vim.lsp == "phpactor",
        format = {
          indent_size = 4,
        },
      },

      -- NOTE: https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#initialisation-options
      intelephense = {
        enabled = vim.lsp == "intelephense",
        format = {
          indent_size = 4,
        },
      },
      setup = {},
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- disable linter on php
        php = {},
      },
    },
  },
}

return conf
