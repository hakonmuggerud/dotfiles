local M = {}

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

local function create_modified_buffers_picker()
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
        table.insert(modified_buffers, bufname == '' and '[No Name]' or bufname)
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

  return function()
    pickers
      .new({}, {
        prompt_title = 'Modified Buffers',
        finder = finders.new_table({
          results = get_modified_buffers(),
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
          actions.select_default:replace(function()
            open_modified_buffer(prompt_bufnr)
          end)
          return true
        end,
      })
      :find()
  end
end

-- Setup function
function M.setup()
  local builtin = require('telescope.builtin')
  -- File and buffer operations
  map('n', '<leader><space>', builtin.oldfiles, { desc = '[?] Find recently opened files' })
  map('n', '<leader>?', create_modified_buffers_picker(), { desc = '[ ] Find existing buffers' })
  map('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
  map('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
  map('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus' })
  map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  map('n', '<leader>st', builtin.treesitter, { desc = '[S]earch [T]reesitter' })
  map('n', '<leader>ss', builtin.commands, { desc = '[S]earch [C]ommands' })
  map('n', '<leader>sa', function()
    builtin.live_grep({
      additional_args = function()
        return { '--hidden' }
      end,
    })
  end, { desc = '[S]earch [A]ll by grep' })

  pcall(require('telescope').load_extension, 'fzf')
end

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
  },
  config = M.setup,
}
