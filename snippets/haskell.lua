---@diagnostic disable: unused-local
-- boilerplate
local ls = require("luasnip")

local s = ls.s -- snippet
local i = ls.i -- instert node
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

-- haskell start
--
-- function application
local appl = s({ trig = "-", hidden = true }, fmt([[
{} -> {}
]], {
    i(1, "a"),
    i(2, "a"),
}))
table.insert(snippets, appl)

-- function application inside parens
local applp = s("(-", fmt([[
({} -> {}
]], {
  i(1, "a"),
  i(2, "a"),
}))
table.insert(autosnippets, applp)

-- type constraint
local typec = s({ trig = "=", hidden = true },
  {
    i(1, "Type"),
    t(" => ")
  }
)
table.insert(snippets, typec)

-- new function
local newfun = s({ trig = "::([%w_]+)", regTrig = true, hidden = true }, fmt([[
{} :: {}
{}{} = {}
]], {
  d(1, function(_, snip)
    return sn(1, i(1, snip.captures[1]))
  end),
  i(2, "a -> a"),
  rep(1),
  i(3),
  i(4, "undefined")
}))
table.insert(snippets, newfun)

-- list comprehension
local listc = s({ trig = "|", hidden = true }, fmt([[
[{} | {} <- {}]
]], {
  i(1, "x"),
  rep(1),
  i(2, "xs"),
}))
table.insert(snippets, listc)

-- deriving
local der = s("der", {
  t("deriving "),
  i(1, "(Eq, Show)")
})
table.insert(snippets, der)

-- newtype
local newt = s("nt", fmt([[
newtype {} = {} {}
]], {
  i(1, "a"),
  rep(1),
  i(2, "Int"),
}))
table.insert(snippets, newt)

-- language pragma
local pragma = s("pr", fmt([[
{{-# LANGUAGE {} #-}}
]], {
  i(1, "GeneralizedNewtypeDeriving"),
}))
table.insert(snippets, pragma)

-- module end
return snippets, autosnippets

