local h = require('snippets.helpers')

local generic = h.s(
  {
    trig = '$',
    dscr = "Generic LaTeX expression"
  },
  h.fmt([[
  ${{{}}}$
  ]], {
    h.i(1, 'text'),
  }))
table.insert(h.snippets, generic)

local superscript = h.s(
  {
    trig = 'lsup',
    dscr = 'LaTeX superscript'
  },
  h.fmt([[
  $\textsuperscript{{{}}}$
  ]], {
    h.i(1, 'TEXT'),
  }))
table.insert(h.snippets, superscript)

local subscript = h.s(
  {
    trig = 'lsub',
    dscr = 'LaTeX subscript'
  },
  h.fmt([[
  $\textsubscript{{{}}}$
  ]], {
    h.i(1, 'TEXT'),
  }))
table.insert(h.snippets, subscript)

local stackrel = h.s(
  {
    trig = 'stack',
    dscr = 'LaTeX stackrel'
  },
  h.fmt([[
  ${{\stackrel{{\text{{{}}}}}{{\text{{{}}}}}}}$
  ]], {
    h.i(1, 'UPPER'),
    h.i(2, 'NORMAL'),
  }))
table.insert(h.snippets, stackrel)

local underset = h.s(
  {
    trig = 'under',
    dscr = 'LaTeX underset'
  },
  h.fmt([[
  ${{\underset{{\text{{{}}}}}{{\text{{{}}}}}}}$
  ]], {
    h.i(1, 'LOWER'),
    h.i(2, 'NORMAL'),
  }))
table.insert(h.snippets, underset)

local furigana = h.s(
  {
    trig = 'furi',
    dscr = 'LaTeX furigana'
  },
  h.fmt([[
  $\ruby{{{}}}{{{}}}$
  ]], {
    h.i(1, 'WORD'),
    h.i(2, 'READING'),
  }))
table.insert(h.snippets, furigana)

local href = h.s(
  {
    trig = 'href',
    dscr = 'LaTeX href'
  },
  h.fmt([[
  $\href{{{}}}{{{}}}$
  ]], {
    h.i(1, 'LINK'),
    h.i(2, 'TEXT'),
  }))
table.insert(h.snippets, href)

return h.snippets, h.autosnippets

