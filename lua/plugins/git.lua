local present, ng = pcall(require, 'neogit')

if not present then
  return
end

ng.setup({
  disable_hint = true,
  mappings = {
    popup = {
      ['g?'] = 'HelpPopup',
    },
    status = {
      ['<leader>gs'] = 'Close',
      ['='] = 'Toggle',
    }
  }
})

kmap('n', '<leader>gs', function() ng.open({ kind = 'replace' }) end)

require('diffview').setup({
  use_icons = false,
  show_help_hints = false,
})

local gs = require('gitsigns')

gs.setup ({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
    topdelete = { text = '^' },
    changedelete = { text = '~' },
  },
  attach_to_untracked = false,
  on_attach = function(bufnr)
    kmap('n', '[g', gs.prev_hunk, { buffer = bufnr })
    kmap('n', ']g', gs.next_hunk, { buffer = bufnr })
    kmap('n', '<leader>gh', gs.preview_hunk, { buffer = bufnr })
    kmap('n', '<leader>gb', gs.blame_line)
  end
})

