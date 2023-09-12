local present, gitsigns = pcall(require, 'gitsigns')

if not present then
  return
end

gitsigns.setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
    topdelete = { text = '^' },
    changedelete = { text = '~' },
  },
  attach_to_untracked = false,
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    vim.keymap.set('n', '<leader>gp', gs.prev_hunk, { buffer = bufnr })
    vim.keymap.set('n', '<leader>gn', gs.next_hunk, { buffer = bufnr })
    vim.keymap.set('n', '<leader>gh', gs.preview_hunk, { buffer = bufnr })
  end
}

