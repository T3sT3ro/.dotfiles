return {
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highligh = { enable = true },
      indent = { enable = true },
      ensure_installed = { "html", "css", "bash", "lua" },
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "v",
          node_decremental = "V",
        },
      }
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
      require "configs.lspconfig"
    end,
  },

  -- multi-cursors - not yet configured
  -- https://github.com/mg979/vim-visual-multi
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    config = function() end,
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

  -- AI autocomplete plugin
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
  },

  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },

  -- LSP filter window
  {
    "stevearc/dressing.nvim",
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  {
    "TobinPalmer/Tip.nvim",
    event = "VimEnter",
    init = function()
      -- Default config
      --- @type Tip.config
      require("tip").setup({
        seconds = 2,
        title = "Tip!",
        url = "https://vtip.43z.one", -- Or https://vimiscool.tech/neotip
      })
    end,
  }
}
