return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', function ()
      local finders = require('telescope.finders')
      local pickers = require('telescope.pickers')
      local conf = require('telescope.config').values
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      local function get_modified_buffers()
          local buffers = vim.api.nvim_list_bufs()
          local modified_buffers = {}

          for _, buf in ipairs(buffers) do
              if vim.api.nvim_buf_get_option(buf, 'modified') then
                  local bufname = vim.api.nvim_buf_get_name(buf)
                  if bufname == "" then bufname = "[No Name]" end
                  table.insert(modified_buffers, bufname)
              end
          end

          return modified_buffers
      end

      local function open_modified_buffer(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection then
              vim.cmd('e ' .. selection[1])
          end
      end

      pickers.new({}, {
          prompt_title = 'Modified Buffers',
          finder = finders.new_table({
              results = get_modified_buffers(),
          }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                  open_modified_buffer(prompt_bufnr)
              end)
              return true
          end,
      }):find()
    end, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>st', require('telescope.builtin').treesitter, { desc = '[S]earch [T]reesitter' })
    vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = '[G]it [S]tatus' })
    vim.keymap.set('n', '<leader>sp', require('telescope.builtin').planets, { desc = '[S]earch [P]lanets' })
    vim.keymap.set('n', '<leader>ss', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')
  end
}
