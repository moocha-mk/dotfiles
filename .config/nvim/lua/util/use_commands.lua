-- NOTE コマンド入力時にステータスラインを表示
vim.api.nvim_create_autocmd({ 'RecordingEnter', 'CmdlineEnter' }, {
  pattern = '*',
  callback = function()
    vim.opt.cmdheight = 1
  end,
})
vim.api.nvim_create_autocmd('RecordingLeave', {
  pattern = '*',
  callback = function()
    vim.opt.cmdheight = 0
  end,
})
vim.api.nvim_create_autocmd('cmdlineLeave', {
  pattern = '*',
  callback = function()
    if vim.fn.reg_recording() == '' then
      vim.opt.cmdheight = 0
    end
  end,
})

-- 分割線の色を鮮やかな青にして、背景はNONE(背景色を維持)にする例
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#555555', bg = 'NONE', bold = true })

-- escで英語入力に
vim.cmd [[
if executable('fcitx5')
  let g:fcitx_state = 1
  augroup fcitx_savestate
    autocmd!
    autocmd InsertLeave * let g:fcitx_state = str2nr(system('fcitx5-remote'))
    autocmd InsertLeave * call system('fcitx5-remote -c')
    autocmd InsertEnter * call system(g:fcitx_state == 1 ? 'fcitx5-remote -c': 'fcitx5-remote -o')
  augroup END
endif
]]

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
