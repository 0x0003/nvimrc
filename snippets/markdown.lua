---@diagnostic disable: unused-local
-- boilerplate
local ls = require('luasnip')

local s = ls.s -- snippet
local i = ls.i -- insert node
local t = ls.t -- text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

local snippets, autosnippets = {}, {}

local group = Aug('Lua Snippets', { clear = true })
local file_pattern = '*.lua'

--
-- generic latex expression
local texgeneric = s('lex', fmt([[
${{{}}}$
]], {
  i(1, 'text'),
}))
table.insert(snippets, texgeneric)

-- latex superscript
local superscript = s('lsup', fmt([[
  $\textsuperscript{{{}}}$
  ]], {
  i(1, 'TEXT'),
}))
table.insert(snippets, superscript)

-- latex subscript
local subscript = s('lsub', fmt([[
  $\textsubscript{{{}}}$
  ]], {
  i(1, 'TEXT'),
}))
table.insert(snippets, subscript)

-- latex stackrel
local stackrel = s('stack', fmt([[
  ${{\stackrel{{\text{{{}}}}}{{\text{{{}}}}}}}$
  ]], {
  i(1, 'UPPER'),
  i(2, 'NORMAL'),
}))
table.insert(snippets, stackrel)

-- latex underset
local underset = s('under', fmt([[
  ${{\underset{{\text{{{}}}}}{{\text{{{}}}}}}}$
  ]], {
  i(1, 'LOWER'),
  i(2, 'NORMAL'),
}))
table.insert(snippets, underset)

-- latex furigana
local furigana = s('furi', fmt([[
  $\ruby{{{}}}{{{}}}$
  ]], {
  i(1, 'WORD'),
  i(2, 'READING'),
}))
table.insert(snippets, furigana)

-- latex href
local href = s('href', fmt([[
  $\href{{{}}}{{{}}}$
  ]], {
  i(1, 'LINK'),
  i(2, 'TEXT'),
}))
table.insert(snippets, href)

return snippets, autosnippets

