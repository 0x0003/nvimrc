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

local function hl(group, fg, bg)
  if fg == nil then fg = 'none' end
  if bg == nil then bg = 'none' end
  vim.cmd('hi ' .. group .. ' guifg=' .. fg .. ' guibg=' .. bg)
end

-- statusline
hl('StatusNormal', c.base06)
hl('StatusActive', c.base06)
hl('StatusLine', c.base03)
hl('StatusLineNC', c.base02)
hl('StatusLineNCSep', c.base01)
hl('StatusReplace', c.base08)
hl('StatusInsert', c.base0B)
hl('StatusCommand', c.base0A)
hl('StatusVisual', c.base0D)
hl('StatusTerminal', c.base0E)
hl('StatusFile', c.base0A)

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

-- misc
hl('WinSeparator', c.base01, nil)
hl('NormalFloat', nil, c.base01)
hl('FloatBorder', c.base01, c.base01)
hl('ColorColumn', nil, c.base01)
hl('Search', c.base00, c.base0B) -- hlsearch

-- telescope
hl('TelescopePromptTitle', nil, c.base0A)
hl('TelescopePreviewTitle', nil, nil)
hl('TelescopePromptBorder', c.base01, c.base01)
hl('TelescopePromptNormal', c.base04, c.base01)
hl('TelescopePromptPrefix', c.base04, c.base01)
hl('TelescopeSelection', nil, c.base01)

-- cmp
hl('CmpItemAbbrMatch', c.base05)
hl('CmpItemAbbrMatchFuzzy', c.base05)
hl('CmpItemAbbr', c.base03)
hl('CmpItemKind', c.base0E)
hl('CmpItemMenu', c.base0E)
hl('CmpItemKindSnippet', c.base0E)

-- harpoon
hl('HarpoonWindow', nil, c.base00)
hl('HarpoonBorder', c.base00, c.base00)

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

