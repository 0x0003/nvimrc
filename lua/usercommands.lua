-- remove all trailing whitespaces in active buffer
vim.api.nvim_create_user_command('Trim', function()
  local save = vim.fn.winsaveview()
  vim.cmd([[%s/\s\+$//ge]])
  vim.cmd.nohlsearch()
  vim.fn.winrestview(save)
end, {})

-- print file info
vim.api.nvim_create_user_command('FF', function()
  local sep = ' | '
  local pth = vim.fn.expand('%:p') .. ': '
  local typ = vim.bo.filetype .. sep
  local enc = vim.bo.fileencoding .. sep
  local fmt = vim.bo.fileformat .. sep
  local lne = vim.fn.line('w$') .. ' lines, '
  local chr = string.match((vim.fn.execute('!wc -m %')), '%d+') .. ' characters'
  print(pth .. typ .. enc .. fmt .. lne .. chr)
end, {})

