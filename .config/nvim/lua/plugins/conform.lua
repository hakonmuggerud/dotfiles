return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        rust = { 'rustfmt' },
        sql = { 'sql-formatter' },
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
  end,
}
