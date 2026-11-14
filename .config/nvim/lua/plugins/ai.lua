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
  {
    --- @see https://github.com/milanglacier/minuet-ai.nvim
    "milanglacier/minuet-ai.nvim",
    enabled = function()
      if vim.g.ai_agent ~= "strata" then
        return false
      end

      if vim.g.local_llm_endpoint == nil then
        vim.notify("Local LLMのエンドポイントが指定されていません", vim.log.levels.ERROR)
        return false
      end

      return true
    end,

    config = function()
      local provider = "openai_compatible"

      require("minuet").setup({
        provider = provider,

        -- ローカル推論の負荷・レイテンシ対策で最初は1推奨
        n_completions = 1,

        -- レスポンス速度優先なら短めに制限
        context_window = 2048,

        -- リクエスト間隔の最小値 (ms)
        throttle = 800,

        -- 入力停止からリクエスト送信までの待機時間 (ms)
        debounce = 400,

        notify = "verbose",
        provider_options = {
          [provider] = {
            api_key = function()
              return vim.g.local_llm_api_key or "dummy"
            end,
            name = "Strata",
            end_point = vim.g.local_llm_endpoint,
            model = "qwen3.8-flash-next-gyro-gyro-s",
            optional = {
              max_tokens = 128,
              temperature = 0.1,
              chat_template_kwargs = { enable_thinking = false },
            },
          },
        },
        virtualtext = {
          auto_trigger_ft = { "*" },
          keymap = {
            accept = "<A-A>",
            accept_line = "<A-a>",
            next = "<A-]>",
            prev = "<A-[>",
            dismiss = "<A-e>",
          },
        },
      })
    end,
  },
}

return conf
