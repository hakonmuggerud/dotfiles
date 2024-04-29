return {
  'cbochs/grapple.nvim',
  opts = {
    scope = 'git', -- also try out 'git_branch'
  },
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  keys = {
    { '<leader>w', '<cmd>Grapple toggle<cr>',         desc = 'Grapple toggle tag' },
    { '<leader>W', '<cmd>Grapple toggle_tags<cr>',    desc = 'Grapple open tags window' },
    { '<leader>1', '<cmd>Grapple select index=1<cr>', desc = 'Select index 1' },
    { '<leader>2', '<cmd>Grapple select index=2<cr>', desc = 'Select index 2' },
    { '<leader>3', '<cmd>Grapple select index=3<cr>', desc = 'Select index 3' },
    { '<leader>4', '<cmd>Grapple select index=4<cr>', desc = 'Select index 4' },
    { '<leader>5', '<cmd>Grapple select index=5<cr>', desc = 'Select index 5' },
    { '<leader>6', '<cmd>Grapple select index=6<cr>', desc = 'Select index 6' },
    { '<leader>7', '<cmd>Grapple select index=7<cr>', desc = 'Select index 7' },
    { '<leader>8', '<cmd>Grapple select index=8<cr>', desc = 'Select index 8' },
    { '<leader>9', '<cmd>Grapple select index=9<cr>', desc = 'Select index 9' },
  },
}
