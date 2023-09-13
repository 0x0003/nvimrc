local sessiondir = vim.fn.stdpath('config') .. '/.sessions' .. vim.fn.getcwd()
local sessionfile = sessiondir .. '/session.vim'

function SessionMake()
  if vim.fn.filewritable(sessiondir) ~= 2 then
    os.execute('mkdir -p ' .. sessiondir)
  end
  vim.cmd.mksession({ bang = true, args = { sessionfile } })
end

function SessionLoad()
  if vim.fn.filereadable(sessionfile) == 1 then
    vim.cmd.source(sessionfile)
  else
    print('No session loaded.')
  end
end

local sess = vim.api.nvim_create_augroup('sess', { clear = true })
-- automatically load session if launched without arguments
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  pattern = '*',
  group = sess,
  nested = true,
  callback = function()
    if vim.fn.argc() == 0 then
      SessionLoad()
    end
  end
})
-- automatically create session on exit
vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  pattern = '*',
  group = sess,
  callback = function()
    SessionMake()
  end
})

