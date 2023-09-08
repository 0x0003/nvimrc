local present, indent_blankline = pcall(require, "indent_blankline")

if not present then
  return
end

indent_blankline.setup {
  char = "",
  context_char = " ",
  show_current_context = true,
  show_trailing_blankline_indent = false,
  filetype_exclude = {
    "help",
    "terminal",
    "TelescopePrompt",
    "TelescopeResults"
  },
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
},
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
},
}

vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guibg=#333333 gui=nocombine]]

