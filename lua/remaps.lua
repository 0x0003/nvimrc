local function kmap (mode, keys, command, opts)
  opts = {noremap = true, silent = true}
  vim.keymap.set(mode, keys, command, opts)
end

-- marks
kmap ('n', '<leader>m', '<cmd>marks<CR>:normal \'')
kmap ('n', '`', '\'')
kmap ('n', '\'', '`')

-- buffers
kmap ('n', '<leader>n', vim.cmd.bn)
kmap ('n', '<leader>p', vim.cmd.bp)
kmap ('n', '<BS>', '<C-^>')

-- windows
kmap ('n', '<leader>f', vim.cmd.close)
kmap ('n', '<C-h>',   '<C-w>h')
kmap ('n', '<C-j>',   '<C-w>j')
kmap ('n', '<C-k>',   '<C-w>k')
kmap ('n', '<C-l>',   '<C-w>l')
kmap ('n', '<Right>', '<cmd>vertical resize +3<CR>')
kmap ('n', '<Left>',  '<cmd>vertical resize -3<CR>')
kmap ('n', '<Down>',  '<cmd>resize +3<CR>')
kmap ('n', '<Up>',    '<cmd>resize -3<CR>')

-- clear hlsearch
kmap ('n', '<leader>Q', vim.cmd.noh)

-- detect if running under wsl
local in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil
if in_wsl then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ["+"] = 'clip.exe',
      ["*"] = 'clip.exe',
    },
    paste = {
      ["+"] = 'powershell.exe -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
-- system clipboard copy/paste
kmap ('n', '<leader>y', '"+y')
kmap ('n', '<leader>Y', '"+Y')
kmap ('x', '<leader>y', '"+y')
kmap ('n', '<leader>P', '<cmd>set paste<CR>"+p<cmd>set nopaste<CR>')

-- diagnostics
kmap('n', '[d', vim.diagnostic.goto_prev)
kmap('n', ']d', vim.diagnostic.goto_next)
kmap('n', '<leader>e', vim.diagnostic.open_float)
kmap('n', '<leader>q', vim.diagnostic.setloclist)

