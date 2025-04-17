return {
  'ibhagwan/fzf-lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local fzf = require('fzf-lua')
    fzf.setup({
      'hide',
      keymap = {
        builtin = {
          ['<C-u>'] = 'preview-page-up',
          ['<C-d>'] = 'preview-page-down',
        },
        fzf = {
          ['ctrl-u'] = 'preview-page-up',
          ['ctrl-d'] = 'preview-page-down',
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
  end,
}
