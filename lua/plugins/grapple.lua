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

---@param f function
---@return string|nil
local function input(f)
  local char = vim.fn.getcharstr()
  if char == '' then
    return
  else
    return f({ name = char })
  end
end

Kmap('n', '<leader>m', function()
    input(g.tag)
  end,
  'Grapple: tag current file')

Kmap('n', '<leader>j', function()
    input(g.select)
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

