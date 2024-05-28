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

    vim.keymap.set('n', '-', '<CMD>Oil<CR>')
    vim.keymap.set('n', '<leader>-', require('oil').toggle_float)
  end
}
