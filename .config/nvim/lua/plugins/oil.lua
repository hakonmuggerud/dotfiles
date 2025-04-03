return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('oil').setup({
      keymaps = {
        ['<C-h>'] = false,
        ['q'] = function()
          vim.cmd('close')
        end,
      },
      view_options = {
        show_hidden = true,
      },
    })

    vim.keymap.set('n', '<leader>-', '<CMD>Oil<CR>')
    vim.keymap.set('n', '-', require('oil').toggle_float)
  end,
}
