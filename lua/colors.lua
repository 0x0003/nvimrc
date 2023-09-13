local theme = _G.colorscheme

local present, base16 = pcall(require, 'base16-colorscheme')
if not present then
  return
end

local colo_present, color = pcall(require, "colors." .. theme)
if colo_present then
  base16.setup(color)
else
  -- default to "main" if set colorscheme doesn't exist
  _G.colorscheme = "main"
  color = require("colors." .. _G.colorscheme)
  base16.setup(color)
end

-- highlights
local function hl(highlight, fg, bg)
  if fg == nil then fg = 'none' end
  if bg == nil then bg = 'none' end
  vim.cmd('hi ' .. highlight .. ' guifg=' .. fg .. ' guibg=' .. bg)
end

-- status Line
hl('StatusNormal')
hl('StatusLineNC', color.base03)
hl('StatusActive', color.base05)
hl('StatusLine', color.base03)
hl('StatusReplace', color.base08)
hl('StatusInsert', color.base0B)
hl('StatusCommand', color.base0A)
hl('StatusVisual', color.base0D)
hl('StatusTerminal', color.base0E)

-- telescope
hl('TelescopePromptBorder', color.base01, color.base01)
hl('TelescopePromptNormal', nil, color.base01)
hl('TelescopePromptPrefix', color.base08, color.base01)
hl('TelescopeSelection', nil, color.base01)

-- menu
hl('Pmenu', nil, color.base01)
hl('PmenuSbar', nil, color.base01)
hl('PmenuThumb', nil, color.base01)
hl('PmenuSel', nil, color.base02)

-- cmp
hl('CmpItemAbbrMatch', color.base05)
hl('CmpItemAbbrMatchFuzzy', color.base05)
hl('CmpItemAbbr', color.base03)
hl('CmpItemKind', color.base0E)
hl('CmpItemMenu', color.base0E)
hl('CmpItemKindSnippet', color.base0E)

-- numbers
hl('CursorLine', nil, color.base01)
hl('CursorLineNr', color.base04, color.base01)
hl('LineNr', color.base03)

-- misc
hl('VertSplit', color.base01, nil)
hl('NormalFloat', nil, color.base01)
hl('FloatBorder', color.base01, color.base01)
hl('ColorColumn', nil, color.base01)     -- colorcolumn
hl('Search', color.base00, color.base0B) -- hlsearch

-- extra
vim.cmd('hi Comment gui=italic')

