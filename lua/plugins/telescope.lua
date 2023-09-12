local present, telescope = pcall(require, 'telescope')

if not present then
  return
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = require('telescope.actions').delete_buffer,
      },
      n = {
        ['<C-h>'] = 'which_key',
        ['<C-d>'] = require('telescope.actions').delete_buffer,
      },
    },
    file_ignore_patterns = {
      '%.jpg',
      '%.jpeg',
      '%.png',
    },
    prompt_prefix = '  ',
    selection_caret = '  ',
    entry_prefix = '  ',
    layout_strategy = 'bottom_pane',
    sorting_strategy = 'ascending', -- display results top -> bottom
    layout_config = {
      preview_width = 0.6,
      height = 25,
      prompt_position = 'top'
    },
  },

  extensions = {
    file_browser = {
      hijack_netrw = true,
      disable_devicons = true,
      previewer = false,
      layout_strategy = 'horizontal',
      initial_mode = 'normal',
      layout_config = {
        width = 100,
        height = 50,
        prompt_position = 'top'
      },
    },

    ['ui-select'] = {
      layout_strategy = 'cursor',
      initial_mode = 'normal',
      layout_config = {
        height = 10,
        width = 80,
        prompt_position = 'top'
      },
    },

    undo = {
      user_delta = false,
      initial_mode = 'normal',
      layout_strategy = 'horizontal',
      layout_config = {
        preview_width = 0.6,
        width = 500,
        height = 500,
      },
      mappings = {
        i = {
          ['<CR>'] = require('telescope-undo.actions').restore,
        },
        n = {
          ['<CR>'] = require('telescope-undo.actions').restore,
          ['y'] = require('telescope-undo.actions').yank_additions,
          ['d'] = require('telescope-undo.actions').yank_deletions,
        }
      },
    },
  }
})

-- load extensions
local ext = (require 'telescope').load_extension
pcall(ext, 'fzf')
pcall(ext, 'file_browser')
pcall(ext, 'ui-select')
pcall(ext, 'undo')

-- maps
local builtin = require('telescope.builtin')

local function nkmap(keys, command, opts)
  opts = { noremap = true, silent = true }
  vim.keymap.set('n', keys, command, opts)
end

function FuzzyGrep()
  builtin.grep_string({
    path_display = { 'smart' },
    only_sort_text = true,
    word_match = '-w',
    search = '',
  })
end

nkmap('<leader>?', builtin.oldfiles)
nkmap('<leader>o', builtin.find_files)
nkmap('<leader>gf', builtin.git_files)
nkmap('<leader><space>', builtin.buffers)
nkmap('<leader>l', builtin.buffers)
nkmap('<leader>/', builtin.current_buffer_fuzzy_find)
nkmap('<leader>sh', builtin.help_tags)
nkmap('<leader>sw', builtin.grep_string)
nkmap('<leader>q', function() builtin.diagnostics({ bufnr = 0, initial_mode = 'normal' }) end)
nkmap('<leader>Q', function() builtin.diagnostics({ initial_mode = 'normal' }) end)
nkmap('<leader>m', function() builtin.marks({ initial_mode = 'normal' }) end)
nkmap('<leader>sg', '<cmd>lua FuzzyGrep{}<CR>')
nkmap('<leader>e', '<cmd>Telescope file_browser<CR>')
nkmap('<leader>E', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>')
nkmap('<leader>u', '<cmd>Telescope undo<CR>')

