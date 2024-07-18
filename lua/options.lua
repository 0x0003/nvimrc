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

-- wrap long lines
set.wrap = true
set.linebreak = true
set.showbreak = '› '

-- statusline setup
set.laststatus = 2
set.showmode = false
set.cmdheight = 0
set.ruler = false
set.showcmdloc = 'statusline'

-- characters used to draw:
set.fillchars = {
  vert = '│', -- vsplit borders
  stl = ' ', -- active statusline fill
  stlnc = '─' -- inactive statusline fill
}

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
set.wildignore = {
  '*.bmp', '*.gif', '*.jpg', '*.jpeg', '*.png', '*.ico',
  '*.bak', '*.mkv', '*.ogg', '*.webm', '*.mp4', '*.m4v',
  '*.flac', '*.alac', '*.m4a', '*.mp3', '*.ape', '*.wav',
  '*.pdf', '*.psd', '*.zip', '*.7z', '*.tar', '*.gz',
  '*.exe', '*.swp', '*.svg',
  'node_modules/*', 'bower_components/*', '.direnv/*',
  '.git/*', 'cache/*'
}

-- tabs/spaces
set.expandtab = true
set.softtabstop = 2
set.shiftwidth = 2

-- list variables
set.list = true
set.listchars = {
  tab = '⭾━━',
  trail = '»',
  nbsp = '⍽',
}

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

