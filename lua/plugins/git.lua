local ng = require('neogit')
local gs = require('gitsigns')

ng.setup({
  disable_hint = true,
  mappings = {
    popup = {
      ['g?'] = 'HelpPopup',
    },
    status = {
      ['<leader>r'] = function() vim.cmd.e('#') end,
      ['q'] = function() vim.cmd.e('#') end,
      ['='] = 'Toggle',
    }
  }
})

Kmap('n', '<leader>r', function() ng.open({ kind = 'replace' }) end)

gs.setup ({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
    topdelete = { text = '^' },
    changedelete = { text = '~' },
  },
  signs_staged_enable = true,
  signs_staged = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
    topdelete = { text = '^' },
    changedelete = { text = '~' },
  },
  attach_to_untracked = false,
  on_attach = function(bufnr)
    Kmap('n', '<leader>gs', gs.stage_hunk)
    Kmap('n', '<leader>gu', gs.undo_stage_hunk)
    Kmap('n', '<leader>gr', gs.reset_hunk)
    Kmap('n', '<leader>gS', gs.stage_buffer)
    Kmap('n', '<leader>gR', gs.reset_buffer)
    Kmap('n', '<leader>gh', gs.preview_hunk, { buffer = bufnr })
    Kmap('n', '<leader>gb', function() gs.blame_line { full = true } end)
    Kmap('n', '<leader>gB', gs.toggle_current_line_blame)
    Kmap('n', '<leader>gd', gs.diffthis)
    Kmap('n', '<leader>gD', function() gs.diffthis('~') end)
    Kmap('n', '[g', gs.prev_hunk, { buffer = bufnr })
    Kmap('n', ']g', gs.next_hunk, { buffer = bufnr })
  end
})

require('diffview').setup({
  use_icons = true,
  show_help_hints = false,
})

