local h = require('snippets.helpers')

local appl = h.s(
  {
    trig = '-',
    dscr = 'Function application',
    hidden = true
  },
  h.fmt([[
  {} -> {}
  ]], {
    h.i(1, 'a'),
    h.i(2, 'a'),
  }))
table.insert(h.snippets, appl)

local appl_parens = h.s(
  {
    trig = '(-',
    dscr = 'Function application inside parens',
    hidden = true
  },
  h.fmt([[
  ({} -> {}
  ]], {
    h.i(1, 'a'),
    h.i(2, 'a'),
  }))
table.insert(h.autosnippets, appl_parens)

local type_constraint = h.s(
  {
    trig = '=',
    dscr = 'Type constraint',
    hidden = true
  },
  {
    h.i(1, 'Type'),
    h.t(' => ')
  }
)
table.insert(h.snippets, type_constraint)

local new_function = h.s(
  {
    trig = '::([%w_]+)',
    dscr = 'New function',
    regTrig = true,
    hidden = true
  },
  h.fmt([[
  {} :: {}
  {}{} = {}
  ]], {
    h.d(1, function(_, snip)
      return h.sn(1, h.i(1, snip.captures[1]))
    end),
    h.i(2, 'a -> a'),
    h.rep(1),
    h.i(3),
    h.i(4, 'undefined')
  }))
table.insert(h.snippets, new_function)

local list_comprehension = h.s(
  {
    trig = '|',
    dscr = 'List comprehension',
    hidden = true
  },
  h.fmt([[
  [{} | {} <- {}]
  ]], {
    h.i(1, 'x'),
    h.rep(1),
    h.i(2, 'xs'),
  }))
table.insert(h.snippets, list_comprehension)

local deriving = h.s(
  {
    trig = 'der',
    dscr = 'Deriving'
  },
  {
    h.t('deriving '),
    h.i(1, '(Eq, Show)')
  })
table.insert(h.snippets, deriving)

local newtype = h.s(
  {
    trig = 'nt',
    dscr = 'Newtype'
  },
  h.fmt([[
  newtype {} = {} {}
  ]], {
    h.i(1, 'a'),
    h.rep(1),
    h.i(2, 'Int'),
  }))
table.insert(h.snippets, newtype)

local pragma = h.s(
  {
    trig = 'pr',
    dscr = 'Language pragma'
  },
  h.fmt([[
  {{-# LANGUAGE {} #-}}
  ]], {
    h.i(1, 'GeneralizedNewtypeDeriving'),
  }))
table.insert(h.snippets, pragma)

return h.snippets, h.autosnippets

