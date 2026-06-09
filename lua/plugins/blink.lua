local ls = require('luasnip')

require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_lua').load({
  paths = {
    vim.fn.stdpath('config') .. '/snippets'
  }
})

ls.config.setup({
  history = false,
  enable_autosnippets = true,
  ext_opts = {
    [require('luasnip.util.types').choiceNode] = {
      active = {
        virt_text = { { '• Choice node', 'Normal' } }
      }
    }
  }
})

local function get_mini_icon(ctx)
  if ctx.source_name == 'Path' then
    local is_unknown_type = vim.tbl_contains(
      { 'link', 'socket', 'fifo', 'char', 'block', 'unknown' },
      ctx.item.data.type
    )
    local mini_icon, mini_hl, _ = require('mini.icons').get(
      is_unknown_type and 'os' or ctx.item.data.type,
      is_unknown_type and '' or ctx.label
    )
    if mini_icon then
      return mini_icon, mini_hl
    end
  else
    local _, mini_hl, _ = require('mini.icons').get('lsp', ctx.kind)
    return _, mini_hl
  end
end

--- @param cond function -> bool
--- @param action function
local function ls_map(cond, action)
  return function()
    if cond() then
      vim.schedule(function()
        action()
      end)
      return true -- consume key, prevent fallback
    end
    return false -- allow fallback
  end
end

require('blink.cmp').setup({
  fuzzy = { implementation = 'prefer_rust_with_warning' },

  cmdline = { enabled = false },

  keymap = {
    preset = 'none',

    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<C-y>'] = { 'select_and_accept', 'fallback' },

    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-j>'] = {
      ls_map(
        function() return ls.expand_or_jumpable() end,
        function() ls.expand_or_jump() end
      ), 'fallback',
    },
    ['<C-k>'] = {
      ls_map(
        function() return ls.locally_jumpable(-1) end,
        function() ls.jump(-1) end
      ), 'fallback'
    },

    ['<C-h>'] = {
      ls_map(
        function() return ls.choice_active() end,
        function() ls.change_choice(-1) end
      ), 'fallback'
    },
    ['<C-l>'] = {
      ls_map(
        function() return ls.choice_active() end,
        function() ls.change_choice(1) end
      ), 'fallback'
    }
  },

  appearance = {
    nerd_font_variant = 'mono'
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 300,
    },

    menu = {
      scrollbar = false,
      auto_show_delay_ms = 0,
      draw = {
        treesitter = { 'lsp' },
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon = get_mini_icon(ctx) or ctx.kind_icon
              return kind_icon
            end,
            highlight = function(ctx)
              local _, hl = get_mini_icon(ctx)
              return hl
            end,
          },
          kind = {
            highlight = function(ctx)
              local _, hl = get_mini_icon(ctx)
              return hl
            end,
          }
        },

        columns = {
          { 'label',     'label_description', gap = 1 },
          { 'kind_icon', 'kind',              gap = 1 }
        }
      }
    },

  },

  snippets = {
    preset = 'luasnip'
  },

  sources = {
    min_keyword_length = 2,

    default = { 'lsp', 'path', 'snippets', 'buffer' },

    providers = {
      snippets = {
        -- get rid of duplicates
        transform_items = function(_, items)
          local seen = {}
          local out = {}
          for _, item in ipairs(items) do
            if not seen[item.label] then
              seen[item.label] = true
              table.insert(out, item)
            end
          end
          return out
        end
      }
    }
  }
})

