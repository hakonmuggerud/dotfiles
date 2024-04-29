return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      theme = 'catppuccin',
    },
    sections = {
      lualine_b = { 'branch', 'diff', 'grapple' },
      lualine_c = {
        {
          -- Custom component to show filename and its parent directory
          function()
            local path = vim.fn.expand('%:p')                                                                  -- Get the full path of the current file
            local filename = vim.fn.expand('%:t')                                                              -- Get the filename
            if path == '' then return '' end                                                                   -- If no file is open, return empty
            local parent_dir = vim.fn.fnamemodify(path, ':h:t')                                                -- Get the parent directory name
            if filename == 'index.js' or filename == 'index.jsx' then return parent_dir .. '/' .. filename end -- If the file is index.js,  show the parent directory
            return
            filename                                                                                           -- Otherwise, just show the filename
          end,
          cond = function() return vim.fn.expand('%:t') ~= '' end,                                             -- Only show if there is a file name
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
