return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
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
    indent = { enable = true, disable = { 'ruby' } },
  },
}
