-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25
vim.g.netrw_list_hide = '&wildignore'

vim.keymap.set ('n', '<leader>E', vim.cmd.Lex, { noremap = true, silent = true })
-- vim.keymap.set ('n', '<leader>E', vim.cmd.Ex, {silent = true})

vim.api.nvim_create_autocmd ( 'Filetype', {
  pattern = 'netrw',
  group = vim.api.nvim_create_augroup('ntrw', { clear = true}),
  command = ':nnoremap <buffer> <silent> <C-l> <C-w>l<CR>',
})

