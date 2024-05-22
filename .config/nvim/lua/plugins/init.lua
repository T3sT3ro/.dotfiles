return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("configs.conform")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = { "html", "css", "bash", "lua" },
		},
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			git = { enable = true },
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},

	-- multi-cursors - not yet configured
	-- https://github.com/mg979/vim-visual-multi
	{
		"mg979/vim-visual-multi",
		branch = "master",
		config = function()
			require("vim-visual-multi").setup({})
		end,
	},

	-- Sudo writes
	-- https://github.com/lambdalisue/suda.vim
	{
		"lambdalisue/suda.vim",
		config = function()
			require("suda").setup({})
		end,
	},

	-- undo tree
	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
		},
	},
}
