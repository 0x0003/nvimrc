local present, indent_blankline = pcall(require, 'indent_blankline')

if not present then
  return
end

indent_blankline.setup {
  filetype_exclude = {
    'help',
    'terminal',
    'TelescopePrompt',
    'TelescopeResults'
  },
  show_current_context = true,
  show_trailing_blankline_indent = false,
}

vim.cmd('hi IndentBlanklineContextChar guifg=#555555')

