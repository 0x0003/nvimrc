local function kmap(mode, keys, command, opts)
  opts = { noremap = true, silent = true }
  vim.keymap.set(mode, keys, command, opts)
end

-- marks
kmap('n', '`', '\'')
kmap('n', '\'', '`')

-- buffers
kmap('n', '<leader>n', vim.cmd.bn)
kmap('n', '<leader>p', vim.cmd.bp)
kmap('n', '<BS>', '<C-^>')

-- windows
kmap('n', '<leader>f', vim.cmd.close)
kmap('n', '<C-h>', '<C-w>h')
kmap('n', '<C-j>', '<C-w>j')
kmap('n', '<C-k>', '<C-w>k')
kmap('n', '<C-l>', '<C-w>l')
kmap('n', '<Right>', '<cmd>vertical resize +3<CR>')
kmap('n', '<Left>', '<cmd>vertical resize -3<CR>')
kmap('n', '<Down>', '<cmd>resize +3<CR>')
kmap('n', '<Up>', '<cmd>resize -3<CR>')

-- clear hlsearch
kmap('n', '<leader>\\', vim.cmd.noh)

-- system clipboard copy/paste
kmap('n', '<leader>y', '"+y')
kmap('n', '<leader>Y', '"+Y')
kmap('x', '<leader>y', '"+y')
kmap('n', '<leader>P', '<cmd>set paste<CR>"+p<cmd>set nopaste<CR>')

-- diagnostics
kmap('n', '[d', vim.diagnostic.goto_prev)
kmap('n', ']d', vim.diagnostic.goto_next)
kmap('n', '<leader>sd', vim.diagnostic.open_float)

