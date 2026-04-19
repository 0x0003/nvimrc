local parsers = {
  'c', 'haskell', 'nix', 'lua', 'python', 'bash', 'fish',
  'javascript', 'typescript', 'vimdoc', 'vim', 'css', 'html',
  'yaml', 'toml', 'markdown', 'markdown_inline', 'regex'
}

local already_installed = require('nvim-treesitter.config').get_installed()
local to_install = vim.iter(parsers):filter(function(parser)
  return not vim.tbl_contains(already_installed, parser)
end):totable()
require('nvim-treesitter').install(to_install)

Auc('FileType', {
  group = Aug('treesitter-start', { clear = true }),
  callback = function()
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = 'v:lua.require(\'nvim-treesitter\').indentexpr()'
  end
})

require('nvim-treesitter-textobjects').setup {
  select = {
    lookahead = true,
    selection_modes = {
      ['@parameter.outer'] = 'v', -- charwise
      ['@function.outer'] = 'V', -- linewise
      ['@class.outer'] = '<c-v>', -- blockwise
    },
  },
  move = {
    set_jumps = true
  }
}

local tsse = require('nvim-treesitter-textobjects.select')
local tssw = require('nvim-treesitter-textobjects.swap')
local tsmv = require('nvim-treesitter-textobjects.move')

-- NOTE: 'm' for 'method'
Kmap({ 'x', 'o' }, 'am', function()
    tsse.select_textobject('@function.outer', 'textobjects')
  end,
  'Treesitter-select: function outer')
Kmap({ 'x', 'o' }, 'im', function()
    tsse.select_textobject('@function.inner', 'textobjects')
  end,
  'Treesitter-select: function inner')
Kmap({ 'x', 'o' }, 'ac', function()
    tsse.select_textobject('@class.outer', 'textobjects')
  end,
  'Treesitter-select: class outer')
Kmap({ 'x', 'o' }, 'ic', function()
    tsse.select_textobject('@class.inner', 'textobjects')
  end,
  'Treesitter-select: class inner')

Kmap('n', '<leader>>', function()
    tssw.swap_next '@parameter.inner'
  end,
  'Treesitter-swap: next')
Kmap('n', '<leader><', function()
    tssw.swap_previous '@parameter.outer'
  end,
  'Treesitter-swap: prev')

Kmap ({ 'n', 'x', 'o' }, ']m', function()
  tsmv.goto_next_start('@function.outer', 'textobjects')
  end,
  'Treesitter-goto: next start function outer')
Kmap ({ 'n', 'x', 'o' }, ']M', function()
  tsmv.goto_next_end('@function.outer', 'textobjects')
  end,
  'Treesitter-goto: next end function outer')
Kmap ({ 'n', 'x', 'o' }, '[m', function()
  tsmv.goto_previous_start('@function.outer', 'textobjects')
  end,
  'Treesitter-goto: prev start function outer')
Kmap ({ 'n', 'x', 'o' }, '[M', function()
  tsmv.goto_previous_end('@function.outer', 'textobjects')
  end,
  'Treesitter-goto: prev end function outer')

Kmap ({ 'n', 'x', 'o' }, ']]', function()
  tsmv.goto_next_start('@class.outer', 'textobjects')
  end,
  'Treesitter-goto: next start class outer')
Kmap ({ 'n', 'x', 'o' }, '][', function()
  tsmv.goto_next_end('@class.outer', 'textobjects')
  end,
  'Treesitter-goto: next end class outer')
Kmap ({ 'n', 'x', 'o' }, '[[', function()
  tsmv.goto_previous_start('@class.outer', 'textobjects')
  end,
  'Treesitter-goto: prev start class outer')
Kmap ({ 'n', 'x', 'o' }, '[]', function()
  tsmv.goto_previous_end('@class.outer', 'textobjects')
  end,
  'Treesitter-goto: prev end class outer')

