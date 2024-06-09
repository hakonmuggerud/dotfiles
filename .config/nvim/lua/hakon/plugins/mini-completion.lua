return {
  'echasnovski/mini.completion',
  version = '*',
  event = 'InsertEnter',
  config = function()
    require('mini.completion').setup()
  end
}
