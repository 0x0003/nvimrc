local fzf = require('fzf-lua')
local actions = require('fzf-lua.actions')

-- use same ignore rules as `:set wildignore`
local function ignored_patterns()
  local t = vim.opt.wildignore:get()
  for x, y in ipairs(t) do
    if string.find(y, '/') ~= nil then
      t[x] = y:gsub('.', { ['/'] = '', ['*'] = '' })
    else
      t[x] = y
    end
  end
  return t
end

---@param height? integer # default 0.55
---@param layout? string # horizontal|vertical|flex; default flex
---@param preview_h? integer # default 60%
---@param preview_v? integer # default 50%
---@return table
local function win_large(height, layout, preview_h, preview_v)
  local t = {
    height = height or 0.55,
    preview = {
      layout = layout or 'flex',
      horizontal = 'right:' .. (preview_h or 60) .. '%',
      vertical = 'down:' .. (preview_v or 50) .. '%'
    },
  }
  return t
end

fzf.setup({
  defaults = {
    file_icon_padding = '',
    file_icons = true,
    git_icons = false,
    no_action_zz = true,
    actions = {
      ['ctrl-q'] = actions.file_sel_to_qf,
      ['ctrl-u'] = false,
      ['ctrl-d'] = false,
      ['ctrl-y'] = false,
      ['ctrl-a'] = false,
    },
    keymap = {
      fzf = {
        ['ctrl-a'] = 'beginning-of-line',
        ['ctrl-u'] = 'unix-line-discard',
        ['ctrl-e'] = 'end-of-line',
        ['ctrl-y'] = 'preview-page-up',
        ['ctrl-d'] = 'preview-page-down',
      },
    },
  },

  winopts = {
    -- split = 'belowright new',
    row = 1,
    col = 0.50,
    height = 0.45,
    width = 1,
    border = { '─', '─', '─', '', '', '', '', '' },
    preview = {
      border = 'noborder',
      vertical = 'down:50%',
      horizontal = 'right:50%',
      delay = 0,
    },
  },

  fzf_opts = {
    ['--border'] = 'none',
  },

  fzf_colors = {
    ['bg+'] = { 'bg', 'CursorLine' },
    ['prompt'] = { 'fg', 'FzfLuaDirPart' },
  },

  -- pickers
  git = {
    status = {
      formatter = 'path.filename_first',
      actions = {
        ['ctrl-j'] = { fn = actions.git_stage, reload = true },
        ['ctrl-k'] = { fn = actions.git_unstage, reload = true },
        ['ctrl-x'] = false,
        ['right']  = false,
        ['left']   = false,
      },
      winopts = win_large(0.75, 'horizontal')
    },

    files = {
      git_icons = true,
    },

    branches = {
      actions = {
        ['ctrl-r'] = { fn = actions.git_branch_del, reload = true },
        ['ctrl-x'] = false,
        ['ctrl-g'] = {
          fn = actions.git_branch_add,
          field_index = "{q}",
          reload = true
        },
      }
    }
  },

  buffers = {
    formatter = 'path.filename_first',
    prompt = ':b ',
    previewer = false,
    no_header = true,
    actions = {
      ['ctrl-r'] = { fn = actions.buf_del, reload = true },
      ['ctrl-x'] = false,
    },
  },

  files = {
    previewer = 'cat',
    no_header = true,
    winopts = {
      preview = {
        layout = 'horizontal',
        delay = 100,
      },
    },
    -- cmd = 'rg --color=never --files --hidden --follow --g "!{' ..
    --     table.concat(ignored_patterns(), ',') ..
    --     '}"',
    fd_opts = '--color=never --type f --hidden --follow --exclude={' ..
        table.concat(ignored_patterns(), ',') ..
        '}'
  },

  grep = {
    prompt = ':Rg ',
    winopts = win_large(0.75, 'vertical')
  },

  blines = {
    prompt = '/',
    winopts = win_large(0.75, 'vertical')
  },

  lines = {
    prompt = '*/',
    winopts = win_large(0.75, 'vertical')
  },

  helptags = {
    prompt = ':h ',
    winopts = win_large(0.75, 'vertical')
  },

  lsp = {
    formatter = 'path.filename_first',
    winopts = win_large(0.75),
    symbols = {
      winopts = win_large(0.75, 'horizontal')
    },
  },

  diagnostics = {
    winopts = win_large(nil, 'horizontal'),
  },

  spell_suggest = {
    prompt = 'z= '
  },

  quickfix = {
    prompt = ':cc '
  },

  marks = {
    prompt = ':marks ',
    winopts = {
      preview = {
        layout = 'horizontal',
      },
    },
  },

  registers = {
    prompt = ':reg ',
    preview_opts = 'hidden'
  }
})

-- maps
Kmap('n', '<leader>.', fzf.resume,
  'FZF: resume previous search')
Kmap('n', '<leader>?', fzf.oldfiles,
  'FZF: previously opened files')
Kmap('n', '<leader>o', fzf.files,
  'FZF: files')
Kmap('n', '<leader>go', fzf.git_files,
  'FZF: git files')
Kmap('n', '<leader>gb', fzf.git_branches,
  'FZF: git branches')
Kmap('n', '<leader>gs', fzf.git_status,
  'FZF: git status')
Kmap('n', '<leader>l', fzf.buffers,
  'FZF: buffers')
Kmap('n', '<leader>/', fzf.blines,
  'FZF: fuzzy search current buffer')
Kmap('n', '<leader>sl', fzf.lines,
  'FZF: fuzzy search all buffers')
Kmap('n', '<leader>sh', fzf.helptags,
  'FZF: help tags')
Kmap('n', '<leader>sw', fzf.grep_cword,
  'FZF: grep string under cursor')
Kmap('n', '<leader>sg', function()
    fzf.grep({ search = '' })
  end,
  'FZF: fuzzy grep')
Kmap('n', '<leader>sf', fzf.live_grep_native,
  'FZF: live grep')
Kmap('n', '<leader>q', function()
    fzf.diagnostics_document({ fzf_cli_args = '--nth 2..' })
  end,
  'FZF: diagnostics in current buffer')
Kmap('n', '<leader>Q', fzf.diagnostics_workspace,
  'FZF: diagnostics in workspace')
Kmap('n', '<leader>m', fzf.marks,
  'FZF: marks')
Kmap('n', '<leader>r', fzf.registers,
  'FZF: registers')
Kmap('n', 'z=', fzf.spell_suggest,
  'FZF: spelling suggestions')
Kmap('n', '<leader>se', fzf.quickfix,
  'FZF: quickfix list')
Kmap('n', '<leader>sK', fzf.keymaps,
  'FZF: keymaps')

