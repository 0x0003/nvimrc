local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup

-- highlight on yank `:help vim.highlight.on_yank()`
local highlight_group = aug('YankHighlight', { clear = true })
au('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- jump to last known cursor position when opening a file
au('BufRead', {
  group = aug('curpos', { clear = true }),
  callback = function(opts)
    au('BufWinEnter', {
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
local bufpos = aug('bufpos', { clear = true })
au({ 'BufLeave' }, {
  pattern = '*',
  group = bufpos,
  callback = function()
    vim.b[0].winview = vim.fn.winsaveview()
  end
})
au({ 'BufEnter' }, {
  pattern = '*',
  group = bufpos,
  callback = function()
    if vim.b[0].winview ~= nil then
      vim.fn.winrestview(vim.b[0].winview)
    end
  end
})

-- disable cursorline in insert mode and in inactive windows
local cline = aug('cline', { clear = true })
au({ 'WinEnter', 'BufWinEnter' }, {
  pattern = '*',
  group = cline,
  command = 'setlocal cursorline',
})
au('WinLeave', {
  pattern = '*',
  group = cline,
  command = 'setlocal nocursorline',
})
au('InsertEnter', {
  pattern = '*',
  group = cline,
  command = 'set nocursorline'
})
au('InsertLeave', {
  pattern = '*',
  group = cline,
  command = 'set cursorline'
})

-- spellcheck
au('FileType', {
  pattern = { 'markdown', 'text', 'org', 'NeogitCommitMessage' },
  group = aug('splchk', { clear = true }),
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { 'en_us', 'cjk' }
    kmap('i', '<C-l>', '<ESC>[s1z=gi', { buffer = 0 })
  end
})

