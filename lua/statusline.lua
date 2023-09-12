local function macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "%#StatusInsert#  recording @" .. recording_register
  end
end

local modes = {
  ["n"] = "normal",          -- normal
  ["no"] = "normal",         -- normal
  ["v"] = "visual",          -- visual
  ["V"] = "visual line",     -- visual line
  [""] = "visual block",   -- visual block
  ["s"] = "select",          -- select
  ["S"] = "select line",     -- select line
  [""] = "select block",   -- select block
  ["i"] = "insert",          -- insert
  ["ic"] = "insert",         -- insert
  ["R"] = "replace",         -- replace
  ["Rv"] = "visual replace", -- visual replace
  ["c"] = "command",         -- command
  ["cv"] = "vim ex",         -- vim ex
  ["ce"] = "ex",             -- ex
  ["r"] = "prompt",          -- prompt
  ["rm"] = "moar",           -- moar
  ["r?"] = "confirm",        -- confirm
  ["!"] = "shell",           -- shell
  ["t"] = "terminal",        -- terminal
}

local function mode_color()
  local mode = vim.api.nvim_get_mode().mode
  local color = "%#StatusLine#"
  if mode == "n" then
    color = "%#StatusNormal#"
  elseif mode == "i" or mode == "ic" then
    color = "%#StatusInsert#"
  elseif mode == "v" or mode == "V" or mode == "" then
    color = "%#StatusVisual#"
  elseif mode == "R" then
    color = "%#StatusReplace#"
  elseif mode == "c" then
    color = "%#StatusCommand#"
  elseif mode == "t" then
    color = "%#StatusTerminal#"
  end
  return color
end

local function git_branch()
  local head = vim.api.nvim_call_function("FugitiveHead", {})
  if head == "" then
    return ""
  else
    return "%#StatusVisual# " .. head
  end
end

local function lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }
  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end
  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""
  if count["errors"] ~= 0 then
    errors = " %#DiagnosticError#E" .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#DiagnosticWarn#W" .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#DiagnosticHint#H" .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#DiagnosticInfo#I" .. count["info"]
  end
  return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function filetype()
  return string.format(" %s", vim.bo.filetype):upper()
end

local function encoding()
  return string.format(" %s ", vim.bo.fileencoding):upper()
end

local function format()
  return string.format("%s", vim.bo.fileformat):upper()
end

Status = function()
  return table.concat {
    macro_recording(),
    mode_color(),
    string.format("  %s", modes[vim.api.nvim_get_mode().mode]):upper(),
    "%#StatusActive#", -- reset color
    " %f ",            -- file path
    "%#StatusVisual#",
    git_branch(),
    lsp(),
    "%#StatusActive#", -- reset color
    "%=",              -- right align
    filetype(),
    encoding(),
    format(),
    mode_color(),
    " %l:%c  ",
  }
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup('statusline', { clear = true }),
  pattern = "*",
  command = "setlocal statusline=%!v:lua.Status()",
})

