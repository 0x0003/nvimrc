local present, oil = pcall(require, 'oil')

if not present then
  return
end

oil.setup({
  view_options = {
    show_hidden = true,
  },
  default_file_explorer = true,
  columns = {
    -- 'icon',
    -- 'permissions',
    -- {'mtime', highlight = 'StatusCommand'},
    { 'size', highlight = 'Special' },
  },
  keymaps = {
    ['<BS>'] = 'actions.parent',
    ['<C-k>'] = 'actions.refresh',
    ['<C-l>'] = 'actions.select_vsplit',
    ['<C-j>'] = 'actions.select_split',
    ['<C-t>'] = 'actions.select_tab',
    ['<C-p>'] = 'actions.preview',
    ['<leader>e'] = 'actions.close',
  },
})

kmap('n', '<leader>e', '<CMD>Oil<CR>')

