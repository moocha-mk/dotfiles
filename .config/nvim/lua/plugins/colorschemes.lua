return {
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  { 'rebelot/kanagawa.nvim' },
  { 'ellisonleao/gruvbox.nvim', priority = 1000, config = true },
  {
    'folke/tokyonight.nvim',
    -- lazy = false,
    priority = 1000,
    opts = {},
  },
  { 'rmehri01/onenord.nvim' },
  {
    'zaldih/themery.nvim',
    lazy = false,
    keys = {
      { '<leader>cc', ':Themery<CR>', noremap = true, silent = true, desc = 'Change Colorscheme ' },
    },
    config = function()
      require('themery').setup {
        themes = {
          {
            name = 'Day',
            colorscheme = 'kanagawa-lotus',
          },
          'catppuccin',
          'gruvbox',
          'tokyonight',
          'miniwinter',
        },
      }
    end,
  },
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
}
