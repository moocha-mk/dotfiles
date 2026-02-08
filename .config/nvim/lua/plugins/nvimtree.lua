return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    {
      'b0o/nvim-tree-preview.lua',
      dependencies = {
        'nvim-lua/plenary.nvim',
        -- "3rd/image.nvim", -- Optional, for previewing images
      },
    },
  },
  keys = {
    { '<C-n>', ':NvimTreeOpen<CR>', noremap = true, silent = true, desc = 'NvimTree' },
  },
  config = function()
    require('nvim-tree').setup {
      auto_reload_on_write = true,
      view = {
        width = 35,
        side = 'left',
        number = false,
      },
      -- view = {
      --   float = {
      --     enable = true,
      --     open_win_config = {
      --       relative = 'editor',
      --       border = 'rounded', -- 枠線のスタイル (single, double, rounded, solid, shadow)
      --       width = 50,
      --       height = 30,
      --       row = 5, -- 上からの位置
      --       col = 5, -- 左からの位置
      --     },
      --   },
      -- },
      actions = {
        open_file = {
          quit_on_open = true, -- ファイルを開いた時に閉じる
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = 'name',
        highlight_modified = 'name',
        highlight_hidden = 'icon',
        root_folder_label = ':~:s?$?/..?',
        indent_width = 2,

        indent_markers = {
          enable = true, -- enables the tree like line
          inline_arrows = true,
          icons = {
            corner = '└',
            edge = '│',
            item = '│',
            bottom = '─',
            none = ' ',
          },
        },
      },
      on_attach = function(bufnr)
        local api = require 'nvim-tree.api'

        -- Important: When you supply an `on_attach` function, nvim-tree won't
        -- automatically set up the default keymaps. To set up the default keymaps,
        -- call the `default_on_attach` function. See `:help nvim-tree-quickstart-custom-mappings`.
        api.config.mappings.default_on_attach(bufnr)

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local preview = require 'nvim-tree-preview'

        vim.keymap.set('n', 'P', preview.watch, opts 'Preview (Watch)')
        vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
        vim.keymap.set('n', '<C-f>', function()
          return preview.scroll(4)
        end, opts 'Scroll Down')
        vim.keymap.set('n', '<C-b>', function()
          return preview.scroll(-4)
        end, opts 'Scroll Up')

        -- Option A: Smart tab behavior: Only preview files, expand/collapse directories (recommended)
        vim.keymap.set('n', '<Tab>', function()
          local ok, node = pcall(api.tree.get_node_under_cursor)
          if ok and node then
            if node.type == 'directory' then
              api.node.open.edit()
            else
              preview.node(node, { toggle_focus = true })
            end
          end
        end, opts 'Preview')

        -- Option B: Simple tab behavior: Always preview
        -- vim.keymap.set('n', '<Tab>', preview.node_under_cursor, opts 'Preview')
      end,
    }
  end,
}
