-- =========================================== NOTE #tagで管理、検索 ==========
local note_dir = vim.fn.expand '~/.notes/note'

-- MiniPick 共通関数
local pick = require 'mini.pick'

local function pick_notes(tool)
  pick.builtin[tool](nil, {
    source = { cwd = note_dir, name = 'Notes' },
    window = { config = { border = 'double' } },
  })
end
-- MiniPick
vim.keymap.set('n', '<leader>nn', function()
  pick_notes 'files'
end, { desc = 'Note [List]' })

vim.keymap.set('n', '<leader>ng', function()
  pick_notes 'grep_live'
end, { desc = 'Note [Grep]' })

-- Fzflua live grep検索
vim.keymap.set('n', '<leader>nl', function()
  require('fzf-lua').live_grep { cwd = note_dir }
end, { desc = 'Note [Grep_Fzf]' })

-- Oil ファイル管理
vim.keymap.set('n', '<leader>ne', ':Oil ' .. note_dir .. ' --float<CR>', { silent = true, desc = 'Note [Explorer]' })

-- 新規メモ
vim.keymap.set('n', '<leader>nc', function()
  local name = vim.fn.input 'Note Name: '
  if name ~= '' then
    vim.cmd('edit ' .. note_dir .. '/' .. name .. '.md')
  end
end, { desc = 'Note [Create]' })

-- =================================================== スクラッチ =============
--     <Leader>. で起動します。
--     q を押すと、保存するかどうかを確認するプロンプトがコマンドラインエリアに表示されます。
--         Yes (1): ~/.notes/scratch/ ディレクトリに、日時（例: 2024-05-20_103000.txt）で保存して閉じます。
--         No (2): 保存せずに閉じます。
--         Cancel (3): 終了を取り消して元の画面に戻ります。
--
-- 保存先ディレクトリの作成
local scratch_dir = vim.fn.expand '~/.notes/scratch/'
if vim.fn.isdirectory(scratch_dir) == 0 then
  vim.fn.mkdir(scratch_dir, 'p')
end

-- スクラッチバッファを開く
function OpenScratch()
  -- vim.cmd 'botright 10split' -- 下部に表示
  vim.cmd 'topleft 10split' -- 上部に表示
  -- vim.cmd 'vertical botright 30split' -- 右側に表示
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)

  -- バッファの設定
  -- vim.bo[buf].buflisted = false
  vim.bo[buf].bufhidden = 'hide'
  vim.bo[buf].buftype = '' -- 保存可能にするためからにする

  vim.keymap.set('n', 'q', function()
    if vim.bo[buf].modified then
      local choice = vim.fn.confirm('変更を保存しますか？', '&Yes\n&No\n&Cancel')
      if choice == 1 then -- Yes: 保存してバッファ削除
        local filename = scratch_dir .. 'scratch_' .. os.date '%Y%m%d_%H%M%S' .. '.txt'
        vim.cmd('write ' .. filename)
        vim.cmd 'bwipeout!'
        print('Saved to: ' .. filename)
      elseif choice == 2 then -- No: 保存せずバッファ削除
        vim.cmd 'bwipeout!'
      end
    else
      -- 変更がなければそのまま削除
      vim.cmd 'bwipeout!'
    end
  end, { buffer = buf, silent = true })
end

-- キーマップ登録 (例: <leader>.で起動)
vim.keymap.set('n', '<leader>.', OpenScratch, { silent = true, desc = 'Scratch' })

vim.keymap.set('n', '<leader>ns', function()
  require('fzf-lua').files { cwd = scratch_dir }
end, { desc = 'Scratch list' })
