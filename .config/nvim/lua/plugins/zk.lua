local function toggle_checkbox_with_timestamp()
  local line = vim.api.nvim_get_current_line()
  local ts = os.date('@%Y-%m-%d %H:%M')

  if line:match('^%s*%- %[ %]') then
    -- Toggle to checked and add timestamp
    line = line:gsub('^%s*%- %[ %]', '- [x]')
    line = line .. ' ' .. ts
  elseif line:match('^%s*%- %[x%]') then
    -- Toggle to unchecked and remove timestamp
    line = line:gsub('^%s*%- %[x%]', '- [ ]')
    line = line:gsub('%s@%d%d%d%d%-%d%d%-%d%d %d%d:%d%d', '')
  else
    print('Not a checklist item.')
    return
  end

  vim.api.nvim_set_current_line(line)
end

local function add_task()
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
end

return {
  'zk-org/zk-nvim',
  ft = 'markdown',
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

    vim.keymap.set('n', '<leader>zz', add_task, opts)
    vim.keymap.set('n', '<leader>zc', toggle_checkbox_with_timestamp, opts)
  end,
}
