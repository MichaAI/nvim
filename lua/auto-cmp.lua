local kind_icons = {
  Class = "ﴯ",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Keyword = "",
  Method = "",
  Module = "",
  Operator = "",
  Property = "ﰠ",
  Reference = "",
  Snippet = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}

local cmp = require 'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) --Concatonate the icons with name of the item-kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        spell = "[Spellings]",
        zsh = "[Zsh]",
        buffer = "[Buffer]",
        ultisnips = "[Snip]",
        treesitter = "[Treesitter]",
        calc = "[Calculator]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        nvim_lsp_signature_help = "[Signature]",
        cmdline = "[Vim Command]"
      })[entry.source.name]
      return vim_item
    end,
  },
  mapping = {
    ['<C-M-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-M-j>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
	['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  completion = {
    keyword_length = 1,
  },
  matching = {
    disallow_fuzzy_matching = false,
  },
  sources = cmp.config.sources(  {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }, {
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'path' },
  })
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' },
  })
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' },
  }
})

local lspconfig = require('lspconfig')
local servers = { 'tailwindcss', 'tsserver', 'jsonls', 'eslint' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilites = capabilities,
  }
end

lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
