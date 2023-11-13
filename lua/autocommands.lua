-- highlight on yank `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- jump to last known cursor position when opening a file
vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('curpos', { clear = true }),
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
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
local bufpos = vim.api.nvim_create_augroup('bufpos', { clear = true })
vim.api.nvim_create_autocmd({ 'BufLeave' }, {
  pattern = '*',
  group = bufpos,
  callback = function()
    vim.b[0].winview = vim.fn.winsaveview()
  end
})
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*',
  group = bufpos,
  callback = function()
    if vim.b[0].winview ~= nil then
      vim.fn.winrestview(vim.b[0].winview)
    end
  end
})

-- disable cursorline in insert mode and in inactive windows
local cline = vim.api.nvim_create_augroup('cline', { clear = true })
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
  pattern = '*',
  group = cline,
  command = 'setlocal cursorline',
})
vim.api.nvim_create_autocmd('WinLeave', {
  pattern = '*',
  group = cline,
  command = 'setlocal nocursorline',
})
vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  group = cline,
  command = 'set nocursorline'
})
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  group = cline,
  command = 'set cursorline'
})

-- spellcheck
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text', 'org', 'NeogitCommitMessage' },
  group = vim.api.nvim_create_augroup('splchk', { clear = true }),
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { 'en_us', 'cjk' }
    kmap('i', '<C-l>', '<ESC>[s1z=gi', { buffer = 0 })
  end
})

