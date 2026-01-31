return {
  {
    'mattn/vim-rosetta',
    keys = {
      { '<leader>rr', '<cmd>RosettaTranslateBuffer<cr>', mode = { 'n', 'v' }, desc = 'Translate Buffer' },
      { '<leader>rt', '<cmd>RosettaTranslateAt<cr>', mode = 'n', desc = 'Translate Text' },
      { '<leader>rc', '<cmd>RosettaTranslateComment<cr>', mode = 'n', desc = 'Translate comment' },
    },
    -- init = function()
    --   -- デフォルト翻訳エンジン
    --   vim.g.rosetta_engine = 'google'
    --
    --   -- 翻訳方向（例：英語→日本語）
    --   vim.g.rosetta_from = 'en'
    --   vim.g.rosetta_to = 'ja'
    --
    --   -- 対象（comment / string / visual / line など）
    --   vim.g.rosetta_target = 'comment'
    --
    --   -- 翻訳結果の扱い
    --   vim.g.rosetta_replace = 0 -- 0: echo, 1: replace
    --   vim.g.rosetta_trim = 1 -- 前後空白を削除
    --   vim.g.rosetta_join_lines = 1 -- 複数行を1文として翻訳
    --
    --   -- キャッシュ（API節約）
    --   vim.g.rosetta_cache = 1
    -- end,
  },
}
