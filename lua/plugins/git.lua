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
    kmap('n', '[g', gs.prev_hunk, { buffer = bufnr })
    kmap('n', ']g', gs.next_hunk, { buffer = bufnr })
    kmap('n', '<leader>gh', gs.preview_hunk, { buffer = bufnr })
    kmap('n', '<leader>gs', '<cmd>Git<CR>')
    kmap('n', '<leader>gd', '<cmd>Gvdiffsplit!<CR>')
    kmap('n', '<leader>gP', '<cmd>Git! push<CR>')
    kmap('n', '<leader>gL', '<cmd>Git! pull<CR>')
  end
}

