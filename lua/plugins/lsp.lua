local buf = vim.lsp.buf
local tele = require('telescope.builtin')
local mason_lsp = require('mason-lspconfig')
local mason = require('mason')

-- run on attach
local on_attach = function()
  -- LSP
  kmap('n', 'gd', function()
    tele.lsp_definitions({ initial_mode = 'normal' })
  end)
  kmap('n', 'gD', buf.declaration)
  kmap('n', 'gr', tele.lsp_references)
  kmap('n', 'gI', buf.implementation)
  kmap('n', 'K', buf.hover)
  kmap('n', '<leader>k', buf.signature_help)
  kmap('n', '<leader>cn', buf.rename)
  kmap('n', '<leader>ca', buf.code_action)
  kmap('n', '<leader>cs', tele.lsp_document_symbols)
  kmap('n', '<leader>cS', tele.lsp_dynamic_workspace_symbols)
  kmap('n', '<leader>cA', buf.add_workspace_folder)
  kmap('n', '<leader>cR', buf.remove_workspace_folder)
  kmap('n', '<leader>cl', function()
    print(vim.inspect(buf.list_workspace_folders()))
  end)
  kmap('n', '<leader>cd', function()
    tele.lsp_type_definitions({ initial_mode = 'normal' })
  end)
  kmap('n', '<leader>cf', buf.format)
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = {
  hls = {},

  html = {
    filetypes = { 'html', 'twig', 'hbs' }
  },

  tsserver = {},

  lua_ls = {},
}

-- autoinstall servers
mason.setup {
  ui = {
    icons = {
      package_installed = 'o',
      package_pending = '~',
      package_uninstalled = 'x',
    }
  }
}

mason_lsp.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lsp.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- display LSP progress in statusline
require('lsp-progress').setup({
  max_size = 70,
  format = function(client_messages)
    if #client_messages > 0 then
      return ' ' .. table.concat(client_messages, ' ')
    end
    return ''
  end,
})

