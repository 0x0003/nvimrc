local f = vim.fn

-- marks
Kmap('n', '`', '\'',
  'Mark: jump to \'')
Kmap('n', '\'', '`',
  'Mark: jump to `')

-- buffers
Kmap('n', '<leader>bn', vim.cmd.bn,
  'Buffer: next')
Kmap('n', '<leader>bp', vim.cmd.bp,
  'Buffer: prev')
Kmap('n', '<BS>', function() vim.cmd.e('#') end,
  'Buffer: alternate')

-- windows
Kmap('n', '<leader>w', '<C-w>',
  'Window: wincmd')
Kmap('n', '<leader>wd', '<C-w>c',
  'Window: close')
Kmap('n', '<leader>wo', function()
    vim.cmd.wincmd('o')
    vim.cmd('doautocmd <nomodeline> statusline BufEnter')
  end,
  'Window: make current window the only one on the screen')
Kmap('n', '<leader>f', vim.cmd.close,
  'Window: close')
Kmap('n', '<C-h>', '<C-w>h',
  'Window: focus left')
Kmap('n', '<C-j>', '<C-w>j',
  'Window: focus down')
Kmap('n', '<C-k>', '<C-w>k',
  'Window: focus up')
Kmap('n', '<C-l>', '<C-w>l',
  'Window: focus right')
Kmap('n', '<Right>', '<cmd>vertical resize +3<CR>',
  'Window: +resize horizontal')
Kmap('n', '<Left>', '<cmd>vertical resize -3<CR>',
  'Window: -resize horizontal')
Kmap('n', '<Down>', '<cmd>resize +3<CR>',
  'Window: +resize vertical')
Kmap('n', '<Up>', '<cmd>resize -3<CR>',
  'Window: -resize vertical')

-- system clipboard copy/paste
Kmap({ 'n', 'x' }, '<leader>y', '"+y',
  'System clipboard: copy')
Kmap('n', '<leader>Y', '"+Y',
  'System clipboard: copy line')
Kmap('n', '<leader>P', '<cmd>set paste<CR>"+p<cmd>set nopaste<CR>',
  'System clipboard: paste')

-- emacs-style command-line editing
Kmap('c', '<C-a>', '<Home>',
  'Command-line: home', { silent = false })
Kmap('c', '<C-e>', '<End>',
  'Command-line: end', { silent = false })
Kmap('c', '<C-b>', '<Left>',
  'Command-line: left', { silent = false })
Kmap('c', '<C-f>', '<Right>',
  'Command-line: right', { silent = false })
Kmap('c', '<C-x>', '<C-f>',
  'Command-line: edit in buffer', { silent = false })
Kmap('c', '<C-d>', '<Del>',
  'Command-line: del', { silent = false })
Kmap('c', '<C-n>', '<Down>',
  'Command-line: history next', { silent = false })
Kmap('c', '<C-p>', '<Up>',
  'Command-line: history prev', { silent = false })

-- japanese IME
Kmap('n', 'ｈ', 'h',
  'IME: h')
Kmap('n', 'ｊ', 'j',
  'IME: j')
Kmap('n', 'ｋ', 'k',
  'IME: k')
Kmap('n', 'ｌ', 'l',
  'IME: l')
Kmap('n', 'ｒ', 'r',
  'IME: r')
Kmap('n', 'あ', 'a',
  'IME: a')
Kmap('n', 'い', 'i',
  'IME: i')
Kmap('n', 'う', 'u',
  'IME: u')
Kmap('n', 'お', 'o',
  'IME: o')
Kmap('n', 'っｄ', 'dd',
  'IME: dd')
Kmap('n', 'っｙ', 'yy',
  'IME: yy')
Kmap('n', 'ｐ', 'p',
  'IME: p')
Kmap('n', 'し”', 'ci"',
  'IME: ci"')
Kmap('n', 'し’', 'ci\'',
  'IME: ci\'')

-- don't start new undo sequence (see `:help i_CTRL-G_u`) with C-w/C-u
Kmap('i', '<C-w>', '<C-w>',
  'Delete the word before the cursor', { noremap = false })
Kmap('i', '<C-u>', '<C-u>',
  'Delete all characters before the cursor', { noremap = false })

-- xdg-open
local function xdgo(x)
  f.execute('!xdg-open ' .. f.shellescape(f.expand(x), 1))
end
Kmap('n', 'gx', function() xdgo('<cfile>') end,
  'Open filepath or url under the cursor with xdg-open', { expr = true })
Kmap('n', 'gX', function() xdgo('%:p') end,
  'Open current buffer with xdg-open', { expr = true })

-- diagnostics
Kmap('n', '[d', vim.diagnostic.goto_prev,
  'Diagnostic: prev')
Kmap('n', ']d', vim.diagnostic.goto_next,
  'Diagnostic: next')
Kmap('n', '<leader>dp', vim.diagnostic.open_float,
  'Diagnostic: open float')
Kmap('n', '<leader>q', function()
    vim.diagnostic.setqflist()
    vim.cmd('doautocmd <nomodeline> statusline BufEnter')
  end,
  'Diagnostic: send to quickfix')

Kmap('x', '@', function()
    return ':norm @' .. f.getcharstr() .. '<CR>'
  end,
  'Run macro over visual range',
  { expr = true })

Kmap('n', '<leader>`', function() vim.cmd.cd('%:h') end,
  'Set working directory to that of the current file',
  { silent = false })

Kmap('n', '<leader>\\', vim.cmd.noh,
  'Clear hlsearch')

