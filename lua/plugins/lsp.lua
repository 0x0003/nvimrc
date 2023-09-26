-- extra nvim lua configuration
-- load before lsp to fix Undefined Global 'vim'
require('neodev').setup()

local buf = vim.lsp.buf
local tele = require('telescope.builtin')

-- run on attach
local on_attach = function()
  -- LSP
  kmap('n', '<leader>rn', buf.rename)
  kmap('n', '<leader>ca', buf.code_action)
  kmap('n', 'gd', function()
    tele.lsp_definitions({ initial_mode = 'normal' })
  end)
  kmap('n', 'gr', tele.lsp_references)
  kmap('n', 'gI', buf.implementation)
  kmap('n', '<leader>D', function()
    tele.lsp_type_definitions({ initial_mode = 'normal' })
  end)
  kmap('n', '<leader>ds', tele.lsp_document_symbols)
  kmap('n', '<leader>ws', tele.lsp_dynamic_workspace_symbols)
  kmap('n', 'K', buf.hover)
  -- kmap('n','<C-k>', buf.signature_help)
  kmap('n', '<leader>F', buf.format)
  kmap('n', 'gD', buf.declaration)
  kmap('n', '<leader>wa', buf.add_workspace_folder)
  kmap('n', '<leader>wr', buf.remove_workspace_folder)
  kmap('n', '<leader>wl', function()
    print(vim.inspect(buf.list_workspace_folders()))
  end)
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = {
  hls = {}, -- NOTE: needs ghcup
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  tsserver = {},
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { 'kmap' }
      },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- autoinstall servers
local present, mason = pcall(require, 'mason')

if not present then
  return
end

mason.setup {
  ui = {
    icons = {
      package_installed = 'o',
      package_pending = '~',
      package_uninstalled = 'x',
    }
  }
}

local mason_lsp = require('mason-lspconfig')

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

