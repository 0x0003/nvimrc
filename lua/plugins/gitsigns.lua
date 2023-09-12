local present, gitsigns = pcall(require, 'gitsigns')

if not present then
  return
end

local function nkmap(keys, command, opts)
  opts = { noremap = true, silent = true }
  vim.keymap.set('n', keys, command, opts)
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
    nkmap('[g', gs.prev_hunk, { buffer = bufnr })
    nkmap(']g', gs.next_hunk, { buffer = bufnr })
    nkmap('<leader>gh', gs.preview_hunk, { buffer = bufnr })
    nkmap('<leader>gs', '<cmd>Git<CR>')
    nkmap('<leader>gd', '<cmd>Gvdiffsplit!<CR>')
    nkmap('<leader>gP', '<cmd>Git push<CR>')
    nkmap('<leader>gL', '<cmd>Git pull<CR>')
  end
}

