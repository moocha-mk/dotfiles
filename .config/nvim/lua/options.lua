-- エンコード UTF-8
vim.opt.fileencoding = 'utf-8'

-- カーソルライン
vim.opt.cursorline = true

-- 行番号の標示
vim.opt.number = true
-- 行番号をカーソル位置を起点にする
vim.opt.relativenumber = true

-- スクロール時の画面上下端でのカーソル位置
vim.opt.scrolloff = 5

-- laststatus = 0 ステータスライン非表示
-- laststatus = 1 画面分割をして２個以上あるときに表示１個なら非表示
-- laststatus = 2 ステータスラインを常に表示
-- laststatus = 3 常に最下部に表示
vim.opt.laststatus = 3

-- コマンドライン
vim.opt.cmdheight = 0

-- マウスモードを有効化
vim.opt.mouse = 'a'
-- マウススクロール量
vim.opt.mousescroll = 'ver:1,hor:1'

-- コマンドラインにモード表示
vim.opt.showmode = true

vim.opt.colorcolumn = '80'

-- osのクリックボードとの同期
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end) -- 起動時間が長くなるためUiEnterの後に設定

vim.opt.termguicolors = true
vim.opt.winblend = 0 -- ウィンドウの不透明度
vim.opt.pumblend = 0 -- ポップアップメニューの不透明度

-- タブ、インデントの設定
vim.opt.tabstop = 2 -- タブの表示幅
vim.opt.shiftwidth = 2 -- インデントの幅
vim.opt.expandtab = true -- タブキーでスペースを入力する (default: false)
vim.opt.softtabstop = -1 -- タブキーで入力するスペース数 (-1: tabstop に合わせる)

-- ブレークインデントの有効化
-- 有効にすると改行時にインデントされた状態になる
vim.opt.breakindent = true

-- Undoファイルの有効化
vim.opt.undofile = false

-- 検索時の大文字・小文字の無視設定
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- サインカラム(行番号の左に表示される記号の行)の有効化
vim.opt.signcolumn = 'yes'

-- スワップファイルの更新時間
vim.opt.updatetime = 250

-- キーマッピングシーケンスの待ち時間
-- ！surrundの待ち時間のため若干長め
vim.opt.timeoutlen = 600

-- 分割画面の方向
vim.opt.splitright = true
vim.opt.splitbelow = true

-- リストモードの有効化
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- コマンドの結果を分割画面でプレビュー
vim.opt.inccommand = 'split'

-- リーダーキー
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- nerofontアイコンの有効、無効！
vim.g.have_nerd_font = true
