return {
  'zk-org/zk-nvim',
  config = function()
    require('zk').setup({
      picker = 'fzf_lua',
    })
    local opts = { noremap = true, silent = false }

    vim.api.nvim_set_keymap('n', '<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)
    -- Open notes associated with the selected tags.
    vim.api.nvim_set_keymap('n', '<leader>zt', '<Cmd>ZkTags<CR>', opts)
    -- Search for the notes matching a given query.
    vim.api.nvim_set_keymap('n', '<leader>zf', '<Cmd>ZkNotes<CR>', opts)
    -- Search for the notes matching the current visual selection.
    vim.api.nvim_set_keymap('v', '<leader>zf', ":'<,'>ZkMatch<CR>", opts)

    vim.keymap.set('n', '<leader>zz', function()
      local task = vim.fn.input('New task: ')
      if task == '' then
        return
      end

      local tasks_path = os.getenv('ZK_NOTEBOOK_DIR') .. '/1f98.md'
      local line = '- [ ] ' .. task .. '\n'

      local file = io.open(tasks_path, 'a')
      if file then
        file:write(line)
        file:close()
        print('Task added to ' .. tasks_path)
      else
        print('Could not open ' .. tasks_path)
      end
    end, opts)
  end,
}
