local present, harpoon = pcall(require, 'harpoon')

if not present then
  return
end

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

local function nkmap(keys, command, opts)
  opts = { silent = true }
  vim.keymap.set('n', keys, command, opts)
end

nkmap('<leader>a', mark.add_file)
nkmap('<leader>A', ui.toggle_quick_menu)

nkmap('<leader>1', function() ui.nav_file(1) end)
nkmap('<leader>2', function() ui.nav_file(2) end)
nkmap('<leader>3', function() ui.nav_file(3) end)
nkmap('<leader>4', function() ui.nav_file(4) end)
nkmap('<leader>5', function() ui.nav_file(5) end)

