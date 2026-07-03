-- NOTE: ORDER MATTERS!
-- The plugins are loaded top to bottom. This also applies to
-- plugins that are specified to lazy load on the same event
local plugins = {
  -- colorscheme
  {
    src = 'https://github.com/RRethy/nvim-base16',
    config = 'plugins.base16'
  },

  -- nerdfont icons
  {
    src = 'https://github.com/nvim-mini/mini.icons',
    config = 'plugins.mini-icons'
  },

  -- fuzzy finder
  {
    src = 'https://github.com/ibhagwan/fzf-lua',
    config = 'plugins.fzf'
  },

  -- file browser
  {
    src = 'https://github.com/stevearc/oil.nvim',
    config = 'plugins.oil',
    bundled = {
      { src = 'https://github.com/0x0003/oil-grapple.nvim' }
    }
  },

  -- file navigation through custom marks
  {
    src = 'https://github.com/cbochs/grapple.nvim',
    config = 'plugins.grapple'
  },

  -- git integration
  {
    src = 'https://github.com/lewis6991/gitsigns.nvim',
    config = 'plugins.git',
    bundled = {
      { src = 'https://github.com/tpope/vim-fugitive' }
    }
  },

  -- detect tabstop and shiftwidth automatically
  {
    src = 'https://github.com/tpope/vim-sleuth'
  },

  -- indent guides
  {
    src = 'https://github.com/lukas-reineke/indent-blankline.nvim',
    config = 'plugins.ibl'
  },

  -- visualize rgb and hex values
  {
    src = 'https://github.com/catgoose/nvim-colorizer.lua',
    config = 'plugins.colorizer',
    events = 'BufEnter'
  },

  -- surround text objects
  {
    src = 'https://github.com/kylechui/nvim-surround',
    version = vim.version.range('4.x'),
    config = 'plugins.surround'
  },

  -- autocompletion
  {
    src = 'https://github.com/saghen/blink.cmp',
    version = vim.version.range('1.x'),
    config = 'plugins.blink',
    bundled = {
      { src = 'https://github.com/rafamadriz/friendly-snippets' },
      {
        src = 'https://github.com/L3MON4D3/LuaSnip',
        version = vim.version.range('v2.x')
      },
    },
    events = 'InsertEnter'
  },

  -- LSP
  {
    src = 'https://github.com/neovim/nvim-lspconfig',
    config = 'plugins.lsp',
  },
  {
    src = 'https://github.com/folke/lazydev.nvim',
    config = function() require('lazydev').setup() end,
    events = 'FileType',
    pattern = 'lua'
  },

  -- visualize undo history
  {
    src = 'https://github.com/mbbill/undotree',
    config = 'plugins.undotree'
  },

  -- syntax hl
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    config = 'plugins.treesitter',
    bundled = {
      {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'
      }
    }
  }
}

local pack_startup = Aug('PackStartup', { clear = true })

-- treesitter update hook
Auc('PackChanged', {
  group = pack_startup,
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
    end
  end
})

local configured = {}

local function load_plugin(plugin)
  if configured[plugin.src] then return end
  configured[plugin.src] = true
  vim.pack.add(vim.list_extend({
    {
      src = plugin.src,
      version = plugin.version,
    },
  }, plugin.bundled or {}))
  if plugin.config then
    local loader
    if type(plugin.config) == 'string' then
      loader = function()
        require(plugin.config)
      end
    else loader = plugin.config end
    local ok, err = pcall(loader)
    if not ok then
      error(
        ('Failed loading plugin config "%s":\n%s')
        :format(plugin.config, err)
      )
    end
  end
end

for _, plugin in ipairs(plugins) do
  if plugin.events then
    Auc(plugin.events, {
      group = pack_startup,
      once = true,
      pattern = plugin.pattern,
      callback = function()
        load_plugin(plugin)
      end,
    })
  else
    load_plugin(plugin)
  end
end

