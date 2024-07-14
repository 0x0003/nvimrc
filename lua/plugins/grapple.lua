local g = require('grapple')

g.setup({
  scope = 'cwd',
  win_opts = {
    border = { '─', '─', '─', '', '', '', '', '' },
    row = 0.99,
    col = 0.5,
    width = 0.99,
    height = 0.45,
  }
})

---@return string|nil
local function input()
  local char = vim.fn.getcharstr()
  if char == '' then
    return
  else
    return char
  end
end

Kmap('n', '<leader>m', function()
    if vim.bo.filetype == 'oil' then
      local oil = require('oil')
      local dir = oil.get_current_dir()
      local file = oil.get_cursor_entry().name
      g.tag({
        name = input(),
        path = require('grapple.path').join(dir, file)
      })
    else
      g.tag({ name = input() })
    end
  end,
  'Grapple: tag current file')

Kmap('n', '<leader>j', function()
    g.select({ name = input() })
  end,
  'Grapple: jump to tag by name')

for i = 1, 9 do
  Kmap('n', '<leader>' .. i, function()
      return g.select({ index = i })
    end,
    'Grapple: jump to index ' .. i)
end

Kmap('n', '<leader>J', g.toggle_tags,
  'Grapple: list tags')

Kmap('n', '<leader>p', function()
    g.cycle_tags('prev', { scope = 'cwd' })
  end,
  'Grapple: prev')
Kmap('n', '<leader>n', function()
    g.cycle_tags('next', { scope = 'cwd' })
  end,
  'Grapple: next')
