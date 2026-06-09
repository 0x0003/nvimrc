local ui2 = require("vim._core.ui2")
ui2.enable({
  enable = true,
  msg = {
    targets = {
      progress = 'msg'
    },
    msg = {
      timeout = 2000
    }
  }
})

Auc('LspProgress', {
  group = Aug('LspStatus', { clear = true }),
  callback = function(ev)
    local value = ev.data.params.value
    vim.api.nvim_echo(
      { { value.message or 'Done', 'StatusNormal' } }, false,
      {
        id = 'lsp.' .. ev.data.client_id,
        kind = 'progress',
        source = 'vim.lsp',
        title = value.title,
        status = value.kind ~= 'end' and 'running' or 'success',
        -- percent = value.percentage
      })
    vim.api.nvim_set_option_value(
      "winhighlight",
      "Normal:StatusNormal,FloatBorder:StatusNormal",
      { scope = "local", win = ui2.wins.msg }
    )
    vim.api.nvim_win_set_config(ui2.wins.msg, {
      relative = "editor",
      anchor = "SE",
      row = vim.o.lines - 1,
      col = vim.o.columns - 1,
      border = "solid",
    })
  end
})

