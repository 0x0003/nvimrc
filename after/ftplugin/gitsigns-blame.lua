-- make `s` fire instantly
vim.schedule(function()
  local mapdef = vim.fn.maparg('s', 'n', false, true)
  if mapdef and mapdef.buffer == 1 and mapdef.callback then
    vim.keymap.set('n', 's', mapdef.callback, {
      buffer = vim.api.nvim_get_current_buf(),
      nowait = true, noremap = true, silent = true
    })
  end
end)

