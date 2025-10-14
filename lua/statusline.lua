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
  local indicator = ''
  if mode == 'n' then
    indicator = '%#StatusNormal#'
  elseif mode == 'i' or mode == 'ic' then
    indicator = '%#StatusInsert#INSERT 󰏫 '
  elseif mode == 'v' then
    indicator = '%#StatusVisual#VISUAL 󰒉 '
  elseif mode == 'V' then
    indicator = '%#StatusVisual#VISUAL LINE 󰾂 '
  elseif mode == '' then
    indicator = '%#StatusVisual#VISUAL BLOCK 󰫙 '
  elseif mode == 'R' then
    indicator = '%#StatusReplace#REPLACE  '
  elseif mode == 'c' then
    indicator = '%#StatusCommand#COMMAND  '
  elseif mode == 't' then
    indicator = '%#StatusTerminal#TERMINAL  '
  end
  return indicator
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

-- NOTE: complex regex searches will cause lag in large files
-- while this element is visible on the statusline
--
-- also see `:h maxmempattern`
local function search_count()
  if vim.v.hlsearch == 0 then
    return ''
  end
  local ok, s_count = pcall(vim.fn.searchcount,
    { recompute = true, maxcount = 999 })
  if not ok
      or s_count.current == nil
      or s_count.total == 0
  then return '' end
  if s_count.incomplete > 0 then return '?/?' end
  return ('[%s/%s]'):format(s_count.current, s_count.total)
end

local function grapple_tag_indicator()
  local g = require('grapple')
  local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)
  if g.exists({ buffer = bufnr }) then
    return ',' .. g.name_or_index({ buffer = bufnr })
  else
    return ''
  end
end

Status = {}

function Status.active()
  return table.concat {
    mode_indicator(),
    macro_recording(),
    '%#StatusActive#', -- reset color
    '%<',              -- truncate
    '%f',              -- buffer name
    file_color(),
    '%M',              -- modified flag
    '%#StatusLine#',   -- dimmer color
    '%H',              -- help flag
    '%R',              -- readonly flag
    grapple_tag_indicator(),
    lsp_diag(),
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
    '%f', -- buffer name
    file_color(),
    '%M',                 -- modified flag
    '%#StatusLineNCSep#', -- darker color
    '%H',                 -- help flag
    '%R',                 -- readonly flag
    grapple_tag_indicator(),
    '%<',                 -- truncate
    '%#StatusLineNCSep#', -- darker color
  }
end

local function statusfill()
  local function splits_present()
    local splits = 0
    for _, id in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(id).relative == '' then
        splits = splits + 1
      end
    end
    return splits > 1
  end

  if splits_present() then
    vim.opt_local.fillchars:append { stl = '─' }
  else
    vim.opt_local.fillchars:append { stl = ' ' }
  end
end

local status = Aug('statusline', { clear = true })

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

