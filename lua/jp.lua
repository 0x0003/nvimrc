local function nkmap(keys, command, opts)
  opts = { noremap = true, silent = true }
  vim.keymap.set('n', keys, command, opts)
end

-- rempas for slightly better japanese IME experience
nkmap('ｈ', 'h')
nkmap('ｊ', 'j')
nkmap('ｋ', 'k')
nkmap('ｌ', 'l')
nkmap('ｒ', 'r')
nkmap('あ', 'a')
nkmap('い', 'i')
nkmap('う', 'u')
nkmap('お', 'o')
nkmap('っｄ', 'dd')
nkmap('っｙ', 'yy')
nkmap('し”', 'ci"')
nkmap('し’', 'ci\'')

