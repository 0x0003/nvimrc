---@diagnostic disable: unused-local
-- boilerplate
local ls = require("luasnip")

local s = ls.s -- snippet
local i = ls.i -- instert
local t = ls.t -- text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.lua"

-- lua start
--
-- `important!;`
local imp = s("!;",
  { t("!important;") }
)
table.insert(autosnippets, imp)

-- module end
return snippets, autosnippets
