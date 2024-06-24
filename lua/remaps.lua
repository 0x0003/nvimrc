local f = vim.fn

-- marks
Kmap('n', '`', '\'')
Kmap('n', '\'', '`')

-- buffers
Kmap('n', '<leader>n', vim.cmd.bn)
Kmap('n', '<leader>p', vim.cmd.bp)
Kmap('n', '<BS>', '<C-^>')

-- windows
Kmap('n', '<leader>w', '<C-w>')
Kmap('n', '<leader>wd', '<C-w>c')
Kmap('n', '<leader>f', vim.cmd.close)
Kmap('n', '<C-h>', '<C-w>h')
Kmap('n', '<C-j>', '<C-w>j')
Kmap('n', '<C-k>', '<C-w>k')
Kmap('n', '<C-l>', '<C-w>l')
Kmap('n', '<Right>', '<cmd>vertical resize +3<CR>')
Kmap('n', '<Left>', '<cmd>vertical resize -3<CR>')
Kmap('n', '<Down>', '<cmd>resize +3<CR>')
Kmap('n', '<Up>', '<cmd>resize -3<CR>')

-- clear hlsearch
Kmap('n', '<leader>\\', vim.cmd.noh)

-- system clipboard copy/paste
Kmap('n', '<leader>y', '"+y')
Kmap('n', '<leader>Y', '"+Y')
Kmap('x', '<leader>y', '"+y')
Kmap('n', '<leader>P', '<cmd>set paste<CR>"+p<cmd>set nopaste<CR>')

-- emacs-style command-line editing
Kmap('c', '<C-a>', '<Home>', { silent = false })
Kmap('c', '<C-e>', '<End>', { silent = false })
Kmap('c', '<C-b>', '<Left>', { silent = false })
Kmap('c', '<C-f>', '<Right>', { silent = false })
Kmap('c', '<C-x>', '<C-f>', { silent = false })
Kmap('c', '<C-d>', '<Del>', { silent = false })
Kmap('c', '<C-n>', '<Down>', { silent = false })
Kmap('c', '<C-p>', '<Up>', { silent = false })

-- japanese IME
Kmap('n', 'ｈ', 'h')
Kmap('n', 'ｊ', 'j')
Kmap('n', 'ｋ', 'k')
Kmap('n', 'ｌ', 'l')
Kmap('n', 'ｒ', 'r')
Kmap('n', 'あ', 'a')
Kmap('n', 'い', 'i')
Kmap('n', 'う', 'u')
Kmap('n', 'お', 'o')
Kmap('n', 'っｄ', 'dd')
Kmap('n', 'っｙ', 'yy')
Kmap('n', 'ｐ', 'p')
Kmap('n', 'し”', 'ci"')
Kmap('n', 'し’', 'ci\'')

-- don't start new undo sequence (see `:help i_CTRL-G_u`) with C-w/C-u
Kmap('i', '<C-w>', '<C-w>', { noremap = false })
Kmap('i', '<C-u>', '<C-u>', { noremap = false })

-- run macro over visual range
Kmap('x', '@', function()
  return ':norm @' .. f.getcharstr() .. '<CR>'
end, { expr = true })

-- xdg-open
local function xdgo(x)
  f.execute('!xdg-open ' .. f.shellescape(f.expand(x), 1))
end
Kmap('n', 'gx', function() xdgo('<cfile>') end, { expr = true })
Kmap('n', 'gX', function() xdgo('%:p') end, { expr = true })

-- diagnostics
Kmap('n', '[d', vim.diagnostic.goto_prev)
Kmap('n', ']d', vim.diagnostic.goto_next)
Kmap('n', '<leader>sd', vim.diagnostic.open_float)

