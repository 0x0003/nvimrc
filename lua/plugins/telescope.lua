local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local ext = (require 'telescope').load_extension

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<C-e>'] = actions.preview_scrolling_down,
        ['<C-y>'] = actions.preview_scrolling_up,
        ['<C-x>'] = actions.edit_command_line,
        ['<C-u>'] = false,
        ['<C-r>'] = actions.delete_buffer,
        ['<Esc>'] = actions.close,
        ['<C-c>'] = false,
      },
      n = {
        ['g?']    = actions.which_key,
        ['<C-r>'] = actions.delete_buffer,
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
      preview_width = 0.5,
      height = 25,
      prompt_position = 'top'
    },
  },

  extensions = {
    ['ui-select'] = {
      layout_strategy = 'cursor',
      initial_mode = 'normal',
      layout_config = {
        height = 10,
        width = 80,
        prompt_position = 'top'
      },
    },
  }
})

-- load extensions
ext('fzf')
ext('ui-select')

-- maps
Kmap('n', '<leader>.', builtin.resume)
Kmap('n', '<leader>?', builtin.oldfiles)
Kmap('n', '<leader>o', builtin.find_files)
Kmap('n', '<leader>go', builtin.git_files)
Kmap('n', '<leader>gc', builtin.git_status)
Kmap('n', '<leader><space>', builtin.buffers)
Kmap('n', '<leader>l', builtin.buffers)
Kmap('n', '<leader>/', builtin.current_buffer_fuzzy_find)
Kmap('n', '<leader>sh', builtin.help_tags)
Kmap('n', '<leader>sw', builtin.grep_string)
Kmap('n', '<leader>sg', function()
  builtin.grep_string({
    path_display = { 'smart' },
    only_sort_text = true,
    word_match = '-w',
    search = '',
  })
end)
Kmap('n', '<leader>q', function()
  builtin.diagnostics({ bufnr = 0, initial_mode = 'normal' })
end)
Kmap('n', '<leader>Q', function()
  builtin.diagnostics({ initial_mode = 'normal' })
end)
Kmap('n', '<leader>m', function()
  builtin.marks({ initial_mode = 'normal' })
end)
Kmap('n', 'z=', function()
  builtin.spell_suggest({ initial_mode = 'normal' })
end)

