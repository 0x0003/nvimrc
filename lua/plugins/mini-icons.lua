require('mini.icons').setup({
  extension = {
    lock = {
      glyph = '󰌾',
      hl = 'MiniIconsGreen'
    }
  },

  file = {
    ['.ghci'] = {
      glyph = '󰅩',
      hl = 'MiniIconsPurple'
    },
    ['.envrc'] = {
      glyph = '',
      hl = 'MiniIconsGreen'
    },
    makefile = {
      hl = 'MiniIconsGreen'
    }
  }
})

MiniIcons.mock_nvim_web_devicons()

