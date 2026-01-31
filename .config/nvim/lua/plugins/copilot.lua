return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',

    ---@diagnostic disable-next-line: undefined-field
    config = function()
      require('copilot').setup {
        suggestion = {
          auto_trigger = true,
          hide_during_completion = false,
        },
        filetypes = {
          markdown = true,
          gitcommit = true,
          ['*'] = function()
            -- disable for files with specific names
            local fname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
            local disable_patterns = { 'env', 'conf', 'local', 'private' }
            return vim.iter(disable_patterns):all(function(pattern)
              return not string.match(fname, pattern)
            end)
          end,
        },
      }

      -- set CopilotSuggestion as underlined comment
      local hl = vim.api.nvim_get_hl(0, { name = 'Comment' })
      vim.api.nvim_set_hl(0, 'CopilotSuggestion', vim.tbl_extend('force', hl, { underline = true }))
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      'https://github.com/nvim-lua/plenary.nvim',
      'https://github.com/zbirenbaum/copilot.lua',
    },

    config = function()
      local default_prompts = require 'CopilotChat.config.prompts'
      local in_japanese = 'なお、説明は日本語でお願いします。'
      require('CopilotChat').setup {
        prompts = vim.tbl_deep_extend('force', default_prompts, {
          -- ビルトインのプロンプトを日本語化
          Explain = { prompt = default_prompts.Explain.prompt .. in_japanese },
          Review = { prompt = default_prompts.Review.prompt .. in_japanese },
          Fix = { prompt = default_prompts.Fix.prompt .. in_japanese },
          Optimize = { prompt = default_prompts.Optimize.prompt .. in_japanese },
          -- 日英翻訳のプロンプトを独自に追加
          TranslateJE = {
            prompt = 'Translate the selected text from English to Japanese if it is in English, or from Japanese to English if it is in Japanese. Please do not include unnecessary line breaks, line numbers, comments, etc. in the result.',
            system_prompt = 'You are an excellent Japanese-English translator. You can translate the original text correctly without losing its meaning. You also have deep knowledge of system engineering and are good at translating technical documents.',
            description = 'Translate text from Japanese to English or vice versa',
          },
        }),
      }

      vim.keymap.set('ca', 'chat', 'CopilotChat', { desc = 'Ask CopilotChat' })
      vim.keymap.set({ 'n', 'x' }, '<space>p', '<cmd>CopilotChatPrompt<cr>', { desc = 'CopilotChat predefined prompts' })
    end,
  },
}
