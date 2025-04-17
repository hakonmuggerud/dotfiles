vim.cmd([[
  hi StatusLine guifg=#efefef guibg=#303030 gui=NONE
  hi StatusLineGitBlame guifg=#aaaaaa guibg=#303030 gui=NONE
  hi StatusLineLSP guifg=#7CCCB8 guibg=#303030 gui=bold
]])

-- Function to get file icon using nvim-web-devicons
local function get_file_icon()
  local filename = vim.fn.expand('%:t')
  local extension = vim.fn.expand('%:e')
  local icon = ''
  local icon_color = ''

  -- Check if nvim-web-devicons is available
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

-- Function to get formatted path with filename and icon
local function get_formatted_path()
  local filepath = vim.fn.expand('%:.:h') -- Path relative to current directory without filename
  local filename = vim.fn.expand('%:t') -- Just the filename

  -- Handle empty filename
  if filename == '' then
    return '[No Name]'
  end

  -- Get the icon for the file
  local icon = get_file_icon()

  -- Format the path
  if filepath == '.' then
    -- We're in the root directory
    return icon .. ' ' .. filename
  else
    -- We're in a subdirectory
    return filepath .. '/ %#StatusLineIcon#' .. icon .. '%#StatusLine# ' .. filename
  end
end

-- Function to get LSP client info
local function get_lsp_info()
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })

  if #buf_clients == 0 then
    return ''
  end

  -- Get first client for simplicity
  local client = buf_clients[1]
  local client_name = client.name

  local icon = '' -- Default icon for LSP

  return '  -  ' .. '%#StatusLineLSP#' .. icon .. '  ' .. client_name .. '%#StatusLine#'
end

function _G.custom_statusline()
  local statusline = '   '

  -- Left section
  statusline = statusline .. get_formatted_path() .. '%#StatusLine#'

  -- LSP information in the middle
  local lsp_info = get_lsp_info()
  if lsp_info ~= '' then
    statusline = statusline .. lsp_info
  end

  -- Middle spacer
  statusline = statusline .. '%='

  -- Right section - Git blame (will be updated after cursor move)
  if _G.current_git_blame and _G.current_git_blame ~= '' then
    statusline = statusline .. _G.current_git_blame .. ' %#StatusLine#        '
  end

  -- Position information (line and character)
  statusline = statusline .. '%l:%c %#StatusLine#'

  return statusline
end

vim.o.statusline = '%{%v:lua.custom_statusline()%}'

_G.current_git_blame = ''

local function update_git_blame()
  if package.loaded['gitblame'] then
    local gitblame = require('gitblame')
    if gitblame.is_blame_text_available() then
      _G.current_git_blame = gitblame.get_current_blame_text()
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
