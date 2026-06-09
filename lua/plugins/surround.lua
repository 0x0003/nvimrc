require('nvim-surround').setup()

vim.g.nvim_surround_no_normal_mappings = true

Kmap('n', 'sa', '<Plug>(nvim-surround-normal)',
  'Surround: add a pair around a motion')
Kmap('n', 'saa', '<Plug>(nvim-surround-normal-cur)',
  'Surround: add a pair around the current line')
Kmap('n', 'sA', '<Plug>(nvim-surround-normal-line)',
  'Surround: add a pair around a motion, on new lines')
Kmap('n', 'sAA', '<Plug>(nvim-surround-cur-line)',
  'Surround: add a pair around the current line, on new lines')

Kmap('x', 's', '<Plug>(nvim-surround-visual)',
  'Surround: add a pair around a visual selection')
Kmap('x', 'S', '<Plug>(nvim-surround-visual-line)',
  'Surround: add a pair around a visual selection, on new lines')

Kmap('n', 'sd', '<Plug>(nvim-surround-delete)',
  'Surround: delete a pair')

Kmap('n', 'sr', '<Plug>(nvim-surround-change)',
  'Surround: replace a pair')
Kmap('n', 'sR', '<Plug>(nvim-surround-change-line)',
  'Surround: replace a pair, putting replacements on new lines')

