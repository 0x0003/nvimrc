---@param t table
---@return table
local function conf_generic(t)
  local r = {}
  for _, a in ipairs(t) do
    r[a] = { glyph = '' }
  end
  return r
end
local conf_t = conf_generic({
  'conf', 'rc', 'cfg', 'ini'
})

local extension = {
  -- common
  xml = {
    glyph = '󰗀',
    hl = 'MiniIconsYellow'
  },
  org = {
    glyph = '',
    hl = 'MiniIconsCyan'
  },
  lua = {
    hl = 'MiniIconsBlue'
  },
  -- shell scripts
  fish = {
    glyph = '󰈺',
  },
  sh = {
    glyph = '󱆃',
  },
  zsh = {
    glyph = '󱆃',
  },
  -- misc
  lock = {
    glyph = '󰌾',
    hl = 'MiniIconsGreen'
  },
  history = {
    glyph = ''
  },
}
for x, y in pairs(conf_t) do
  extension[x] = y
end

local file = {
  ['.ghci'] = {
    glyph = '󰲒',
    hl = 'MiniIconsYellow'
  },
  ['.envrc'] = {
    glyph = '',
    hl = 'MiniIconsGreen'
  },
  makefile = {
    hl = 'MiniIconsGreen'
  },
  ['fish_variables'] = {
    glyph = '󰻳',
  },
  ['README'] = {
    glyph = '󰈙'
  },
  ['README.md'] = {
    glyph = '󰈙'
  },
}

require('mini.icons').setup({
  extension = extension,
  file = file,
})

require('mini.icons').mock_nvim_web_devicons()

