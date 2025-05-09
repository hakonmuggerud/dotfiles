vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
    vim.bo[args.buf].omnifunc = nil

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = '[G]oto [D]efinition' })
  end,
})
