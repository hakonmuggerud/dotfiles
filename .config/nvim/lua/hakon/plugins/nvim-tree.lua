return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- use nvim-tree as the file explorer
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require('nvim-tree').setup({
      view = {
        width = {}
      }
    })

    vim.keymap.set('n', '<leader>ff', require('nvim-tree.api').tree.find_file, { desc = 'NvimTree find file' })
    vim.keymap.set('n', '<leader>tt', require('nvim-tree.api').tree.toggle, { desc = 'NvimTree toggle'})
  end
}
