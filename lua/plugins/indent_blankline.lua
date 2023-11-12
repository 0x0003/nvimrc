local ibl = require('ibl')

ibl.setup({
  indent = {
    char = { '│' },
  },
  exclude = {
    filetypes = {
      'oil',
    },
  },
  scope = {
    enabled = true,
    show_start = false,
    show_end = true,
  },
})

