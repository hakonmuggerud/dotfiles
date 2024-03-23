return {
  -- 'navarasu/onedark.nvim',
  -- priority = 1000,
  -- config = function()
  --   vim.cmd.colorscheme 'onedark'
  --   require('onedark').setup({
  --     style = 'deep'
  --   })
  --   require('onedark').load()
  -- end,
  -- "catppuccin/nvim", name = "catppuccin", priority = 1000
  --
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'catppuccin'
    require('catppuccin').setup({
      integrations = {
        which_key = true
      }
    })
  end,
}
