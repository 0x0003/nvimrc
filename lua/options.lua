local set = vim.o

set.nolangremap = true

set.termguicolors = true
set.shortmess = 'filnxtToFIO'
set.autoread = true
set.relativenumber = true          -- display line numbers relative to the cursor
set.numberwidth = 1
set.belloff = 'all'                -- don't nag me
set.novisualbell = true            -- ^
set.autoindent = true              -- keep indentation when inserting newline
set.encoding = 'utf-8'             -- character encoding used inside vim
set.scrolloff = 10                 -- lines to keep above/below the cursor
set.sidescrolloff = 10             -- chars to keep lelft/right of the cursor
set.splitbelow = true              -- default split locations
set.splitright = true              -- ^
set.lazyredraw = true              -- don't redraw screen while executing macros
set.hidden = true                  -- jump between buffers w/o writing them
set.backspace = 'indent,eol,start' -- backspace over everything
set.history = 100                  -- command line history
set.mouse = 'a'                    -- enable mouse
set.title = true                   -- set window title as open file
set.ttimeoutlen = 0                -- fast keys
set.nrformats = ''                 -- increment and subtract in decimal
set.showcmd = true                 -- display keypresses/size of the selected area
set.fillchars = 'vert: '           -- (space) char used to draw vertical borders
set.cursorline = true
-- set.laststatus = 1                  -- don't display statusline with only 1 window
-- set.colorcolumn = '80'              -- highlight 80th column
-- set.ruler = true                    -- display cursor and viewbuffer positions

-- statusline setup
set.laststatus = 3
set.showmode = false
set.cmdheight = 0
set.ruler = false
-- set.shortmess = 'nocI'

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
set.listchars = 'tab:■■,trail:»,nbsp:■'
set.list = true

-- detect if running under wsl
local in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil
if in_wsl then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ["+"] = 'clip.exe',
      ["*"] = 'clip.exe',
    },
    paste = {
      ["+"] = 'powershell.exe -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

