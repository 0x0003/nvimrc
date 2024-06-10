local ns = require('nvim-surround')

ns.setup({
  keymaps = {
    normal = 'sa',
    normal_cur = 'saa',
    normal_line = 'sA',
    normal_cur_line = 'sAA',
    visual = 's',
    visual_line = 'S',
    delete = 'sd',
    change = 'sr',
    change_line = 'sR'
  }
})

