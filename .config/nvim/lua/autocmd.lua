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
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
    })
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = 'rounded',
    })

    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { buffer = args.buf, desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = args.buf, desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, { buffer = args.buf, desc = '[G]oto [I]mplementation' })
    vim.keymap.set('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, { buffer = args.buf, desc = 'Type [D]efinition' })
    vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { buffer = args.buf, desc = '[D]ocument [S]ymbols' })
  end,
})
