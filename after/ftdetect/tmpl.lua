vim.filetype.add({
  extension = {
    tmpl = 'gotmpl',
  },
})

vim.treesitter.language.register('gotmpl', 'gotmpl')

vim.treesitter.query.add_directive('inject-go-tmpl!', function(_, _, bufnr, _, metadata)
---@diagnostic disable-next-line: param-type-mismatch
  local fname = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
  local ext = fname:match('%.(%w+)%.tmpl$')
  if ext then
    metadata['injection.language'] = ext
  end
end, {})

