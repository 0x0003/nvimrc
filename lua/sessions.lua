local sessiondir = vim.fn.stdpath('config') .. '/.sessions' .. vim.fn.getcwd()
local sessionfile = sessiondir .. '/session.vim'

function SessionMake()
  if vim.fn.filewritable(sessiondir) ~= 2 then
    os.execute('mkdir -p ' .. vim.fn.shellescape(sessiondir, true))
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

local sess = Aug('sess', { clear = true })
-- automatically load session if launched without arguments
Auc({ 'VimEnter' }, {
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
Auc({ 'VimLeave' }, {
  pattern = '*',
  group = sess,
  callback = function()
    SessionMake()
  end
})

