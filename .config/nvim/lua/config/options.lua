vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.breakindent = true
vim.opt.completeopt = 'menuone,noselect'
vim.opt.confirm = true
vim.opt.fillchars = { eob = ' ' }
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.scrolloff = 10
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wrap = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.diagnostic.config({ virtual_text = true })
