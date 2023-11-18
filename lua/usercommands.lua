local command = vim.api.nvim_create_user_command

-- remove all trailing whitespaces in active buffer
command('Trim', function()
  local save = vim.fn.winsaveview()
  vim.cmd([[%s/\s\+$//ge]])
  vim.cmd.nohlsearch()
  vim.fn.winrestview(save)
end, {})

-- print file info
command('FF', function()
  local sep = ' | '
  local pth = vim.fn.expand('%:p') .. ': '
  local typ = vim.bo.filetype .. sep
  local enc = vim.bo.fileencoding .. sep
  local fmt = vim.bo.fileformat .. sep
  local lne = vim.fn.line('w$') .. ' lines, '
  local chr = string.match((vim.fn.execute('!wc -m %')), '%d+') .. ' characters'
  print(pth .. typ .. enc .. fmt .. lne .. chr)
end, {})

-- set sw and sts to 2
command('Swdefault', function()
  vim.opt_local.shiftwidth = 2
  vim.opt_local.softtabstop = 2
end, {})

