local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local ext = (require 'telescope').load_extension

-- use same ignore rules as `:set wildignore`
-- NOTE: directories are not included
local function ignored_patterns()
  local t = vim.opt.wildignore:get()
  for x, y in ipairs(t) do
    if string.find(y, '/') ~= nil then
      -- t[x] = '^' .. string.gsub(y, '*', '')
      t[x] = nil
    else
      t[x] = string.gsub(y, '*', '%%')
    end
  end
  return t
end

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
    file_ignore_patterns = ignored_patterns(),
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
Kmap('n', '<leader>.', builtin.resume,
  'Telescope: resume previous search')
Kmap('n', '<leader>?', builtin.oldfiles,
  'Telescope: previously opened files')
Kmap('n', '<leader>o', builtin.find_files,
  'Telescope: find files')
Kmap('n', '<leader>go', builtin.git_files,
  'Telescope: git files')
Kmap('n', '<leader>gc', builtin.git_status,
  'Telescope: git status')
Kmap('n', '<leader>l', builtin.buffers,
  'Telescope: buffers')
Kmap('n', '<leader>/', builtin.current_buffer_fuzzy_find,
  'Telescope: fuzzy search current buffer')
Kmap('n', '<leader>sh', builtin.help_tags,
  'Telescope: help tags')
Kmap('n', '<leader>sw', builtin.grep_string,
  'Telescope: grep string under cursor')
Kmap('n', '<leader>sg', function()
    builtin.grep_string({
      path_display = { 'smart' },
      only_sort_text = true,
      word_match = '-w',
      search = '',
    })
  end,
  'Telescope: fuzzy search in all files')
Kmap('n', '<leader>sG', builtin.live_grep,
  'Telescope: live grep')
Kmap('n', '<leader>q', function()
    builtin.diagnostics({ bufnr = 0, initial_mode = 'normal' })
  end,
  'Telescope: diagnostics in current buffer')
Kmap('n', '<leader>Q', function()
    builtin.diagnostics({ initial_mode = 'normal' })
  end,
  'Telescope: diagnostics in workspace')
Kmap('n', '<leader>m', function()
    builtin.marks({ initial_mode = 'normal' })
  end,
  'Telescope: marks')
Kmap('n', 'z=', function()
    builtin.spell_suggest({ initial_mode = 'normal' })
  end,
  'Telescope: spelling suggestions')

