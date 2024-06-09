return {
  'github/copilot.vim',
  keys = {
    { '<leader>ce', '<cmd>Copilot enable<cr>', desc = 'Copilot enable' }
  },
  config = function()
    vim.keymap.set('n', '<leader>cd', '<cmd>Copilot disable<cr>', { desc = 'Copilot disable' })
  end
}
