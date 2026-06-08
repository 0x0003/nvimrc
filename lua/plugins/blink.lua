local luasnip = require('luasnip')

require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_lua').load({
  paths = {
    vim.fn.stdpath('config') .. '/snippets'
  }
})

luasnip.config.setup({
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
  if ctx.source_name == "Path" then
    local is_unknown_type = vim.tbl_contains(
      { "link", "socket", "fifo", "char", "block", "unknown" },
      ctx.item.data.type
    )
    local mini_icon, mini_hl, _ = require("mini.icons").get(
      is_unknown_type and "os" or ctx.item.data.type,
      is_unknown_type and "" or ctx.label
    )
    if mini_icon then
      return mini_icon, mini_hl
    end
  end
  local mini_icon, mini_hl, _ = require("mini.icons").get("lsp", ctx.kind)
  return mini_icon, mini_hl
end

require('blink.cmp').setup({
  keymap = {
    preset = 'none',

    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<C-y>'] = { 'select_and_accept', 'fallback' },

    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-j>'] = { 'snippet_forward', 'fallback' },
    ['<C-k>'] = { 'snippet_backward', 'fallback' },
  },

  appearance = {
    nerd_font_variant = 'mono'
  },

  completion = {
    documentation = {
      auto_show = true,
      scrollbar = false,
    },

    menu = {
      scrollbar = false,
      draw = {
        treesitter = { 'lsp' },
        components = {
          kind_icon = {
            -- text = function(ctx)
            --   local kind_icon, kind_hl = get_mini_icon(ctx)
            --   return kind_icon
            -- end,
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
          { "label",     "label_description", gap = 1 },
          { "kind_icon", "kind",              gap = 1 }
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
  },

  fuzzy = { implementation = "prefer_rust_with_warning" }
})

