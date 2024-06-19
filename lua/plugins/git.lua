local ng = require('neogit')
local gs = require('gitsigns')

ng.setup({
  disable_hint = true,
  mappings = {
    popup = {
      ['g?'] = 'HelpPopup',
    },
    status = {
      ['<leader>r'] = 'Close',
      ['='] = 'Toggle',
    }
  }
})

kmap('n', '<leader>r', function() ng.open({ kind = 'replace' }) end)

gs.setup ({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
    topdelete = { text = '^' },
    changedelete = { text = '~' },
  },
  _signs_staged_enable = true,
  _signs_staged = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
    topdelete = { text = '^' },
    changedelete = { text = '~' },
  },
  attach_to_untracked = false,
  on_attach = function(bufnr)
    kmap('n', '<leader>gs', gs.stage_hunk)
    kmap('n', '<leader>gu', gs.undo_stage_hunk)
    kmap('n', '<leader>gr', gs.reset_hunk)
    kmap('n', '<leader>gS', gs.stage_buffer)
    kmap('n', '<leader>gR', gs.reset_buffer)
    kmap('n', '<leader>gh', gs.preview_hunk, { buffer = bufnr })
    kmap('n', '<leader>gb', function() gs.blame_line { full = true } end)
    kmap('n', '<leader>gB', gs.toggle_current_line_blame)
    kmap('n', '<leader>gd', gs.diffthis)
    kmap('n', '<leader>gD', function() gs.diffthis('~') end)
    kmap('n', '[g', gs.prev_hunk, { buffer = bufnr })
    kmap('n', ']g', gs.next_hunk, { buffer = bufnr })
  end
})

require('diffview').setup({
  use_icons = true,
  show_help_hints = false,
})

