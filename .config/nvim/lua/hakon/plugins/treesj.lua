return {
  'Wansmer/treesj',
  keys = {
    {
      '<leader>m', '<CMD>TSJToggle<CR>',
      desc = 'Toggle treesitter join',
    },
  },
  cmd = { 'TSJToggle', 'TSJJoin', 'TSJSplit' },
  opts = { use_default_keymaps = false }
}
