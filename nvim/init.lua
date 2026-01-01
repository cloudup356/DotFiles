-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	{
 	 'nvim-lualine/lualine.nvim',
  	dependencies = { 'nvim-tree/nvim-web-devicons' }
	},

	{
    	'nvim-telescope/telescope.nvim', tag = 'v0.1.9',
     	dependencies = { 'nvim-lua/plenary.nvim' }
    	},

	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
},
    	lazy = false, 
}, 

{
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
}

    -- add your plugins here
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<C-q>', ':Neotree filesystem toggle reveal left<cr>', { desc = 'Toggle Neo-tree' })

vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')


require("mason").setup()

require("mason-lspconfig").setup ({

    ensure_installed = { "lua_ls", "rust_analyzer",
	"clangd", "asm_lsp", "pyright", "autotools_ls", "sqlls", "gopls", "html", "cssls", "zls"
	},
	automatic_installation = true,

})





local config = require("nvim-treesitter.configs")
config.setup({
	ensure_installed = {"python", "javascript", "c", "cmake", "cpp", "css", "html", "java", "kotlin", 
	"markdown", "printf", "rust", "sql", "zig", "php", "go", "dockerfile", "asm"},
	highlight = { enable = true},
	indent = { enable = true},
})


vim.opt.number = true

vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.opt.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.opt.relativenumber = true
	end,
})



require('lualine').setup {
  options = {
    theme = 'auto', 
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    globalstatus = true, 
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
}

