local ua = require('ultimate-autopair')

ua.setup({
  bs = {
    map = { '<bs>', '<C-h>' },
    cmap = { '<bs>', '<C-h>' },
  },
})

Com('AutopairToggle', function()
  ua.toggle()
end, {})

