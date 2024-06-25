local buf = vim.lsp.buf
local tele = require('telescope.builtin')
local mason_lsp = require('mason-lspconfig')
local mason = require('mason')

require('plugins.lsp_status')

-- run on attach
local on_attach = function()
  -- LSP
  Kmap('n', 'gd', function()
    tele.lsp_definitions({ initial_mode = 'normal' })
  end)
  Kmap('n', 'gD', buf.declaration)
  Kmap('n', 'gr', tele.lsp_references)
  Kmap('n', 'gI', buf.implementation)
  Kmap('n', 'K', buf.hover)
  Kmap('n', '<leader>k', buf.signature_help)
  Kmap('i', '<C-l>', buf.signature_help)
  Kmap('n', '<leader>cn', buf.rename)
  Kmap('n', '<leader>ca', buf.code_action)
  Kmap('n', '<leader>cs', tele.lsp_document_symbols)
  Kmap('n', '<leader>cS', tele.lsp_dynamic_workspace_symbols)
  Kmap('n', '<leader>cA', buf.add_workspace_folder)
  Kmap('n', '<leader>cR', buf.remove_workspace_folder)
  Kmap('n', '<leader>cl', function()
    print(vim.inspect(buf.list_workspace_folders()))
  end)
  Kmap('n', '<leader>cd', function()
    tele.lsp_type_definitions({ initial_mode = 'normal' })
  end)
  Kmap('n', '<leader>cf', buf.format)
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

