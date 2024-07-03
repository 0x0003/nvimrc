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
Auc({ 'BufLeave' }, {
  pattern = '*',
  group = bufpos,
  callback = function()
    vim.b[0].winview = vim.fn.winsaveview()
  end
})
Auc({ 'BufEnter' }, {
  pattern = '*',
  group = bufpos,
  callback = function()
    if vim.b[0].winview ~= nil then
      vim.fn.winrestview(vim.b[0].winview)
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
  pattern = { 'markdown', 'text', 'org', 'NeogitCommitMessage' },
  group = Aug('splchk', { clear = true }),
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { 'en_us', 'cjk' }
    Kmap('i', '<C-l>', '<ESC>[s1z=gi', { buffer = 0 })
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

