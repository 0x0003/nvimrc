local f = vim.fn

-- marks
kmap('n', '`', '\'')
kmap('n', '\'', '`')

-- buffers
kmap('n', '<leader>n', vim.cmd.bn)
kmap('n', '<leader>p', vim.cmd.bp)
kmap('n', '<BS>', '<C-^>')

-- windows
kmap('n', '<leader>w', '<C-w>')
kmap('n', '<leader>wd', '<C-w>c')
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

-- emacs-style command-line editing
kmap('c', '<C-a>', '<Home>', { silent = false })
kmap('c', '<C-e>', '<End>', { silent = false })
kmap('c', '<C-b>', '<Left>', { silent = false })
kmap('c', '<C-f>', '<Right>', { silent = false })
kmap('c', '<C-x>', '<C-f>', { silent = false })
kmap('c', '<C-d>', '<Del>', { silent = false })
kmap('c', '<C-n>', '<Down>', { silent = false })
kmap('c', '<C-p>', '<Up>', { silent = false })

-- japanese IME
kmap('n', 'ｈ', 'h')
kmap('n', 'ｊ', 'j')
kmap('n', 'ｋ', 'k')
kmap('n', 'ｌ', 'l')
kmap('n', 'ｒ', 'r')
kmap('n', 'あ', 'a')
kmap('n', 'い', 'i')
kmap('n', 'う', 'u')
kmap('n', 'お', 'o')
kmap('n', 'っｄ', 'dd')
kmap('n', 'っｙ', 'yy')
kmap('n', 'ｐ', 'p')
kmap('n', 'し”', 'ci"')
kmap('n', 'し’', 'ci\'')

-- don't start new undo sequence (see `:help i_CTRL-G_u`) with C-w/C-u
kmap('i', '<C-w>', '<C-w>', { noremap = false })
kmap('i', '<C-u>', '<C-u>', { noremap = false })

-- run macro over visual range
kmap('x', '@', function()
  return ':norm @' .. f.getcharstr() .. '<CR>'
end, { expr = true })

-- xdg-open
local function xdgo(x)
  f.execute('!xdg-open ' .. f.shellescape(f.expand(x), 1))
end
kmap('n', 'gx', function() xdgo('<cfile>') end, { expr = true })
kmap('n', 'gX', function() xdgo('%:p') end, { expr = true })

-- diagnostics
kmap('n', '[d', vim.diagnostic.goto_prev)
kmap('n', ']d', vim.diagnostic.goto_next)
kmap('n', '<leader>sd', vim.diagnostic.open_float)

