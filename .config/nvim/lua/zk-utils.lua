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

return { add_task = add_task, toggle_checkbox = toggle_checkbox_with_timestamp }
