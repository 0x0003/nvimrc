local present, gitsigns = pcall (require, 'gitsigns')

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
    vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr })
    vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr })
    vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk, { buffer = bufnr })
  end
}

