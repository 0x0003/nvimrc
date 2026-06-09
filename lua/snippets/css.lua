local h = require('snippets.helpers')

local imp = h.s(
  {
    trig = '!;',
    dscr = '!important;',
    hidden = true
  },
  { h.t('!important;') }
)
table.insert(h.autosnippets, imp)

local imp_typo = h.s(
  {
    trig = '!:',
    dscr = '!important;',
    hidden = true
  },
  { h.t('!important;') }
)
table.insert(h.autosnippets, imp_typo)

return h.snippets, h.autosnippets

