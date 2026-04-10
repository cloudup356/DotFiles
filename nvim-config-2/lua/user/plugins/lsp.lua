return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { 
          "lua_ls", "rust_analyzer", "clangd", "pyright", "gopls" 
        },
        automatic_installation = true,
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      
      vim.lsp.config('clangd', {
        capabilities = capabilities,
      })

      vim.lsp.config('lua_ls', { capabilities = capabilities })
      vim.lsp.config('pyright', { capabilities = capabilities })
      vim.lsp.config('rust_analyzer', { capabilities = capabilities })
      vim.lsp.config('gopls', { capabilities = capabilities })

      vim.lsp.enable('clangd')
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('pyright')
      vim.lsp.enable('rust_analyzer')
      vim.lsp.enable('gopls')
    end,
  }
}
