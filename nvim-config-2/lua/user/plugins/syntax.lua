return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { 
          "python", "javascript", "c", "cmake", "cpp", "rust", "lua", "go" 
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  }
}
