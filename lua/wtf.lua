local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

return packer.startup(function()
  use({
    "wbthomason/packer.nvim",
  })
  use({
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("_lsp").setup()
    end,
  })
    use { "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("_null-ls")
    end
  }
  if Packer_Bootstrap then
    require("packer").sync()
  end
end)
