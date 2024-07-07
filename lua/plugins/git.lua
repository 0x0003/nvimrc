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

Kmap('n', '<leader>r', function() ng.open({ kind = 'replace' }) end,
  'Git: toggle neogit status')

gs.setup({
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
    Kmap('n', '<leader>gs', gs.stage_hunk,
      'Git: stage hunk')
    Kmap('n', '<leader>gu', gs.undo_stage_hunk,
      'Git: undo staged hunk')
    Kmap('n', '<leader>gr', gs.reset_hunk,
      'Git: reset hunk')
    Kmap('n', '<leader>gS', gs.stage_buffer,
      'Git: stage buffer')
    Kmap('n', '<leader>gR', gs.reset_buffer,
      'Git: reset buffer')
    Kmap('n', '<leader>gh', gs.preview_hunk,
      'Git: popup preview hunk', { buffer = bufnr })
    Kmap('n', '<leader>gb', function() gs.blame_line { full = true } end,
      'Git: blame popup')
    Kmap('n', '<leader>gB', gs.toggle_current_line_blame,
      'Git: blame toggle virtual text')
    Kmap('n', '<leader>gd', gs.diffthis,
      'Git: diffthis')
    Kmap('n', '<leader>gD', function() gs.diffthis('~') end,
      'Git: diffthis ~')
    Kmap('n', '[g', gs.prev_hunk,
      'Git: hunk prev', { buffer = bufnr })
    Kmap('n', ']g', gs.next_hunk,
      'Git: hunk next', { buffer = bufnr })
  end
})

require('diffview').setup({
  use_icons = true,
  show_help_hints = false,
})

