local harpoon = require('harpoon')

vim.g.harpoon_log_level = 'fatal'

harpoon.setup({
  tmux_autoclose_windows = true,
  excluded_filetypes = { "harpoon", "telescopeprompt" },
  menu = {
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
  }
})

local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

kmap('n', '<leader>a', mark.add_file)
kmap('n', '<leader>A', ui.toggle_quick_menu)

kmap('n', '<leader>1', function() ui.nav_file(1) end)
kmap('n', '<leader>2', function() ui.nav_file(2) end)
kmap('n', '<leader>3', function() ui.nav_file(3) end)
kmap('n', '<leader>4', function() ui.nav_file(4) end)
kmap('n', '<leader>5', function() ui.nav_file(5) end)

