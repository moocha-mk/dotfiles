return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons

  cmd = 'Oil',
  keys = {
    { '<leader>e', ':Oil<CR>', silent = true, desc = '󰏇 ...oiL' },
    { '\\', ':Oil --float<CR>', noremap = true, silent = true, desc = 'Oil float' },
    {
      '<leader>E', -- パスに注意!!
      ':Oil ~/.config/nvim --float<CR>',
      noremap = true,
      silent = true,
      desc = '󰏇 Nvim_config',
    },
  },
  opts = {
    columns = {
      'icon',
      -- "permissions",
      'size',
      -- "mtime",
    },
    keymaps = { -- 元々のkeymap
      ['?'] = { 'actions.show_help', mode = 'n' }, --g?
      ['<CR>'] = 'actions.select',
      ['<C-v>'] = { 'actions.select', opts = { vertical = true } }, -- <C-s>
      ['<C-s>'] = { 'actions.select', opts = { horizontal = true } }, -- <C-h>
      ['<C-t>'] = { 'actions.select', opts = { tab = true } },
      ['<C-p>'] = 'actions.preview',
      ['<C-u>'] = 'actions.preview_scroll_down',
      ['<C-d>'] = 'actions.preview_scroll_up',
      ['q'] = { 'actions.close', mode = 'n' }, -- 本来は<C-c>
      ['<C-l>'] = 'actions.refresh',
      ['-'] = { 'actions.parent', mode = 'n' },
      ['_'] = { 'actions.open_cwd', mode = 'n' },
      ['`'] = { 'actions.cd', mode = 'n' },
      ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
      ['gs'] = { 'actions.change_sort', mode = 'n' },
      ['gx'] = 'actions.open_external',
      ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
      ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
    },
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
    float = {
      -- Padding around the floating window
      padding = 2,
      -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      max_width = 0.8,
      max_height = 0.6,
      border = 'rounded',
      win_options = {
        winblend = 0,
      },
    },
  },
}
