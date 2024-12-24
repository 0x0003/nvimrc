local g = require('grapple')

---@diagnostic disable-next-line: missing-fields
g.setup({
  scope = 'cwd',
  win_opts = {
    border = { '─', '─', '─', '', '', '', '', '' },
    row = 0.99,
    col = 0.5,
    width = 0.99,
    height = 0.44,
  }
})

---@param f function
---@param extra? table
local function input(f, extra)
  local char = vim.fn.getcharstr()
  -- literal escape character (see `:help i_CTRL-V`)
  if char == '' then
    return
  else
    local opts = { name = char }
    if extra ~= nil then
      for x, y in pairs(extra) do
        opts[x] = y
      end
    end
    return f(opts)
  end
end

-- mapping followed by <char> creates a tag named <char>
Kmap('n', '<leader>m', function()
    -- in oil buffers tag the file under the cursor instead
    if vim.bo.filetype == 'oil' then
      local oil = require('oil')
      local dir = oil.get_current_dir()
      local file = oil.get_cursor_entry().name
      input(g.tag, { path = require('grapple.path').join(dir, file) })
    else
      input(g.tag)
    end
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

