local gs = require('gitsigns')

gs.setup({
  attach_to_untracked = false,

  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
    topdelete = { text = '^' },
    changedelete = { text = '~' },
  },

  signs_staged_enable = false,
  signs_staged = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
    topdelete = { text = '^' },
    changedelete = { text = '~' },
  },

  preview_config = {
    border = 'solid'
  },

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
    Kmap('n', '[g', gs.prev_hunk,
      'Git: hunk prev', { buffer = bufnr })
    Kmap('n', ']g', gs.next_hunk,
      'Git: hunk next', { buffer = bufnr })

    -- fugitive
    Kmap('n', '<leader>gi', function()
        local name = 'fugitive://'
        if vim.fn.buflisted(vim.fn.bufname(name)) == 0 then
          vim.cmd('Git')
          vim.cmd('20wincmd_')
        else
          vim.cmd.bd(name)
          vim.cmd('doautocmd <nomodeline> statusline BufEnter')
        end
      end,
      'Git: interactive status toggle')
    Kmap('n', '<leader>gc', function() vim.cmd('Git commit') end,
      'Git: commit')
    Kmap('n', '<leader>gP', function() vim.cmd('Git push') end,
      'Git: push', { silent = false })
    Kmap('n', '<leader>gp', function() vim.cmd('Git pull') end,
      'Git: pull', { silent = false })
  end
})

Auc('FileType', {
  pattern = 'fugitive',
  group = Aug('fugitivesize', { clear = true }),
  callback = function()
    vim.opt_local.winfixheight = true
  end
})

