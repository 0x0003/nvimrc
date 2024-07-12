local ng = require('neogit')
local gs = require('gitsigns')

ng.setup({
  disable_hint = true,
  mappings = {
    popup = {
      ['g?'] = 'HelpPopup',
    },
    status = {
      ['<leader>gi'] = function() vim.cmd.e('#') end,
      ['q'] = function() vim.cmd.e('#') end,
      ['='] = 'Toggle',
    }
  }
})

Kmap('n', '<leader>gi', function() ng.open({ kind = 'replace' }) end,
  'Git: interactive status')

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
    Kmap({ 'n', 'x' }, '<leader>hs', function()
        if vim.api.nvim_get_mode().mode == 'n' then
          gs.stage_hunk()
        else
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end
      end,
      'Git: hunk stage toggle')
    Kmap({ 'n', 'x' }, '<leader>hu', gs.undo_stage_hunk,
      'Git: hunk unstage')
    Kmap('n', '<leader>hr', gs.reset_hunk,
      'Git: hunk reset')
    Kmap('n', '<leader>gS', gs.stage_buffer,
      'Git: stage buffer')
    Kmap('n', '<leader>gR', gs.reset_buffer,
      'Git: reset buffer')
    Kmap('n', '<leader>hp', gs.preview_hunk,
      'Git: hunk popup preview', { buffer = bufnr })
    Kmap('n', '<leader>gB', function() gs.blame_line { full = true } end,
      'Git: blame popup')
    Kmap('n', '<leader>gd', gs.diffthis,
      'Git: diffthis')
    Kmap('n', '<leader>gD', function() gs.diffthis('~') end,
      'Git: diffthis ~')
    Kmap('n', '<leader>gc', function() ng.open({ 'commit' }) end,
      'Git: commit')
    Kmap('n', '<leader>gP', function() ng.open({ 'push' }) end,
      'Git: push')
    Kmap('n', '<leader>gp', function() ng.open({ 'pull' }) end,
      'Git: pull')
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

