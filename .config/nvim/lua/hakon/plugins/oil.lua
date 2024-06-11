return {
  'stevearc/oil.nvim',
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('oil').setup({
      keymaps = {
        ['<C-h>'] = false
      }
    })

    vim.keymap.set('n', '<leader>-', '<CMD>Oil<CR>')
    vim.keymap.set('n', '-', require('oil').toggle_float)
  end
}
