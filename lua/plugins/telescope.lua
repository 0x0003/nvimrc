local present, telescope = pcall(require, "telescope")

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
        ['<C-h>'] = "which_key",
        ['<C-d>'] = require('telescope.actions').delete_buffer,
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
        height = 25,
        prompt_position = "top"
      },
    },
  },

  extensions = {
    file_browser = {
      hijack_netrw = true,
      disable_devicons = true,
      layout_strategy = "vertical",
      initial_mode = "normal",
      layout_config = {
        vertical = {
          preview_height = 0.4,
          height = 500,
          width = 500,
          prompt_position = "top"
        },
      },
    }
  }
})

-- enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
-- enable file browser
pcall(require('telescope').load_extension, 'file_browser')

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
kmap('n', '<leader>o', builtin.find_files)
kmap('n', '<leader>gf', builtin.git_files)
kmap('n', '<leader><space>', builtin.buffers)
kmap('n', '<leader>l', builtin.buffers)
kmap('n', '<leader>/', builtin.current_buffer_fuzzy_find)
kmap('n', '<leader>sh', builtin.help_tags)
kmap('n', '<leader>sw', builtin.grep_string)
kmap('n', '<leader>sd', builtin.diagnostics)
kmap('n', '<leader>sg', '<cmd>lua FuzzyGrep{}<CR>')
kmap('n', '<leader>e', '<cmd>Telescope file_browser<CR>')
kmap('n', '<leader>E', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>')

