-- set leader to spacebar
vim.g.mapleader = ' '

---shorter vim.keymap.set()
---@param mode string|string[]
---@param keys string
---@param command string|function
---@param description string
---@param extra? table
function Kmap(mode, keys, command, description, extra)
  local opts = { desc = description, noremap = true, silent = true }
  if extra ~= nil then
    for x, y in pairs(extra) do
      opts[x] = y
    end
  end
  vim.keymap.set(mode, keys, command, opts)
end

-- autocmd
Auc = vim.api.nvim_create_autocmd
Aug = vim.api.nvim_create_augroup

-- user-command
Com = vim.api.nvim_create_user_command

---check if running under wsl
---@return boolean
function IsWSL()
  return os.getenv('WSL_DISTRO_NAME') ~= nil
end

---transform windows paths for `gf` on wsl
---@param fname string
---@return string
function WSLpath(fname)
  if fname:sub(1, 1) == '/' then
    return fname
  end
  local result = fname:gsub('\\', '/')
  if result:sub(1, 2) == '//' then
    return result
  end
  local drive = result:match('^([A-Za-z]):/')
  if drive then
    return '/mnt/' .. drive:lower() .. result:sub(3)
  end
  return result
end

