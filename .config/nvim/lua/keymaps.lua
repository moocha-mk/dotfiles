-- Escで検索ハイライトをオフにする
vim.keymap.set('n', '<Esc>', ':noh<CR>', { silent = true })

-- !!! ssキーにデフォルトのsキーの動作 (cl) を割り当てる !!!
vim.keymap.set('n', 'ss', 'cl', { silent = true, desc = 'Substitute character' })

-- 診断メッセージ（virtual_text）の表示/非表示を切り替えるキーマップ
vim.keymap.set('n', '<Leader>td', function()
  local config = vim.diagnostic.config()
  if config then
    -- 現在の設定に基づいて反転させる
    vim.diagnostic.config {
      virtual_text = not config.virtual_text,
    }
  end
end, { desc = 'Toggle LSP diagnostics' })

-- Ctrl + h/j/k/l でウィンドウ移動
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
