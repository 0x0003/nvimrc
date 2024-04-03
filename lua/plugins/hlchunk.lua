---@diagnostic disable: missing-fields
local hlc = require('hlchunk')
local c = require('colors.' .. Palette)

hlc.setup({
  indent = {
    enable = true,
    notify = false,
    use_treesitter = true,
    chars = { "│" },
    style = { c.base02 }
  },

  context = {
    enable = true,
    notify = false,
    use_treesitter = true,
    chars = { "│" },
    style = { c.base03 }
  },

  chunk = {
    enable = false,
    notify = false,
  },

  line_num = {
    enable = false,
    notify = false,
  },

  blank = {
    enable = false,
    notify = false,
  }
})

