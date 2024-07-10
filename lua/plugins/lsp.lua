local buf = vim.lsp.buf
local fzf = require('fzf-lua')
local mason_lsp = require('mason-lspconfig')
local mason = require('mason')

require('plugins.lsp_status')

-- run on attach
local on_attach = function()
  -- LSP
  Kmap('n', 'gd', function()
      fzf.lsp_definitions({ jump_to_single_result = true })
    end,
    'LSP: goto definition')
  Kmap('n', 'gD', buf.declaration,
    'LSP: goto declaration')
  Kmap('n', 'gr', fzf.lsp_references,
    'LSP: references')
  Kmap('n', 'gI', buf.implementation,
    'LSP: goto implementation')
  Kmap('n', 'K', buf.hover,
    'LSP: popup symbol info')
  Kmap('n', '<leader>k', buf.signature_help,
    'LSP: signature help')
  Kmap('i', '<C-l>', buf.signature_help,
    'LSP: signature help in insert mode')
  Kmap('n', '<leader>cn', buf.rename,
    'LSP: rename variable under cursor')
  Kmap('n', '<leader>ca', fzf.lsp_code_actions,
    'LSP: code actions')
  Kmap('n', '<leader>cs', fzf.lsp_document_symbols,
    'LSP: document symbols')
  Kmap('n', '<leader>cS', function()
      fzf.lsp_workspace_symbols({ fzf_cli_args = '--nth 2..' })
    end,
    'LSP: workspace symbols')
  Kmap('n', '<leader>cA', buf.add_workspace_folder,
    'LSP: add workspace folder')
  Kmap('n', '<leader>cR', buf.remove_workspace_folder,
    'LSP: remove workspace folder')
  Kmap('n', '<leader>cl', function()
      print(vim.inspect(buf.list_workspace_folders()))
    end,
    'LSP: list workspace folders')
  Kmap('n', '<leader>cd', fzf.lsp_typedefs,
    'LSP: type definitions')
  Kmap('n', '<leader>cf', buf.format,
    'LSP: format buffer')
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

  nil_ls = {},
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

