local present, base16 = pcall (require, 'base16-colorscheme')

if not present then
  return
end

local color = {
  b00 = "#121212",
  b01 = "#1f1f1f",
  b02 = "#282828",
  -- b03 = "#3b3b3b",
  b03 = "#555555",
  b04 = "#e8e3e3",
  b05 = "#e8e3e3",
  b06 = "#e8e3e3",
  b07 = "#e8e3e3",
  b08 = "#b66467",
  b09 = "#d9bc8c",
  b0A = "#d9bc8c",
  b0B = "#8c977d",
  b0C = "#8aa6a2",
  b0D = "#8da3b9",
  b0E = "#a988b0",
  b0F = "#747272"
}

base16.setup({
base00 = color.b00, base01 = color.b01, base02 = color.b02, base03 = color.b03,
base04 = color.b04, base05 = color.b05, base06 = color.b06, base07 = color.b07,
base08 = color.b08, base09 = color.b09, base0A = color.b0A, base0B = color.b0B,
base0C = color.b0C, base0D = color.b0D, base0E = color.b0E, base0F = color.b0F,
})

-- highlights
local function hl(highlight, fg, bg)
  if fg == nil then fg = "none" end
  if bg == nil then bg = "none" end
  vim.cmd("hi " .. highlight .. " guifg=" .. fg .. " guibg=" .. bg)
end

-- status Line
hl("StatusNormal")
hl("StatusLineNC", color.b03)
hl("StatusActive", color.b05)
hl("StatusLine", color.b02) -- inactive
hl("StatusReplace", color.b08)
hl("StatusInsert", color.b0B)
hl("StatusCommand", color.b0A)
hl("StatusVisual", color.b0D)
hl("StatusTerminal", color.b0E)

-- telescope
hl("TelescopePromptBorder", color.b01, color.b01)
hl("TelescopePromptNormal", nil, color.b01)
hl("TelescopePromptPrefix", color.b08, color.b01)
hl("TelescopeSelection", nil, color.b01)

-- menu
hl("Pmenu", nil, color.b01)
hl("PmenuSbar", nil, color.b01)
hl("PmenuThumb", nil, color.b01)
hl("PmenuSel", nil, color.b02)

-- cmp
hl("CmpItemAbbrMatch", color.b05)
hl("CmpItemAbbrMatchFuzzy", color.b05)
hl("CmpItemAbbr", color.b03)
hl("CmpItemKind", color.b0E)
hl("CmpItemMenu", color.b0E)
hl("CmpItemKindSnippet", color.b0E)

-- numbers
hl("CursorLine", nil, color.b01)
hl("CursorLineNr", color.b04, color.b01)
hl("LineNr", color.b03)

-- misc
hl("VertSplit", color.b01, nil)
hl("NormalFloat", nil, color.b01)
hl("FloatBorder", color.b01, color.b01)
hl("ColorColumn", nil, color.b01) -- colorcolumn
hl("Search", color.b00, color.b0B) -- hlsearch

-- extra
vim.cmd("hi Comment gui=italic")

