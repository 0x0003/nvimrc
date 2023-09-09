local modes = {
  ["n"] = "NORMAL", -- normal
  ["no"] = "NORMAL", -- normal
  ["v"] = "VISUAL", -- visual
  ["V"] = "VISUAL LINE", -- visual line
  [""] = "VISUAL BLOCK", -- visual block
  ["s"] = "SELECT", -- select
  ["S"] = "SELECT LINE", -- select line
  [""] = "SELECT BLOCK", -- select block
  ["i"] = "INSERT", -- insert
  ["ic"] = "INSERT", -- insert
  ["R"] = "REPLACE", -- replace
  ["Rv"] = "VISUAL REPLACE", -- visual replace
  ["c"] = "COMMAND", -- command
  ["cv"] = "VIM EX", -- vim ex
  ["ce"] = "EX", -- ex
  ["r"] = "PROMPT", -- prompt
  ["rm"] = "MOAR", -- moar
  ["r?"] = "CONFIRM", -- configm
  ["!"] = "SHELL", -- shell
  ["t"] = "TERMINAL", -- terminal
}

local function color()
  local mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLine#"
  if mode == "n" then
    mode_color = "%#StatusNormal#"
  elseif mode == "i" or mode == "ic" then
    mode_color = "%#StatusInsert#"
  elseif mode == "v" or mode == "V" or mode == "" then
    mode_color = "%#StatusVisual#"
  elseif mode == "R" then
    mode_color = "%#StatusReplace#"
  elseif mode == "c" then
    mode_color = "%#StatusCommand#"
  elseif mode == "t" then
    mode_color = "%#StatusTerminal#"
  end
  return mode_color
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
    errors = " %#StatusReplace#E" .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#StatusCommand#W" .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#StatusVisual#H" .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#StatusVisual#I" .. count["info"]
  end

  return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function filetype()
  return string.format(" %s ", vim.bo.filetype):upper()
end

local function macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

Status = function()
  return table.concat {
    "%#StatusInsert#",
    macro_recording(),
    color(),
    string.format("  %s", modes[vim.api.nvim_get_mode().mode]):upper(),
    "%#StatusActive#",
    " %f ", -- file path
    "%#StatusVisual#",
    "[%{FugitiveHead()}]", -- git branch
    lsp(),
    "%#StatusActive#",
    "%=", -- right align
    filetype(),
    color(),
    " %l:%c  ",
  }
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  pattern = "*",
  command = "setlocal statusline=%!v:lua.Status()",
})

