return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = { -- (keys) lazyの遅延読み込み
    { '<leader>fa', ':FzfLua<CR>', noremap = true, silent = true, desc = 'FzfLua all' },
    { '<leader>fl', ':FzfLua live_grep<CR>', noremap = true, silent = true, desc = 'Live grep' },
    { '<leader>fg', ':FzfLua grep_cword<CR>', noremap = true, silent = true, desc = 'Grep current word' },
    { '<leader>fm', ':FzfLua marks<CR>', noremap = true, silent = true, desc = 'Marks' },
    { '<leader>fb', ':FzfLua buffers<CR>', noremap = true, silent = true, desc = 'Buffers' },
    { '<leader>fr', ':FzfLua registers<CR>', noremap = true, silent = true, desc = 'Registerss' },
    { '<leader>fk', ':FzfLua keymaps<CR>', noremap = true, silent = true, desc = 'Keymaps' },
    { '<leader>ff', ':FzfLua files<CR>', noremap = true, silent = true, desc = 'Files' },
    { '<leader>fc', ':FzfLua files cwd=~/.config/nvim<CR>', noremap = true, silent = true, desc = 'Config' },
    { '<leader>fo', ':FzfLua oldfiles<CR>', noremap = true, silent = true, desc = 'Old files' },
    { '<leader>fs', ':FzfLua lsp_document_symbols<CR>', noremap = true, silent = true, desc = 'Files Lsp-document-symbols' },
    { '<leader>gf', ':FzfLua git_files<CR>', noremap = true, silent = true, desc = 'Git files' },
    { '<leader>gp', ':GitProjects<CR>', noremap = true, silent = true, desc = 'Git files' },
    { '<leader>gs', ':FzfLua git_status<CR>', noremap = true, silent = true, desc = 'Git status' },
    {
      '<leader>fw',
      ":FzfLua grep { search = vim.fn.input('GREP -> ') }<CR>",
      noremap = true,
      silent = true,
      desc = 'Grep a word',
    },
  },
  config = function()
    require('fzf-lua').setup {
      files = {
        cmd = 'fd --type f --hidden --exclude .git --exclude .cache --exclude .local --exclude node_modules', -- 除外を追加
      },
      defaults = {
        formatter = 'path.filename_first',
        cwd_prompt = false,
        prompt = '> ',
        file_icons = true,
      },
      winopts = {
        height = 0.8,
        width = 0.75,
        row = 0.5,
        col = 0.5,
      },
      preview = {
        wrap = true,
        vertical = 'down:50%',
        horizontal = 'right:50%',
        scrollbar = 'false', -- `false` or string:'float|border'
      },
      buffers = {
        winopts = {
          -- split = 'belowright 10new', -- 下側に10行分で分割
          height = 0.4, -- ウインドウの高さ
          with = 0.6, -- ウインドウの幅
          row = 0.7, -- 上下表示位置
          preview = { hidden = 'hidden' }, -- プレビューを隠す
        },
      },
    }
  end,
}
