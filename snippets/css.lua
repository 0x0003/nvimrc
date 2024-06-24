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
-- `important!;`
local imp = s('!;',
  { t('!important;') }
)
table.insert(autosnippets, imp)

return snippets, autosnippets

