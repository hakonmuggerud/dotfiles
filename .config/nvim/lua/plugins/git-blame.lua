vim.g.gitblame_date_format = '%r'
vim.g.gitblame_display_virtual_text = 0
vim.g.gitblame_message_template = '<date> • <author>'

vim.keymap.set('n', '<leader>co', '<cmd>GitBlameOpenCommitURL<cr>', { desc = 'Open commit url' })

return {
  'f-person/git-blame.nvim',
  event = 'BufEnter',
}
