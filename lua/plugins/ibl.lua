require('ibl').setup({
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

