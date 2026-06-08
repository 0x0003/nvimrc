-- highlight on yank `:help vim.highlight.on_yank()`
local highlight_group = Aug('YankHighlight', { clear = true })
Auc('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- jump to last known cursor position when opening a file
Auc('BufRead', {
  group = Aug('curpos', { clear = true }),
  callback = function(opts)
    Auc('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if not (ft:match('commit') and ft:match('rebase'))
            and last_known_line > 1
            and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})

-- keep window position when swtiching buffers
local bufpos = Aug('bufpos', { clear = true })
local winview = {}
Auc({ 'BufLeave' }, {
  pattern = '*',
  group = bufpos,
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    if not winview[bufnr] then
      winview[bufnr] = {}
    end
    winview[bufnr] = vim.fn.winsaveview()
  end
})
Auc({ 'BufEnter' }, {
  pattern = '*',
  group = bufpos,
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    if winview[bufnr]
        and not vim.api.nvim_get_option_value('diff', {})
    then
      vim.fn.winrestview(winview[bufnr])
      winview[bufnr] = nil
    end
  end
})

-- disable cursorline in insert mode and in inactive windows
local cline = Aug('cline', { clear = true })
Auc({ 'WinEnter', 'BufWinEnter' }, {
  pattern = '*',
  group = cline,
  command = 'setlocal cursorline',
})
Auc('WinLeave', {
  pattern = '*',
  group = cline,
  command = 'setlocal nocursorline',
})
Auc('InsertEnter', {
  pattern = '*',
  group = cline,
  command = 'set nocursorline'
})
Auc('InsertLeave', {
  pattern = '*',
  group = cline,
  command = 'set cursorline'
})

-- spellcheck
Auc('FileType', {
  pattern = { 'markdown', 'text', 'gitcommit' },
  group = Aug('splchk', { clear = true }),
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { 'en_us', 'cjk' }
    Kmap('i', '<C-l>', '<ESC>[s1z=gi',
      'Apply 1st suggestion on the 1st misspelled word before the cursor',
      { buffer = 0 })
  end
})

-- pandoc-flavored markdown syntax highlighting
Auc('BufReadPost', {
  pattern = '*.md',
  group = Aug('mdpandoc', { clear = true }),
  callback = function()
    vim.opt_local.syntax = 'markdown.pandoc'
  end
})

