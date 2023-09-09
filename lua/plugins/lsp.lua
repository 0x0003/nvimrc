-- extra nvim lua configuration
-- load before lsp to fix Undefined Global 'vim'
require('neodev').setup()

local function kmap(mode, keys, command, opts)
  opts = { noremap = true, silent = true }
  vim.keymap.set(mode, keys, command, opts)
end

-- run on attach
local on_attach = function()
  -- LSP
  kmap('n', '<leader>rn', vim.lsp.buf.rename)
  kmap('n', '<leader>ca', vim.lsp.buf.code_action)
  kmap('n', 'gd', vim.lsp.buf.definition)
  kmap('n', 'gr', require('telescope.builtin').lsp_references)
  kmap('n', 'gI', vim.lsp.buf.implementation)
  kmap('n', '<leader>D', vim.lsp.buf.type_definition)
  kmap('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols)
  kmap('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols)
  kmap('n', 'K', vim.lsp.buf.hover)
  -- kmap('n','<C-k>', vim.lsp.buf.signature_help)
  -- Lesser used LSP functionality
  kmap('n', '<leader>F', vim.lsp.buf.format)
  kmap('n', 'gD', vim.lsp.buf.declaration)
  kmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
  kmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
  kmap('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end)
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = {
  -- hls = {}, -- NOTE: needs ghcup
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  tsserver = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- autoinstall servers
local present, mason = pcall(require, "mason")

if not present then
  return
end

mason.setup {
  ui = {
    icons = {
      package_installed = "o",
      package_pending = "~",
      package_uninstalled = "x",
    }
  }
}

local mason_lsp = require ("mason-lspconfig")

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

