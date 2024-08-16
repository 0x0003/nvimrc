-- remove all trailing whitespaces in current buffer
Com('Trim', function()
  local save = vim.fn.winsaveview()
  vim.cmd([[%s/\s\+$//ge]])
  vim.cmd.nohlsearch()
  vim.fn.winrestview(save)
end, {})

-- print file info
Com('FF', function()
  local sep = ' | '
  local pth = vim.fn.expand('%:p') .. ': '
  local typ = vim.bo.filetype .. sep
  local enc = vim.bo.fileencoding .. sep
  local fmt = vim.bo.fileformat .. sep
  local lne = vim.fn.line('$') .. ' lines'
  print(pth .. typ .. enc .. fmt .. lne)
end, {})

-- set sw and sts to 2
Com('Swdefault', function()
  vim.opt_local.shiftwidth = 2
  vim.opt_local.softtabstop = 2
end, {})

