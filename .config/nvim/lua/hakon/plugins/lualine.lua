return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      theme = 'catppuccin',
    },
    sections = {
      lualine_b = { 'branch', 'diff' },
      lualine_c = {
        {
          -- Custom component to show filename and its parent directory
          function()
            local path = vim.fn.expand('%:p')
            local filename = vim.fn.expand('%:t')
            if path == '' then return '' end
            local parent_dir = vim.fn.fnamemodify(path, ':h:t')
            local matching_names = { 'index.js', 'index.jsx' }
            if vim.tbl_contains(matching_names, filename) then
              return parent_dir
            end
            return filename
          end,
          cond = function() return vim.fn.expand('%:t') ~= '' end,
        },
        {
          'macro-recording',
          fmt = function()
            local recording_register = vim.fn.reg_recording()
            if recording_register == "" then
              return ""
            else
              return "Recording @" .. recording_register
            end
          end,
        }
      },
      lualine_x = {
        {
          function()
            return require('gitblame').get_current_blame_text()
          end,
          cond = function()
            return require('gitblame').is_blame_text_available()
          end,
          color = { fg = '#aaaaaa' },
          on_click = function()
            vim.cmd(':GitBlameOpenCommitURL')
          end,
        }
      }
    }
  },
}
