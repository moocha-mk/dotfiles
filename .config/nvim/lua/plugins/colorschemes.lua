return {
  {
    'Shatur/neovim-ayu',
    name = 'ayu',
    opts = {
      overrides = function()
        if vim.o.background == 'dark' then
          return { NormalNC = { bg = '#0f151e', fg = '#808080' } }
        else
          return { NormalNC = { bg = '#f0f0f0', fg = '#808080' } }
        end
      end,
      -- },
    },
    {
      'catppuccin/nvim',
      name = 'catppuccin',
      priority = 1000,
      opts = {
        background = {
          light = 'latte', -- light設定時に使用するフレーバー
          dark = 'mocha', -- dark設定時に使用するフレーバー (frappe, macchiatoも可)
        },
        color_overrides = {
          mocha = {
            green = '#a6e3a1',
            base = '#1e1432', -- Mochaの背景色
            mantle = '#010101',
            crust = '#020202',
          },
          latte = {
            base = '#f5ebcd',
          },
        },
        dim_inactive = {
          enabled = true, -- dims the background color of inactive window
          shade = 'light',
          percentage = 0.25, -- percentage of the shade to apply to the inactive window
        },
        no_italic = true,

        custom_highlights = function(colors)
          return {
            -- ウィンドウの背景を base (メイン背景色) に設定
            NormalFloat = { bg = colors.base },
            -- 枠線の背景も base に合わせ、線自体は mauve (紫) や blue にする例
            FloatBorder = { bg = colors.base, fg = colors.mauve },
            -- カーソル行の背景色なども base に合わせたい場合
            CursorLine = { bg = colors.surface0 },
          }
        end,
        config = function()
          -- <leader>th (theme) で Light/Dark を切り替える例
          vim.keymap.set('n', '<leader>th', function()
            if vim.o.background == 'dark' then
              vim.o.background = 'light'
            else
              vim.o.background = 'dark'
            end
            print('Theme switched to ' .. vim.o.background)
          end, { desc = 'Toggle Light/Dark mode' })
        end,
      },
    },
    { 'rebelot/kanagawa.nvim' },
    { 'ellisonleao/gruvbox.nvim', priority = 1000, config = true },
    {
      'folke/tokyonight.nvim',
      -- lazy = false,
      priority = 1000,
      opts = {},
    },
    { 'rmehri01/onenord.nvim' },
    -- {
    --   'zaldih/themery.nvim',
    --   lazy = false,
    --   keys = {
    --     { '<leader>cc', ':Themery<CR>', noremap = true, silent = true, desc = 'Change Colorscheme ' },
    --   },
    --   config = function()
    --     require('themery').setup {
    --       themes = {
    --         {
    --           name = 'Day',
    --           colorscheme = 'kanagawa-lotus',
    --         },
    --         'catppuccin',
    --         'gruvbox',
    --         'tokyonight',
    --         'miniwinter',
    --       },
    --     }
    --   end,
    -- },
    {
      'uga-rosa/ccc.nvim',
      cond = not vim.g.vscode,
      event = { 'BufRead', 'CmdlineEnter', 'InsertEnter' },
      keys = vim.g.vscode and {} or {
        { '<leader>cp', '<cmd>CccPick<cr>', desc = 'CCC Color Picker' },
      },
      config = function()
        local ccc = require 'ccc'
        ccc.setup {
          highlighter = { auto_enable = true, lsp = true },
          alpha_show = 'hide', -- "auto" | "show" | "hide"
          inputs = {
            -- ccc.input.okhsl,
            ccc.input.rgb,
            ccc.input.hsl,
            ccc.input.cmyk,
          },
        }
      end,
    },
  },
}
