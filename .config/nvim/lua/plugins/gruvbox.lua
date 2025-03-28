require('globals')

local theme_name = 'gruvbox'

return {
  'ellisonleao/gruvbox.nvim',
  name = theme_name,
  lazy = COLORSCHEME ~= theme_name,
  priority = COLORSCHEME == theme_name and 1000 or 100,
  config = function()
    vim.cmd.colorscheme(theme_name)
    require(theme_name).setup()
  end,
}
