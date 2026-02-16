return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto',
          globalstatus = true,
        },
      })
    end,
  },
  -- Dashboard (Start Screen)

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup({
        theme = 'hyper',
        config = {
         header = {
          " ██████  █████                                 ███                  ",
          "▒▒██████ ▒▒███                                 ▒▒▒                  ",
          " ▒███▒███ ▒███  ██████   ██████  █████ █████ ████  █████████████  ",
          " ▒███▒▒███▒███ ███▒▒███ ███▒▒███▒▒███ ▒▒███ ▒▒███ ▒▒███▒▒███▒▒███ ",
          " ▒███ ▒▒██████ ▒███████ ▒███ ▒███ ▒███  ▒███  ▒███  ▒███ ▒███ ▒███ ",
          " ▒███  ▒▒█████ ▒███▒▒▒  ▒███ ▒███ ▒▒███ ███   ▒███  ▒███ ▒███ ▒███ ",
          " █████  ▒▒█████▒▒██████ ▒▒██████   ▒▒█████    █████ █████▒███ █████",
          "▒▒▒▒▒    ▒▒▒▒▒  ▒▒▒▒▒▒   ▒▒▒▒▒▒     ▒▒▒▒▒    ▒▒▒▒▒ ▒▒▒▒▒ ▒▒▒ ▒▒▒▒▒ ",
          "", -- Empty line for spacing
        },
          shortcut = {
            { desc = '󰈞 Find File', action = 'Telescope find_files', key = 'f' },
            { desc = '󰒲 Lazy', action = 'Lazy', key = 'l' },
            { desc = '󰈭 Quit', action = 'qa', key = 'q' },
          },
	packages = { enable = false },
	footer = {},
        },
      })
    end,
  }
}
