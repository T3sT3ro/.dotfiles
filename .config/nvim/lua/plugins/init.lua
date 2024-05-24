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
		lazy = false,
	},

	-- undo tree
	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = { -- load the plugin only when using it's keybinding:
			-- { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
		},
	},

	-- another undo tree with fzf
	{
		"debugloop/telescope-undo.nvim",
		dependencies = { -- note how they're inverted to above example
			{
				"nvim-telescope/telescope.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
		},
		keys = {
			{ -- lazy style key map
				"<leader>u",
				"<cmd>Telescope undo<cr>",
				desc = "undo history",
			},
		},
		opts = {
			-- don't use `defaults = { }` here, do this in the main telescope spec
			extensions = {
				undo = {},
				-- no other extensions here, they can have their own spec too
			},
		},
		config = function(_, opts)
			-- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
			-- configs for us. We won't use data, as everything is in it's own namespace (telescope
			-- defaults, as well as each extension).
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
		end,
	},
}
