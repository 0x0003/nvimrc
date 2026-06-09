local ls = require('luasnip')

local M = {}

M.s  = ls.s -- snippet
M.i  = ls.i -- insert node
M.t  = ls.t -- text node

M.d  = ls.dynamic_node
M.c  = ls.choice_node
M.f  = ls.function_node
M.sn = ls.snippet_node

M.fmt = require('luasnip.extras.fmt').fmt
M.rep = require('luasnip.extras').rep

-- shared snippet containers
M.snippets = {}
M.autosnippets = {}

return M

