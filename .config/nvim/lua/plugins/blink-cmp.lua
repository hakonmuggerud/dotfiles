return {
  'saghen/blink.cmp',
  version = '*',
  event = 'InsertEnter',
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    sources = {
      default = { 'lsp', 'path', 'buffer' },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
  },
  opts_extend = { 'sources.default' },
}
