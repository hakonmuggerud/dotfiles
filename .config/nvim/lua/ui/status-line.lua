vim.cmd([[
  hi StatusLine guifg=#efefef guibg=#000000 gui=NONE
  hi StatusLineGitBlame guifg=#a6adc8 guibg=NONE gui=NONE
  hi StatusLineLSP guifg=#cdd6f4 guibg=NONE gui=bold
]])

local function get_file_icon()
  local filename = vim.fn.expand('%:t')
  local extension = vim.fn.expand('%:e')
  local icon = ''
  local icon_color = ''

  if package.loaded['nvim-web-devicons'] then
    local devicons = require('nvim-web-devicons')
    icon, icon_color = devicons.get_icon_color(filename, extension, { default = true })

    -- Set highlight for the icon using its color
    if icon_color then
      vim.cmd('hi StatusLineIcon guifg=' .. icon_color .. ' guibg=NONE')
    end
  end

  return icon
end

local function get_formatted_path()
  local filepath = vim.fn.expand('%:.:h') -- Path relative to current directory without filename
  local filename = vim.fn.expand('%:t')   -- Just the filename

  if filename == '' then
    return '[No Name]'
  end

  local icon = get_file_icon()

  if filepath == '.' then
    -- We're in the root directory
    return icon .. ' ' .. filename
  else
    -- We're in a subdirectory
    return filepath .. '/ %#StatusLineIcon#' .. icon .. '%#StatusLine# ' .. filename
  end
end

local function get_lsp_info()
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })

  if #buf_clients == 0 then
    return ''
  end

  local client_names = {}
  for _, client in ipairs(buf_clients) do
    table.insert(client_names, client.name)
  end
  local clients_str = table.concat(client_names, ', ')

  return '  ' .. '%#StatusLineLSP#  LSP ~ ' .. clients_str .. '%#StatusLine#'
end

function _G.custom_statusline()
  local statusline = ' '

  -- Left section
  statusline = statusline .. get_formatted_path() .. '%#StatusLine#'

  -- Middle spacer
  statusline = statusline .. '%='

  -- Right section
  if _G.current_git_blame and _G.current_git_blame ~= '' then
    statusline = statusline .. _G.current_git_blame .. ' %#StatusLine#        '
  end

  statusline = statusline .. '%l:%c %#StatusLine#'

  local lsp_info = get_lsp_info()
  if lsp_info ~= '' then
    statusline = statusline .. lsp_info
  end

  return statusline
end

vim.o.statusline = '%{%v:lua.custom_statusline()%}'

_G.current_git_blame = ''

local function update_git_blame()
  if package.loaded['gitblame'] then
    local gitblame = require('gitblame')
    if gitblame.is_blame_text_available() then
      _G.current_git_blame = '%#StatusLineGitBlame#' .. gitblame.get_current_blame_text()
    else
      _G.current_git_blame = ''
    end
  end
  vim.cmd('redrawstatus')
end

vim.api.nvim_create_augroup('CustomStatusline', { clear = true })

-- Update the git blame text after cursor has moved
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  group = 'CustomStatusline',
  callback = function()
    update_git_blame()
  end,
})

-- Update the statusline display
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged', 'TextChangedI' }, {
  group = 'CustomStatusline',
  callback = function()
    vim.o.statusline = '%{%v:lua.custom_statusline()%}'
  end,
})
