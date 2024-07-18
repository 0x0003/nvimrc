local base16 = require('base16-colorscheme')

vim.cmd('hi clear')

Palette = 'main'

local palette_exists, c = pcall(require, 'colors.' .. Palette)

if palette_exists then
  base16.setup(c)
else
  Palette = 'main'
  c = require('colors.' .. Palette)
  base16.setup(c)
end

---@param group string
---@param fg string|nil
---@param bg? string|nil
local function hl(group, fg, bg)
  if fg == nil then fg = 'none' end
  if bg == nil then bg = 'none' end
  vim.cmd('hi ' .. group .. ' guifg=' .. fg .. ' guibg=' .. bg)
end

-- statusline
hl('StatusNormal', c.base06)
hl('StatusActive', c.base03)
hl('StatusLine', c.base02)
hl('StatusLineNC', c.base02)
hl('StatusLineNCSep', c.base01)
hl('StatusReplace', c.base08)
hl('StatusInsert', c.base0B)
hl('StatusCommand', c.base0A)
hl('StatusVisual', c.base0D)
hl('StatusTerminal', c.base0E)
hl('StatusFile', c.base09)

-- tabline
hl('TabLine', c.base02, c.base00)
hl('TabLineSel', c.base06, c.base00)
hl('TabLineFill', c.base00)

-- popup menu
hl('Pmenu', nil, c.base01)
hl('PmenuSbar', nil, c.base01)
hl('PmenuThumb', nil, c.base01)
hl('PmenuSel', nil, c.base02)

-- numbers
hl('CursorLine', nil, c.base01)
hl('CursorLineNr', c.base04, c.base01)
hl('LineNr', c.base03)

-- spellcheck
hl('SpellBad', c.base08)
hl('SpellCap', c.base09)
hl('SpellRare', c.base0E)
hl('SpellLocal', c.base0C)

-- diff
hl('DiffAdd', c.base0B, c.diff0B)
hl('DiffDelete', c.base08, c.diff08)
hl('DiffChange', c.base0F, c.diff0D)
hl('DiffText', c.base0D, c.diff0D)

-- floating windows
hl('NormalFloat', nil, c.popup00)
hl('FloatBorder', c.base06, c.popup00)

-- misc
hl('WinSeparator', c.base01, nil)
hl('ColorColumn', nil, c.base01)
hl('Search', c.base00, c.base0B) -- hlsearch

-- fzf-lua
hl('FzfLuaHeaderBind', c.base09)
hl('FzfLuaHeaderText', c.base08)
hl('FzfLuaPathColNr', c.base0D)
hl('FzfLuaPathLineNr', c.base0B)
hl('FzfLuaBufName', c.base0E)
hl('FzfLuaBufNr', c.base09)
hl('FzfLuaBufFlagCur', c.base08)
hl('FzfLuaBufFlagAlt', c.base0D)
hl('FzfLuaTabTitle', c.base0C)
hl('FzfLuaTabMarker', c.base09)
hl('FzfLuaLiveSym', c.base08)
hl('FzfLuaBorder', c.base01)
hl('FzfLuaDirPart', c.base06)
hl('FzfLuaPreviewTitle', c.base03)

-- cmp
hl('CmpItemAbbrMatch', c.base05)
hl('CmpItemAbbrMatchFuzzy', c.base05)
hl('CmpItemAbbr', c.base03)
hl('CmpItemKind', c.base0E)
hl('CmpItemMenu', c.base0E)
hl('CmpItemKindSnippet', c.base0E)

-- indent-blankline.nvim
hl('IblScope', c.base03)
hl('IblIndent', c.base02)

-- mini.icons
hl('MiniIconsAzure', c.extra0D)
hl('MiniIconsBlue', c.base0D)
hl('MiniIconsCyan', c.base0C)
hl('MiniIconsGreen', c.base0B)
hl('MiniIconsGrey', c.extra04)
hl('MiniIconsOrange', c.extra09)
hl('MiniIconsPurple', c.base0E)
hl('MiniIconsRed', c.base08)
hl('MiniIconsYellow', c.base0A)

-- treesitter
vim.api.nvim_set_hl(0, '@markup.strikethrough.markdown_inline', { link = 'htmlStrike' })

-- generic comments
vim.cmd('hi Comment gui=italic')

