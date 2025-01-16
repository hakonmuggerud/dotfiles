return {
  "cbochs/grapple.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", lazy = true }
  },
  opts = {
    scope = "git",
  },
  event = { "BufReadPost", "BufNewFile" },
  cmd = "Grapple",
  keys = {
    { "<leader>g", "<cmd>Grapple toggle<cr>",          desc = "Grapple toggle tag" },
    { "<leader>G", "<cmd>Grapple toggle_tags<cr>",     desc = "Grapple open tags window" },
    { "<leader>n", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
    { "<leader>p", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
    { "<c-t>",     "<cmd>Grapple select index=1<cr>",  desc = "Grapple select tag 1" },
    { "<c-y>",     "<cmd>Grapple select index=2<cr>",  desc = "Grapple select tag 2" },
    { "<c-f>",     "<cmd>Grapple select index=3<cr>",  desc = "Grapple select tag 3" },
    { "<c-b>",     "<cmd>Grapple select index=4<cr>",  desc = "Grapple select tag 4" },
  },
}
