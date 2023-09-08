local present, telescope = pcall(require, "telescope")

if not present then
  return
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    file_ignore_patterns = {
      "%.jpg",
      "%.jpeg",
      "%.png",
    },
    prompt_prefix = "  ",
    selection_caret = "  ",
    entry_prefix = "  ",
    layout_strategy = "bottom_pane",
    sorting_strategy = "ascending", -- display results top -> bottom
    layout_config = {
      bottom_pane = {
        preview_width = 0.6,
        height = 20,
        prompt_position = "top"
      },
    },
  }
})

-- enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- maps
local builtin = require('telescope.builtin')

local function kmap(mode, keys, command, opts)
  opts = { noremap = true, silent = true }
  vim.keymap.set(mode, keys, command, opts)
end

function FuzzyGrep()
  builtin.grep_string({
    path_display = { 'smart' },
    only_sort_text = true,
    word_match = "-w",
    search = '',
  })
end

kmap('n', '<leader>?', builtin.oldfiles)
kmap('n', '<leader><space>', builtin.buffers)
kmap('n', '<leader>o', builtin.find_files)
kmap('n', '<leader>l', builtin.buffers)
kmap('n', '<leader>/', builtin.current_buffer_fuzzy_find)
kmap('n', '<leader>gf', builtin.git_files)
kmap('n', '<leader>sh', builtin.help_tags)
kmap('n', '<leader>sw', builtin.grep_string)
kmap('n', '<leader>sd', builtin.diagnostics)
kmap('n', '<leader>sg', '<cmd>lua FuzzyGrep{}<CR>')

