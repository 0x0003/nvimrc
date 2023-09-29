local present, ibl = pcall(require, 'ibl')

if not present then
  return
end

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

