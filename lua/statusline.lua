local function macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return '%#StatusInsert#recording @' .. recording_register .. ' '
  end
end

local function mode_indicator()
  local mode = vim.api.nvim_get_mode().mode
  local color = ''
  if mode == 'n' then
    color = '%#Normal# '
  elseif mode == 'i' or mode == 'ic' then
    color = '%#StatusInsert#󰏫 '
  elseif mode == 'v' then
    color = '%#StatusVisual#󰒉 '
  elseif mode == 'V' then
    color = '%#StatusVisual#󰾂 '
  elseif mode == '' then
    color = '%#StatusVisual#󰫙 '
  elseif mode == 'R' then
    color = '%#StatusReplace# '
  elseif mode == 'c' then
    color = '%#StatusCommand# '
  elseif mode == 't' then
    color = '%#StatusTerminal# '
  end
  return color
end

local function file_color()
  local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)
  local modified = vim.api.nvim_get_option_value('modified', { buf = bufnr })
  local color = ''
  if modified then
    color = '%#StatusFile#'
  else
    color = '%#StatusLine#'
  end
  return color
end

local function lsp_diag()
  local count = {}
  local levels = {
    errors = vim.diagnostic.severity.ERROR,
    warnings = vim.diagnostic.severity.WARN,
    info = vim.diagnostic.severity.INFO,
    hints = vim.diagnostic.severity.HINT
  }
  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end
  local errors = ''
  local warnings = ''
  local hints = ''
  local info = ''
  if count['errors'] ~= 0 then
    errors = ' %#DiagnosticError#E' .. count['errors']
  end
  if count['warnings'] ~= 0 then
    warnings = ' %#DiagnosticWarn#W' .. count['warnings']
  end
  if count['hints'] ~= 0 then
    hints = ' %#DiagnosticHint#H' .. count['hints']
  end
  if count['info'] ~= 0 then
    info = ' %#DiagnosticInfo#I' .. count['info']
  end
  return errors .. warnings .. hints .. info
end

local function lsp_progress()
  local present, progress = pcall(require, 'lsp-progress')
  if not present then
    return ''
  else
    return progress.progress()
  end
end

local search_count = function(args)
  local ok, s_count = pcall(vim.fn.searchcount,
    (args or {}).options or { recompute = true })
  if not ok
      or s_count.current == nil
      or s_count.total == 0
      or vim.v.hlsearch == 0
  then
    return ''
  end
  if s_count.incomplete == 1 then return '?/?' end
  local too_many = ('>%d'):format(s_count.maxcount)
  local current = s_count.current > s_count.maxcount and too_many or s_count.current
  local total = s_count.total > s_count.maxcount and too_many or s_count.total
  return ('[%s/%s]'):format(current, total)
end

Status = {}

function Status.active()
  return table.concat {
    mode_indicator(),
    macro_recording(),
    '%#StatusActive#', -- reset color
    '%<',              -- truncate
    '%f ',             -- buffer name
    file_color(),
    '%M',              -- modified flag
    '%#StatusLine#',   -- dimmer color
    '%H',              -- help flag
    '%R',              -- readonly flag
    lsp_diag(),
    '%#Normal#',       -- accent color
    lsp_progress(),
    '%#StatusActive#', -- reset color
    '%=',              -- right align
    search_count(),
    '%-15.(%S%)',      -- min filled width 15; showcmd
    '%-14.(%l,%c%V%)', -- min filled width 14; ruler
    ' %P'              -- relative position
  }
end

function Status.inactive()
  return table.concat {
    '%f ',                -- buffer name
    file_color(),
    '%M',                 -- modified flag
    '%#StatusLineNCSep#', -- darker color
    '%H',                 -- help flag
    '%R',                 -- readonly flag
    '%<',                 -- truncate
    '%#StatusLineNCSep#', -- darker color
  }
end

local function statusfill()
  if #(vim.api.nvim_tabpage_list_wins(0)) > 1 then
    vim.opt_local.fillchars:append { stl = '─' }
  else
    vim.opt_local.fillchars:append { stl = ' ' }
  end
end

local status = Aug('statusline', { clear = true })

Auc({ 'User' }, {
  pattern = 'LspProgressStatusUpdated',
  group = status,
  callback = vim.schedule_wrap(function()
    vim.cmd('redrawstatus')
  end)
})

Auc({ 'WinEnter', 'BufEnter' }, {
  pattern = '*',
  group = status,
  callback = function()
    vim.opt_local.statusline = '%!v:lua.Status.active()'
    statusfill()
  end
})

Auc({ 'WinLeave', 'BufLeave' }, {
  pattern = '*',
  group = status,
  callback = function()
    vim.opt_local.statusline = '%!v:lua.Status.inactive()'
  end
})

