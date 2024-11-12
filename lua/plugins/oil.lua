local oil = require('oil')

oil.setup({
  default_file_explorer = true,

  view_options = {
    show_hidden = true,
    is_always_hidden = function(name)
      return name == '..'
    end,
  },

  columns = {
    'icon',
    -- 'permissions',
    -- {'mtime', highlight = 'StatusCommand'},
    { 'size', highlight = 'Special' },
  },

  keymaps = {
    ['<C-h>'] = false,
    ['<C-j>'] = false,
    ['<C-k>'] = false,
    ['<C-l>'] = false,
    ['<BS>'] = 'actions.parent',
    ['<C-t>'] = 'actions.select_tab',
    ['<C-p>'] = 'actions.preview',
    ['<C-n>'] = 'actions.refresh',
  },

  float = { border = 'solid' },
  preview = { border = 'solid' },
  progress = { border = 'solid' },
  ssh = { border = 'solid' },
  keymaps_help = { border = 'solid' }
})

Kmap('n', '<leader>e', function()
    return (vim.bo.ft ~= 'oil' and { oil.open() } or { oil.close() })[1]
  end,
  'Oil: file explorer toggle')

