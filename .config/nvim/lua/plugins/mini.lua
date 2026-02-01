return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup {
        mappings = {
          add = 'sa', --  saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
          delete = 'sd', -- sd' - [S]urround [D]elete [']quotes
          find = '',
          find_left = '',
          highlight = '',
          replace = 'sc', -- sr)'  - [S]urround [R]eplace [)] [']
          update_n_lines = '',
        },
      }

      require('mini.align').setup {
        mappings = {
          start = '',
          start_with_preview = 'ga',
        },
      }

      require('mini.pairs').setup()

      require('mini.move').setup()

      require('mini.statusline').setup()

      require('mini.tabline').setup {}

      require('mini.extra').setup()

      require('mini.visits').setup()

      require('mini.diff').setup()

      -- require('mini.git').setup()

      -- ╭─────────────────────────────────────────────────────────╮
      -- │                     mini.completion                     │
      -- ╰─────────────────────────────────────────────────────────╯
      require('mini.fuzzy').setup()
      require('mini.completion').setup {
        window = {
          completion = { border = single },
          info = { border = single },
          signature = { border = single },
        },
        lsp_completion = {
          process_items = MiniFuzzy.process_lsp_items,
        },
      }

      -- improve fallback completion
      vim.opt.complete = { '.', 'w', 'k', 'b', 'u' }
      vim.opt.completeopt:append 'fuzzy'
      vim.opt.dictionary:append '/usr/share/dict/words' -- 注意1

      -- define keycodes
      local keys = {
        cn = vim.keycode '<c-n>',
        cp = vim.keycode '<c-p>',
        ct = vim.keycode '<c-t>',
        cd = vim.keycode '<c-d>',
        cr = vim.keycode '<cr>',
        cy = vim.keycode '<c-y>',
      }

      -- select by <tab>/<s-tab>
      vim.keymap.set('i', '<tab>', function()
        -- popup is visible -> next item
        -- popup is NOT visible -> add indent
        return vim.fn.pumvisible() == 1 and keys.cn or keys.ct
      end, { expr = true, desc = 'Select next item if popup is visible' })
      vim.keymap.set('i', '<s-tab>', function()
        -- popup is visible -> previous item
        -- popup is NOT visible -> remove indent
        return vim.fn.pumvisible() == 1 and keys.cp or keys.cd
      end, { expr = true, desc = 'Select previous item if popup is visible' })

      -- complete by <cr>
      vim.keymap.set('i', '<cr>', function()
        if vim.fn.pumvisible() == 0 then
          -- popup is NOT visible -> insert newline
          return require('mini.pairs').cr() -- 注意2
        end
        local item_selected = vim.fn.complete_info()['selected'] ~= -1
        if item_selected then
          -- popup is visible and item is selected -> complete item
          return keys.cy
        end
        -- popup is visible but item is NOT selected -> hide popup and insert newline
        return keys.cy .. keys.cr
      end, { expr = true, desc = 'Complete current item if item is selected' })

      -- ================================================== [ pick ] ==========

      local pick = require 'mini.pick'

      require('mini.pick').setup {}
      vim.ui.select = pick.ui_select

      -- -- git files
      -- vim.keymap.set('n', '<space>sg', function()
      --   pick.builtin.files { tool = 'git' }
      -- end, { desc = 'MiniPick [Git Files]' })
      --
      -- vim.keymap.set('n', '<space>sl', function()
      --   pick.builtin.grep_live()
      -- end, { desc = 'Pick [Live Grep]' })

      -- history -- visits
      require('mini.visits').setup()
      vim.keymap.set('n', '<leader>h', function()
        require('mini.extra').pickers.visit_paths()
      end, { desc = 'Pick [Vist]' })

      -- buffer
      vim.keymap.set('n', '<leader><leader>', function()
        local wipeout_cur = function()
          local cur = pick.get_picker_matches().current
          if cur and cur.bufnr then
            vim.api.nvim_buf_delete(cur.bufnr, {})
          end
        end

        local buffer_mappings = {
          wipeout = { char = '<c-d>', func = wipeout_cur },
        }

        pick.builtin.buffers({ include_current = false }, { mappings = buffer_mappings })
      end, { desc = 'Pick [Buffers <C-d>:delete]' })

      -- vim.keymap.set('n', '<leader><leader>', function()
      --   local wipeout_cur = function()
      --     vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
      --   end
      --   local buffer_mappings = { wipeout = { char = '<c-d>', func = wipeout_cur } }
      --   pick.builtin.buffers({ include_current = false }, { mappings = buffer_mappings })
      -- end, { desc = 'Pick [Buffers <C-d>:delete]' })

      -- help :hhでヘルプをFuzzy Find
      vim.keymap.set('c', 'h', function()
        if vim.fn.getcmdtype() .. vim.fn.getcmdline() == ':h' then
          return '<c-u>Pick help<cr>'
        end
        return 'h'
      end, { expr = true, desc = 'mini.pick.help' })

      -- ============================================= [ animate ] ============
      local animate = require 'mini.animate'

      require('mini.animate').setup {
        cursor = {
          -- Animate for 100 milliseconds with linear easing
          timing = animate.gen_timing.linear { duration = 50, unit = 'total' },
        },
        scroll = {
          -- Animate for 150 milliseconds with linear easing
          timing = animate.gen_timing.linear { duration = 150, unit = 'total' },
        },
      }

      -- =============================================== [ misc ] =============
      require('mini.misc').setup()
      -- 終了時のカーソル位置を記憶する
      MiniMisc.setup_restore_cursor()
      -- zoom
      vim.api.nvim_create_user_command('Zoom', function()
        MiniMisc.zoom(0, {})
      end, { desc = 'Zoom current buffer' })
      vim.keymap.set('n', '<leader>tz', '<cmd>Zoom<cr>', { desc = 'Zoom Toggle' })

      -- ============================================== [ indentscope ] =======
      require('mini.indentscope').setup {
        event = 'BufRead',
        draw = {
          delay = 10,
          animation = require('mini.indentscope').gen_animation.none(),
        },
        options = {
          border = 'both',
          try_as_border = true,
        },
        symbol = '│',
      }

      -- =============================================== [ starter ] ==========

      local fzf = require 'fzf-lua'

      local starter = require 'mini.starter'

      local date = os.date '%Y-%m-%d %A'

      local ascii = {
        [[
╭────────────────────────────────────╮
│ now ᴘʟᴀʏɪɴɢ: Neovim (Feat: Nobody) │
│ ────────────────────⚪──────────── │
│ ◄◄⠀▐▐⠀►►  𝟸:𝟷𝟾 / 𝟹:𝟻𝟼⠀   ─────○ 🔊 │
╰────────────────────────────────────╯
]],
        'Today: ' .. date,
      }

      -- require('mini.starter').setup()
      starter.setup {
        header = table.concat(ascii, '\n'),
        evaluate_single = true,
        items = {
          starter.sections.recent_files(8, false),
          starter.sections.sessions(3, true),
          {
            name = 'Find Files',
            action = function()
              fzf.files()
            end,
            section = '',
          },
          {
            name = 'Neovim Config',
            action = function()
              require('fzf-lua').files { cwd = '~/.config/nvim' }
            end,
            section = '',
          },
          {
            name = 'File Manager',
            action = function()
              vim.cmd 'Oil --float'
            end,
            section = '',
          },
          {
            name = 'Lazy',
            action = function()
              vim.cmd 'Lazy'
            end,
            section = '',
          },
          starter.sections.builtin_actions(),
        },
        footer = '', -- 下部 starterのhelp消す
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.indexing('all', { 'Builtin actions' }),
          starter.gen_hook.padding(3, 2),
          starter.gen_hook.aligning('center', 'center'),
        },
      }
      -- starter呼び出し
      vim.keymap.set('n', '<leader>S', function()
        require('mini.starter').open()
      end, { desc = 'Starter [Open]' })

      -- ================================================ [ hipatterns ] ======
      -- FIXME修正が必要 HACK解決策の検討 TODOあとで追加、修正 NOTE経緯、意図 -
      require('mini.hipatterns').setup {
        highlighters = {
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        },
      }

      -- ================================================== [ clue ] ==========
      local miniclue = require 'mini.clue'
      miniclue.setup {
        triggers = {
          -- mode n=ノーマル x=ビジュアル i=インサート c=コマンド
          -- Leader triggers
          { mode = { 'n', 'x' }, keys = '<Leader>' },

          -- `[` and `]` keys
          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = { 'n', 'x' }, keys = 'g' },

          -- surround
          { mode = { 'n', 'x' }, keys = 's' },

          -- Marks
          { mode = { 'n', 'x' }, keys = "'" },
          { mode = { 'n', 'x' }, keys = '`' },

          -- Registers
          { mode = { 'n', 'x' }, keys = '"' },
          { mode = { 'i', 'c' }, keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = { 'n', 'x' }, keys = 'z' },
        },
        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.square_brackets(),
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows { submode_resize = true, submode_move = true },
          miniclue.gen_clues.z(),
          { mode = 'n', keys = '<leader>b', desc = '+CommentBox' },
          { mode = 'n', keys = '<leader>c', desc = '+Colors' },
          { mode = 'n', keys = '<leader>f', desc = '+Fzflua' },
          { mode = 'n', keys = '<leader>g', desc = '+Git' },
          { mode = 'n', keys = '<leader>n', desc = '+Note' },
          { mode = 'n', keys = '<leader>r', desc = '+RosettaTranslate' },
          { mode = 'n', keys = '<leader>t', desc = '+Toggle' },
        },
        window = {
          delay = 100,
          config = {
            border = 'rounded',
            row = 'auto',
            col = 'auto',
            width = '45',
          },
        },
      }

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
