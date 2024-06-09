-- NOTE: This is where your plugins related to LSP can be installed.
--  The configuration is done below. Search for lspconfig to find it below.
return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    local lspconfig = require('lspconfig')

    local on_attach = function(_, bufnr)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = '[R]e[n]ame' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[C]ode [A]ction' })

      vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions,
        { buffer = bufnr, desc = '[G]oto [D]efinition' })
      vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
        { buffer = bufnr, desc = '[G]oto [D]efinition' })
      vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations,
        { buffer = bufnr, desc = '[G]oto [I]mplementation' })
      vim.keymap.set('n', '<leader>D', require('telescope.builtin').lsp_type_definitions,
        { buffer = bufnr, desc = 'Type [D]efinition' })
      vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
        { buffer = bufnr, desc = '[D]ocument [S]ymbols' })

      -- See `:help K` for why this keymap
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover Documentation' })
      vim.keymap.set('n', '<C-;>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documentation' })

      -- Lesser used LSP functionality
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = '[G]oto [D]eclaration' })
      -- vim.keymap.set('n', '<leader>ff', function()
      --   vim.lsp.buf.format()
      -- end, { buffer = bufnr, desc = '[F]ormat [F]ile' })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    lspconfig['eslint'].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    lspconfig['html'].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    lspconfig['lua_ls'].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    lspconfig['rust_analyzer'].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    lspconfig['tsserver'].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })
  end
}
