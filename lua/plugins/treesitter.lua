---@diagnostic disable: missing-fields
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'c', 'haskell', 'nix', 'lua', 'python', 'bash', 'fish',
    'javascript', 'typescript', 'vimdoc', 'vim', 'css', 'html',
    'yaml', 'toml', 'markdown', 'markdown_inline', 'regex'
  },

  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<leader>ti',
      scope_incremental = '<leader>ts',
      node_incremental = '<leader>tn',
      node_decremental = '<leader>tN',
    },
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- automatically jump forward to textobj
      keymaps = {
        -- use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },

    move = {
      enable = true,
      set_jumps = true, -- add jumps to jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },

    swap = {
      enable = true,
      swap_next = {
        ['<leader>>'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader><'] = '@parameter.inner',
      },
    },
  },
}

