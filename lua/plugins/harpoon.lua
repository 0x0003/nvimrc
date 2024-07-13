local harpoon = require('harpoon')

harpoon:setup({
  settings = {
    save_on_toggle = true,
  },
})

Kmap('n', '<leader>a', function() harpoon:list():add() end,
  'Harpoon: add to list')
Kmap('n', '<leader>A', function()
    harpoon.ui:toggle_quick_menu(harpoon:list(), {
      title = '',
      border = 'single',
      ui_max_width = 80
    })
  end,
  'Harpoon: popup list toggle')

for i = 1, 9 do
  Kmap('n', '<leader>' .. i, function() harpoon:list():select(i) end,
    'Harpoon: switch to list item ' .. i)
end

