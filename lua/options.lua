local set = vim.opt

set.langremap = false

set.termguicolors = true
set.shortmess = 'filnxtToFIO'
set.autoread = true
set.relativenumber = true -- display line numbers relative to the cursor
set.numberwidth = 1 -- minimal number of columns to use for the line number
set.belloff = 'all' -- don't nag me
set.visualbell = false -- ^
set.autoindent = true -- keep indentation when inserting newline
set.encoding = 'utf-8' -- character encoding used inside vim
set.scrolloff = 5 -- lines to keep above/below the cursor
set.sidescrolloff = 30 -- chars to keep lelft/right of the cursor
set.splitbelow = true -- default split locations
set.splitright = true -- ^
set.lazyredraw = true -- don't redraw screen while executing macros
set.hidden = true -- jump between buffers w/o writing them
set.backspace = 'indent,eol,start' -- backspace over everything
set.history = 100 -- command line history
set.mouse = 'a' -- enable mouse
set.title = true -- set window title as open file
set.ttimeoutlen = 0 -- fast keys
set.nrformats = '' -- increment and subtract in decimal
set.showcmd = true -- display keypresses/size of the selected area
set.cursorline = true -- highlight a line that has the cursor on it
-- set.colorcolumn = '80' -- highlight 80th column

-- statusline setup
set.laststatus = 2
set.showmode = false
set.cmdheight = 0
set.ruler = false
set.showcmdloc = 'statusline'

-- characters used to draw:
set.fillchars:append('vert:│') -- vsplit borders
set.fillchars:append(',stl: ') -- active statusline fill
set.fillchars:append(',stlnc:─') -- inactive statusline fill

-- data to keep in session files
set.sessionoptions = 'blank,buffers,curdir,help,tabpages,winsize,terminal'

-- search format
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.hlsearch = true

-- undo, swap and backups
set.undofile = true
set.swapfile = false
set.backup = false

-- wildmenu
set.wildmenu = true
set.wildignorecase = true
set.wildignore = [[*.bmp,*.gif,*.jpg,*.png,*.ico,*.bak,*.mkv,
  *.ogg,*.webm,*.mp4,*.m4v,*.flac,*.alac,*.m4a,*.mp3,*.ape,
  *.wav,*.pdf,*.psd,*.zip,*.7z,*.tar,*.gz,*.exe,*.swp,
  node_modules/*,bower_components/*]]

-- tabs/spaces
set.expandtab = true
set.softtabstop = 2
set.shiftwidth = 2

-- list variables
set.listchars:append('tab:■■')
set.listchars:append(',trail:»')
set.listchars:append(',nbsp:■')
set.list = true

-- detect if running under wsl and handle clipboard accordingly
local in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil
if in_wsl then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
end

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
        if
            not (ft:match('commit') and ft:match('rebase'))
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

