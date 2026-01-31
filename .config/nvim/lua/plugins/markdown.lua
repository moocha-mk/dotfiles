return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ft = { 'markdown' },
  keys = {
    { '<Space>tm', ':RenderMarkdown toggle<CR>', desc = 'Toggle RenderMarkdown' },
  },
  opts = {},
}
