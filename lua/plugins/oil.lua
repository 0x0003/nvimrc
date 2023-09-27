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
    {'size', highlight = 'Special'},
  },
  keymaps = {
    ['g?'] = 'actions.show_help',
    ['<CR>'] = 'actions.select',
    ['<C-s>'] = 'actions.select_vsplit',
    ['<C-h>'] = 'actions.select_split',
    ['<C-t>'] = 'actions.select_tab',
    ['<C-p>'] = 'actions.preview',
    ['<leader>e'] = 'actions.close',
    ['<C-l>'] = 'actions.refresh',
    ['-'] = 'actions.parent',
    ['_'] = 'actions.open_cwd',
    ['`'] = 'actions.cd',
    ['~'] = 'actions.tcd',
    ['gs'] = 'actions.change_sort',
    ['gx'] = 'actions.open_external',
    ['g.'] = 'actions.toggle_hidden',
  },
})

kmap('n', '<leader>e', '<CMD>Oil<CR>')

