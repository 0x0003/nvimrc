-- set leader to spacebar
vim.g.mapleader = ' '

_G.colorscheme = 'main'

local modules = {
  'options',
  'plugins',
  'colors',
  'remaps',
  'statusline',
  'jp',
  'sessions',
}

for _, a in ipairs(modules) do
  local ok, err = pcall(require, a)
  if not ok then
    error('Error calling ' .. a .. err)
  end
end

-- set POSIX compatible shell if using fish
local os_shell = os.getenv('SHELL')
if os_shell ~= nil and string.match(os_shell, 'fish') == 'fish' then
  vim.o.shell = 'sh'
end

-- highlight on yank `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- jump to last known cursor position when opening a file
vim.api.nvim_create_autocmd('BufRead', {
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match('commit') and ft:match('rebase'))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})

-- disable cursorline in insert mode and in inactive windows
local cline = vim.api.nvim_create_augroup('cline', { clear = true })
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
  pattern = '*',
  group = cline,
  command = 'setlocal cursorline',
})
vim.api.nvim_create_autocmd({ 'WinLeave' }, {
  pattern = '*',
  group = cline,
  command = 'setlocal nocursorline',
})
vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  group = cline,
  command = 'set nocursorline'
})
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  group = cline,
  command = 'set cursorline'
})

-- remove all trailing whitespaces
function Trimspaces()
  local save = vim.fn.winsaveview()
  vim.cmd([[%s/\s\+$//ge]])
  vim.fn.winrestview(save)
end
vim.api.nvim_create_user_command('Trim', function() Trimspaces() end, {})

