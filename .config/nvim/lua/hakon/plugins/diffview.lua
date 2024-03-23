return {
  'sindrets/diffview.nvim',
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>gd', '<Cmd>DiffviewOpen<CR>', { desc = '[G]itdiff [O]pen' })
    vim.keymap.set({ 'n', 'v' }, '<leader>gc', '<Cmd>DiffviewClose<CR>', { desc = '[G]itdiff [C]lose' })
  end
}
