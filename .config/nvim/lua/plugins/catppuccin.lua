return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 2000,
  config = function()
    require('catppuccin').setup({
      flavor = 'mocha',
      integrations = {
        mason = false
      }
    })
    vim.cmd.colorscheme "catppuccin"
  end,
}
