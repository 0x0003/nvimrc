local harpoon = require('harpoon')

harpoon:setup({
  settings = {
    save_on_toggle = true,
  },
  border_chars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
})

kmap('n', '<leader>a', function() harpoon:list():add() end)
kmap('n', '<leader>A', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

kmap('n', '<leader>1', function() harpoon:list():select(1) end)
kmap('n', '<leader>2', function() harpoon:list():select(2) end)
kmap('n', '<leader>3', function() harpoon:list():select(3) end)
kmap('n', '<leader>4', function() harpoon:list():select(4) end)
kmap('n', '<leader>5', function() harpoon:list():select(5) end)

