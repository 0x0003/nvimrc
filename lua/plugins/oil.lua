local present, oil = pcall(require, 'oil')

if not present then
  return
end

oil.setup({
  default_file_explorer = true,
  show_hidden = true,
  columns = {
    -- 'icon',
    -- 'permissions',
    -- 'size',
    -- 'mtime',
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

