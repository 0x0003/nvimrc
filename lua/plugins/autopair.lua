local ua = require('ultimate-autopair')

ua.setup({
  bs = {
    map = { '<bs>', '<C-h>' },
    cmap = { '<bs>', '<C-h>' },
  },
})

vim.api.nvim_create_user_command('AutopairToggle', function()
  ua.toggle()
end, {})

