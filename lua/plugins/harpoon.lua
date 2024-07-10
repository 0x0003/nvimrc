local harpoon = require('harpoon')

harpoon:setup({
  settings = {
    save_on_toggle = true,
  },
  border_chars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
})

Kmap('n', '<leader>a', function() harpoon:list():add() end,
  'Harpoon: add')
Kmap('n', '<leader>A', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
  'Harpoon: popup toggle')

Kmap('n', '<leader>1', function() harpoon:list():select(1) end,
  'Harpoon: switch to list item 1')
Kmap('n', '<leader>2', function() harpoon:list():select(2) end,
  'Harpoon: switch to list item 2')
Kmap('n', '<leader>3', function() harpoon:list():select(3) end,
  'Harpoon: switch to list item 3')
Kmap('n', '<leader>4', function() harpoon:list():select(4) end,
  'Harpoon: switch to list item 4')
Kmap('n', '<leader>5', function() harpoon:list():select(5) end,
  'Harpoon: switch to list item 5')

