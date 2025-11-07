vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.gitblame_date_format = '%r'
vim.g.gitblame_display_virtual_text = 0
vim.g.gitblame_message_template = '<date> • <author>'

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
vim.opt.winborder = 'rounded'
vim.opt.wrap = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.diagnostic.config({
  virtual_text = true,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
    vim.bo[args.buf].omnifunc = nil
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
  end,
})

vim.pack.add({
  { src = 'https://github.com/Saghen/blink.cmp' },
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
  { src = 'https://github.com/f-person/git-blame.nvim' },
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mrjones2014/smart-splits.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/supermaven-inc/supermaven-nvim' },
  { src = 'https://github.com/tpope/vim-sleuth' },
  { src = 'https://github.com/zk-org/zk-nvim' },
})

require('blink.cmp').setup({
  keymap = { preset = 'default' },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
  },
  completion = {
    accept = {
      auto_brackets = {
        enabled = false,
      },
    },
  },
  sources = {
    default = { 'lsp', 'path' },
  },
  fuzzy = { implementation = 'lua' },
  signature = { enabled = true },
})

require('gruvbox').setup({
  transparent_mode = true,
})
require('catppuccin').setup({
  flavor = 'mocha',
  integrations = {
    mason = false,
  },
})

local color_scheme_env = os.getenv('COLOR_SCHEME')
print(color_scheme_env)

vim.cmd('colorscheme ' .. (color_scheme_env or 'catppuccin-mocha'))

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    typescript = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    rust = { 'rustfmt' },
    sql = { 'sql-formatter' },
    css = { 'prettierd' },
    json = { 'prettierd' },
    jsonc = { 'prettierd' },
  },
  formatters = {
    ['sql-formatter'] = {
      command = vim.fn.stdpath('data') .. '/mason/bin/sql-formatter',
      args = {
        '--language',
        'postgresql',
      },
      stdin = true,
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

local fzf = require('fzf-lua')
fzf.setup({
  'hide',
  keymap = {
    builtin = {
      ['<C-u>'] = 'preview-page-up',
      ['<C-d>'] = 'preview-page-down',
      ['<M-a>'] = 'toggle-all',
    },
    fzf = {
      ['ctrl-u'] = 'preview-page-up',
      ['ctrl-d'] = 'preview-page-down',
      ['alt-a'] = 'toggle-all',
    },
  },
})
vim.keymap.set('n', '<leader>sf', fzf.files)
vim.keymap.set('n', '<leader>gs', fzf.git_status)
vim.keymap.set('n', '<leader>gf', fzf.git_files)
vim.keymap.set('n', '<leader>sk', fzf.keymaps)
vim.keymap.set('n', '<leader><space>', fzf.buffers)
vim.keymap.set('n', '<leader>/', fzf.blines)
vim.keymap.set('n', '<leader>sh', fzf.helptags)
vim.keymap.set('n', '<leader>sw', fzf.grep_cword)
vim.keymap.set('n', '<leader>sW', fzf.grep_cWORD)
vim.keymap.set('n', '<leader>sg', fzf.live_grep)
vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document)
vim.keymap.set('n', '<leader>sr', fzf.resume)
vim.keymap.set('n', '<leader>st', fzf.treesitter)
vim.keymap.set('n', '<leader>ss', fzf.commands)

require('gitsigns').setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
    vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset git hunk' })
    vim.keymap.set({ 'n', 'v' }, ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
    vim.keymap.set({ 'n', 'v' }, '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
  end,
})

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'graphql',
    'html',
    'javascript',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'regex',
    'rust',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
  },
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = { enable = true },
})

local oil = require('oil')
oil.setup({
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
vim.keymap.set('n', '-', oil.toggle_float)

require('supermaven-nvim').setup({})

require('mason').setup()

local smart_splits = require('smart-splits')
smart_splits.setup()
vim.keymap.set('n', '<A-h>', smart_splits.resize_left)
vim.keymap.set('n', '<A-j>', smart_splits.resize_down)
vim.keymap.set('n', '<A-k>', smart_splits.resize_up)
vim.keymap.set('n', '<A-l>', smart_splits.resize_right)
vim.keymap.set('n', '<C-h>', smart_splits.move_cursor_left)
vim.keymap.set('n', '<C-j>', smart_splits.move_cursor_down)
vim.keymap.set('n', '<C-k>', smart_splits.move_cursor_up)
vim.keymap.set('n', '<C-l>', smart_splits.move_cursor_right)

require('zk').setup({
  picker = 'fzf_lua',
})
local zk_utils = require('zk-utils')
vim.keymap.set('n', '<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>")
vim.keymap.set('n', '<leader>zt', '<Cmd>ZkTags<CR>')
vim.keymap.set('n', '<leader>zf', '<Cmd>ZkNotes<CR>')
vim.keymap.set('v', '<leader>zf', ":'<,'>ZkMatch<CR>")
vim.keymap.set('n', '<leader>zz', zk_utils.add_task)
vim.keymap.set('n', '<leader>zc', zk_utils.toggle_checkbox)

vim.keymap.set('n', '<leader>co', '<cmd>GitBlameOpenCommitURL<cr>', { desc = 'Open commit url' })

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

vim.lsp.enable({
  'eslint',
  'gopls',
  'html',
  'lua_ls',
  'rust_analyzer',
  'svelte',
  'terraformls',
  'ts_ls',
  'hyprls',
})

require('status-line')
