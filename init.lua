---@diagnostic disable: lowercase-global
-- set leader to spacebar
vim.g.mapleader = ' '

-- shorter vim.keymap.set()
function kmap(mode, keys, command, extra)
  local opts = { noremap = true, silent = true }
  if extra ~= nil then
    for x, y in pairs(extra) do
      opts[x] = y
    end
  end
  vim.keymap.set(mode, keys, command, opts)
end

local modules = {
  'options',
  'plugins',
  'autocommands',
  'remaps',
  'statusline',
  'usercommands',
  'sessions'
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

