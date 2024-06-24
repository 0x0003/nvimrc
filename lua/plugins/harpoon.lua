local harpoon = require('harpoon')

harpoon:setup({
  settings = {
    save_on_toggle = true,
  },
  border_chars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
})

Kmap('n', '<leader>a', function() harpoon:list():add() end)
Kmap('n', '<leader>A', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

Kmap('n', '<leader>1', function() harpoon:list():select(1) end)
Kmap('n', '<leader>2', function() harpoon:list():select(2) end)
Kmap('n', '<leader>3', function() harpoon:list():select(3) end)
Kmap('n', '<leader>4', function() harpoon:list():select(4) end)
Kmap('n', '<leader>5', function() harpoon:list():select(5) end)

